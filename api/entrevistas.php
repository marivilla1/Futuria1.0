<?php
/**
 *
 * le entrega a la página de entrevistas la lista de profesionales
 * entrevistados en JSON, una por cada área
 *
 * los datos están escritos aquí mismo. La página los pide con fetch() y arma
 * un acordeón: cada área se abre y muestra la foto, los dos consejos y el
 * reproductor con el audio de la entrevista
 *
 */
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

/**
 *
 * la lista de entrevistas. Cada una tiene el área, el nombre y la profesión
 * de la persona, la imagen, el audio, el consejo para quien aún no sabe qué
 * estudiar (orientacion) y el consejo para quien ya piensa en esa carrera
 *
 */
$entrevistas = [
  [
    'area'        => 'Transporte - Piloto de avión',
    'nombre'      => 'Jacobo Román',
    'profesion'   => 'Piloto de avión',
    'imagen'      => '../assets/img/piloto.jpg',
    'audio'       => '../assets/audio/jacobo.mp3',
    'pregunta1'   => '¿Qué le dirías a alguien que aún no sabe qué estudiar?',
    'orientacion' => 'Le diría que primero estudie algo que le guste. A mí me parece que estudiar algo que a uno no le gusta es un infierno. No debería elegir únicamente por tener un sustento económico. Me he dado cuenta de que, en cualquier área o campo que uno escoja, uno mismo se hace su destino.',
    'pregunta2'   => '¿Qué consejo le darías a alguien que quiere estudiar para ser piloto de avión?',
    'carrera'     => 'Primero, hay que ser consciente del compromiso que conlleva esta elección. No debe guiarse únicamente por el aspecto económico, porque trae consigo muchas dificultades, retos y decepciones y, sobre todo, requiere mucho autoconocimiento.',
  ],
  [
    'area'        => 'Marketing y creación de contenido',
    'nombre'      => 'Juan Felipe Restrepo Sánchez (El Ñe)',
    'profesion'   => 'Creador de contenido',
    'imagen'      => '../assets/img/stremer.jpg',
    'audio'       => '../assets/audio/ne.mp3',
    'pregunta1'   => '¿Cómo elegiste la carrera que estás estudiando?',
    'orientacion' => 'Es un proceso complejo. En mi caso requirió muchos cambios de ideas y decisiones. No fue hasta finales de mi último año de bachillerato que decidí lo que realmente quería hacer. Descubrí mi pasión por el marketing digital y la relacioné con distintos ámbitos que eran mi fuerte, lo que me llevó a estudiar Ingeniería Comercial.',
    'pregunta2'   => '¿Sientes que con tu trabajo ayudas a otras personas a decidir qué hacer en su futuro?',
    'carrera'     => 'Indirectamente puede influir. Como creador, busco hacer un vínculo con las personas, motivarlas y alegrarles el día: que puedan reírse, salir de la monotonía y, con base en mi experiencia, aconsejarlas para que eviten cometer los mismos errores que cometí.',
  ],
  [
    'area'        => 'Social y Humanidades - Abogado',
    'nombre'      => 'Sebastián Días Bolívar',
    'profesion'   => 'Abogado',
    'imagen'      => '../assets/img/abogado.jpg',
    'audio'       => '../assets/audio/sebastian.mp3',
    'pregunta1'   => '¿Qué le dirías a alguien que aún no sabe qué estudiar?',
    'orientacion' => 'Debe considerar varios aspectos. Es importante escoger algo que te llame la atención y se alinee con tus gustos; también debes considerar la salida laboral y económica. La combinación de estos aspectos es fundamental para escoger tu vocación.',
    'pregunta2'   => '¿Qué consejo le darías a alguien que va a estudiar Derecho?',
    'carrera'     => 'Que sea el mejor. Si vas a estudiar Derecho, dedícate completamente: lee más de lo que te dan en clase, estudia muchos libros y busca prácticas adicionales. No te quedes con lo mínimo; métete con muchas ganas y de lleno a estudiar Derecho.',
  ],
  [
    'area'        => 'Arte y cine - Dirección',
    'nombre'      => 'Victor Manuel Gaviria Gonzales',
    'profesion'   => 'Director de cine',
    'imagen'      => '../assets/img/victor-cine.jpg',
    'video'       => '../assets/video/VICTOR.mp4',
    'pregunta1'   => '¿Qué te inspiró en el arte?',
    'orientacion' => 'Tuve un papá muy narrador. Contaba historias de su vida y de su pueblo, donde aparecían duendes, brujas, almas y el diablo. Esas historias nos marcaron. Cuando terminé el bachillerato, le pedí unos libros; empecé a escribir poesía y me fui convirtiendo en escritor.',
    'pregunta2'   => '¿Qué consejos le darías a las personas que quieren estudiar cine?',
    'carrera'     => 'Pienso que deberían empezar grabando una historia cercana y sencilla de hacer: un personaje que conozcan, una anécdota que hayan visto o algo que haya ocurrido en su barrio, en su calle o en su propia vida. Después pueden explorar cómo darle forma de cortometraje.',
  ],
];

/**
 *
 * envía la lista con ok: true y cuántas entrevistas hay
 *
 */
echo json_encode(['ok' => true, 'total' => count($entrevistas), 'entrevistas' => $entrevistas], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
