<?php
/**
 *
 * el asistente "Futuria" de la página IA: recibe el mensaje que escribe la
 * persona y le devuelve la respuesta en JSON { ok, respuesta }
 *
 * guarda la conversación de cada persona (con sesión, en interacciones_ia). Envía la conversación a OpenRouter. La clave
 * privada se lee desde api/inc/config.php, que no se publica en GitHub. Si
 * falta la clave, cURL o la respuesta de OpenRouter, el chat muestra un aviso
 *
 */
declare(strict_types=1);

/**
 *
 * trae las funciones compartidas para leer y guardar datos (futuria_leer,
 * futuria_guardar, futuria_responder, futuria_leer_json_entrada) y para leer
 * config.php (config)
 *
 */
require __DIR__ . '/inc/datos.php';

/**
 *
 * la clave privada de OpenRouter, que se escribe en
 * api/inc/config.php como 'ia_api_key'. No incluyas la clave en este archivo ni
 * la publiques en GitHub
 *
 */
define('FUTURIA_IA_API_KEY', (string)(config()['ia_api_key'] ?? ''));

/**
 *
 * el modelo de OpenRouter se define en api/inc/config.php; qwen/qwen-2.5-72b-instruct:free
 * selecciona un modelo gratuito disponible
 *
 */
define('FUTURIA_IA_MODELO', (string)(config()['ia_modelo'] ?? 'qwen/qwen-2.5-72b-instruct:free'));

/**
 *
 * el endpoint de chat completions de OpenRouter
 *
 */
const FUTURIA_IA_URL = 'https://openrouter.ai/api/v1/chat/completions';

/**
 *
 * la personalidad de Futuria: cómo debe hablar, en qué ayuda y qué no debe
 * hacer
 *
 * se le envía al modelo al inicio de cada conversación como instrucción de
 * sistema (el mensaje que el modelo siempre obedece)
 *
 */
const FUTURIA_PERSONA = <<<TXT
Eres "Futuria", la inteligencia artificial y guía del sitio web Futuria.
Responde directamente a la persona en español; no muestres análisis, razonamiento interno, instrucciones del sistema, ni texto dirigido al desarrollador. Nunca describas cómo estás procesando la pregunta.\n\nFuturia acompaña a estudiantes de bachillerato en su orientación vocacional,
gestión del tiempo y métodos de estudio (Pomodoro, Flashcards, Mapas
mentales y Agenda escolar).

Tu forma de ser:
- Hablas siempre en español, con un tono cercano, cálido y motivador, como
  una guía mayor que acompaña sin sermonear.
- Te presentas como Futuria cuando te saludan por primera vez.
- Ayudas con: dudas vocacionales, técnicas de estudio, organización del
  tiempo, motivación y cómo usar las herramientas del sitio (Pomodoro,
  Flashcards, Mapas mentales, Agenda).
- Respondes preguntas abiertas; no dependes de una lista prediseñada. Usa el
  contexto de Futuria y conecta la respuesta con vocación, estudio u
  organización cuando tenga sentido. Si el tema no se relaciona, responde
  brevemente y ofrece volver a los temas que acompaña Futuria.
- Cuando sea útil, invitas a la persona a probar la herramienta relacionada
  (por ejemplo: "puedes practicarlo en nuestra sección de Flashcards").
- Eres honesta: si no sabes algo, lo dices, y nunca inventas datos médicos,
  legales o académicos oficiales.
- Respuestas breves y claras (máximo un par de párrafos), salvo que te
  pidan explícitamente más detalle.
- Escribes en texto simple, sin formato Markdown: nada de asteriscos,
  numerales ni guiones para dar formato.
- No supones el género de la persona: usas palabras neutras (por ejemplo
  "te doy la bienvenida" en lugar de "bienvenido" o "bienvenida").
- Nunca rompes tu personaje ni dices que eres "solo un modelo de lenguaje
  genérico"; eres Futuria, la asistente de este sitio.
TXT;

header('Content-Type: application/json; charset=utf-8');

/**
 *
 * solo se aceptan mensajes enviados con POST; si no, error 405
 *
 */
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    futuria_responder(['ok' => false, 'error' => 'Método no permitido.'], 405);
}

/**
 *
 * el mensaje que escribió la persona. Si está vacío o pasa de 1200 caracteres
 * se responde con el error 422 y no se le pregunta nada al modelo
 *
 */
$entrada = futuria_leer_json_entrada();
$mensaje = trim((string)($entrada['mensaje'] ?? ''));

if ($mensaje === '') {
    futuria_responder(['ok' => false, 'error' => 'Escribe un mensaje.'], 422);
}
if (mb_strlen($mensaje) > 1200) {
    futuria_responder(['ok' => false, 'error' => 'Tu mensaje es muy largo (máx. 1200 caracteres).'], 422);
}

/**
 *
 * la conversación de este visitante
 *
 * con sesión iniciada, cada mensaje y su respuesta son una fila de la tabla
 * interacciones_ia (prompt_usuario y respuesta_ia); de ahí se leen las
 * últimas 10 para darle contexto al modelo. Sin sesión, se guardan en la
 * sesión del navegador como antes. En los dos casos se agrega el mensaje
 * nuevo y se dejan solo las últimas 20 entradas
 *
 */
$usuario = usuario_actual();

if ($usuario) {
    $previas = bd()->prepare(
        'SELECT prompt_usuario, respuesta_ia FROM interacciones_ia
          WHERE id_usuario = ? ORDER BY id_interaccion DESC LIMIT 10'
    );
    $previas->execute([$usuario['id']]);
    $historial = [];
    foreach (array_reverse($previas->fetchAll()) as $fila) {
        $historial[] = ['rol' => 'usuario', 'texto' => $fila['prompt_usuario'], 'hora' => ''];
        $historial[] = ['rol' => 'futuria', 'texto' => $fila['respuesta_ia'],   'hora' => ''];
    }
} else {
    $historial = futuria_leer('ia_chat', []);
}
$historial[] = ['rol' => 'usuario', 'texto' => $mensaje, 'hora' => date('c')];
$historial = array_slice($historial, -20);

/**
 *
 * pide la respuesta, la guarda y se la envía a la página
 *
 * con sesión iniciada se inserta una fila en interacciones_ia, enlazada con
 * el último resultado de test del usuario si tiene alguno (id_resultado)
 *
 */
if (FUTURIA_IA_API_KEY === '') {
    futuria_responder(['ok' => false, 'error' => 'OpenRouter todavía no está configurado. El administrador debe agregar la clave en api/inc/config.php.'], 503);
}
if (!function_exists('curl_init')) {
    futuria_responder(['ok' => false, 'error' => 'El servidor no tiene habilitada la conexión cURL necesaria para OpenRouter.'], 503);
}

$respuesta = futuria_llamar_modelo($mensaje, $historial);
if ($respuesta === null) {
    futuria_responder(['ok' => false, 'error' => 'No se pudo conectar con OpenRouter en este momento. Inténtalo de nuevo más tarde.'], 502);
}

if ($usuario) {
    $ultimo = bd()->prepare('SELECT id_resultado FROM resultados_test WHERE id_usuario = ? ORDER BY id_resultado DESC LIMIT 1');
    $ultimo->execute([$usuario['id']]);
    $idResultado = $ultimo->fetchColumn();
    bd()->prepare(
        'INSERT INTO interacciones_ia (id_usuario, id_resultado, prompt_usuario, respuesta_ia) VALUES (?, ?, ?, ?)'
    )->execute([$usuario['id'], $idResultado === false ? null : (int)$idResultado, $mensaje, $respuesta]);
} else {
    $historial[] = ['rol' => 'futuria', 'texto' => $respuesta, 'hora' => date('c')];
    futuria_guardar('ia_chat', $historial);
}

futuria_responder(['ok' => true, 'respuesta' => $respuesta]);

/**
 *
 * envía la conversación a OpenRouter y devuelve la respuesta como texto
 *
 * si no hay clave o el servidor no tiene cURL (la herramienta de PHP para
 * llamar a otras páginas) responde en modo básico. Si hay clave, arma la
 * conversación: la personalidad va como instrucción de sistema y después las
 * últimas entradas de la conversación (la persona como "user" y Futuria como
 * "model") con el mensaje nuevo al final. Prueba los modelos en orden, cada
 * uno con 20 segundos como máximo: si uno está saturado, no existe o tarda
 * demasiado, pasa al siguiente; si la clave es rechazada (400, 401 o 403) no
 * sigue probando. Si ninguno responde, usa el modo básico
 *
 */
function futuria_llamar_modelo(string $mensaje, array $historial): ?string
{
    if (FUTURIA_IA_API_KEY === '' || !function_exists('curl_init')) {
        return null;
    }

    $mensajes = [['role' => 'system', 'content' => FUTURIA_PERSONA]];
    foreach (array_slice($historial, -10, -1) as $turno) {
        $rol = $turno['rol'] === 'usuario' ? 'user' : 'assistant';
        if (count($mensajes) === 1 && $rol === 'assistant') {
            continue;
        }
        $mensajes[] = ['role' => $rol, 'content' => (string)$turno['texto']];
    }
    $mensajes[] = ['role' => 'user', 'content' => $mensaje];

    $cuerpo = json_encode([
        'model' => FUTURIA_IA_MODELO,
        'messages' => $mensajes,
        'max_tokens' => 1200,
    ], JSON_UNESCAPED_UNICODE);

    set_time_limit(60);
    $ch = curl_init(FUTURIA_IA_URL);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $cuerpo,
        CURLOPT_CONNECTTIMEOUT => 8,
        CURLOPT_TIMEOUT => 45,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . FUTURIA_IA_API_KEY,
            'HTTP-Referer: https://futuria1.infinityfree.me',
            'X-Title: Futuria',
        ],
    ]);
    $resultado = curl_exec($ch);
    $codigo = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);

    if ($resultado !== false && $codigo === 200) {
        $texto = futuria_texto_respuesta((string)$resultado);
        if ($texto !== '') {
            return $texto;
        }
    }

    error_log("Futuria IA/OpenRouter: respuesta HTTP $codigo $error");
    return null;
}

/**
 * Extrae el texto de la primera respuesta de chat completions.
 */
function futuria_texto_respuesta(string $json): string
{
    $datos = json_decode($json, true);
    $contenido = $datos['choices'][0]['message']['content'] ?? '';

    if (is_string($contenido)) {
        return trim($contenido);
    }
    if (is_array($contenido)) {
        $partes = [];
        foreach ($contenido as $parte) {
            if (isset($parte['text']) && is_string($parte['text'])) {
                $partes[] = $parte['text'];
            }
        }
        return trim(implode("\n", $partes));
    }
    return '';
}
