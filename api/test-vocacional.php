<?php
/**
 * Entrega el resumen y las dos pruebas vocacionales externas en JSON:
 * CHASIDE para explorar áreas profesionales y Holland/RIASEC para personalidad.
 */
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

function responder(array $datos, int $codigo = 200): void {
  http_response_code($codigo);
  echo json_encode($datos, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
  exit;
}

$resumen = 'Explora dos aspectos complementarios de tu futuro: tus intereses y aptitudes para distintas áreas profesionales, y los rasgos de personalidad que suelen relacionarse con diferentes entornos de trabajo. Son herramientas de orientación, no decisiones definitivas.';

$tests = [
  [
    'id'          => 'chaside',
    'nombre'      => 'Test CHASIDE · Áreas profesionales',
    'etiqueta'    => 'Intereses y aptitudes',
    'descripcion' => 'Explora tus intereses y aptitudes en áreas como ciencias, salud, arte, comunicación, administración y tecnología. El resultado puede ayudarte a identificar campos profesionales que vale la pena investigar.',
    'etiquetas'   => ['Áreas profesionales', 'Intereses', 'Aptitudes', 'Orientativo'],
    'boton'       => 'Explorar áreas profesionales',
    'enlace'      => 'https://orientacion-psicopedagogica.net/test/test-chaside/',
    'imagen'      => '../assets/img/test-2.svg',
  ],
  [
    'id'          => 'holland',
    'nombre'      => 'Test de personalidad Holland (RIASEC)',
    'etiqueta'    => 'Personalidad profesional',
    'descripcion' => 'Relaciona tus preferencias con seis perfiles: Realista, Investigador, Artístico, Social, Emprendedor y Convencional. Conoce los entornos y tipos de actividad que podrían encajar mejor contigo.',
    'etiquetas'   => ['Personalidad', '6 perfiles', 'RIASEC', 'Orientativo'],
    'boton'       => 'Conocer mi perfil',
    'enlace'      => 'https://www.orientacionuniversitaria.com/test-vocacional/test-de-holland/',
    'imagen'      => '../assets/img/test-3.svg',
  ],
];

responder([
  'ok'      => true,
  'resumen' => $resumen,
  'tests'   => $tests,
]);
