/**
 *
 * la página de entrevistas: pide a api/entrevistas.php la lista de
 * profesionales y arma un acordeón con un área por fila. Al abrir un área se
 * ven la foto, las respuestas y el reproductor de audio o video de la entrevista
 *
 * si el servidor no responde usa la lista de respaldo escrita aquí, que tiene
 * las entrevistas reales del equipo (Jacobo, Ñe, Sebastián y Víctor). Solo puede haber
 * un área abierta y un audio sonando a la vez
 *
 */

/**
 *
 * las entrevistas de respaldo: área, nombre, profesión, imagen, audio y los
 * dos consejos de cada persona
 *
 */
var ENTREVISTAS_RESPALDO = [
  {
    area: 'Transporte - Piloto de avión',
    nombre: 'Jacobo Román',
    profesion: 'Piloto de avión',
    imagen: '../assets/img/piloto.jpg',
    audio: '../assets/audio/jacobo.mp3',
    pregunta1: '¿Qué le dirías a alguien que aún no sabe qué estudiar?',
    orientacion: 'Le diría que primero estudie algo que le guste. A mí me parece que estudiar algo que a uno no le gusta es un infierno. No debería elegir únicamente por tener un sustento económico. Me he dado cuenta de que, en cualquier área o campo que uno escoja, uno mismo se hace su destino.',
    pregunta2: '¿Qué consejo le darías a alguien que quiere estudiar para ser piloto de avión?',
    carrera: 'Primero, hay que ser consciente del compromiso que conlleva esta elección. No debe guiarse únicamente por el aspecto económico, porque trae consigo muchas dificultades, retos y decepciones y, sobre todo, requiere mucho autoconocimiento.'
  },
  {
    area: 'Marketing y creación de contenido',
    nombre: 'Juan Felipe Restrepo Sánchez (El Ñe)',
    profesion: 'Creador de contenido',
    imagen: '../assets/img/stremer.jpg',
    audio: '../assets/audio/ne.mp3',
    pregunta1: '¿Cómo elegiste la carrera que estás estudiando?',
    orientacion: 'Es un proceso complejo. En mi caso requirió muchos cambios de ideas y decisiones. No fue hasta finales de mi último año de bachillerato que decidí lo que realmente quería hacer. Descubrí mi pasión por el marketing digital y la relacioné con distintos ámbitos que eran mi fuerte, lo que me llevó a estudiar Ingeniería Comercial.',
    pregunta2: '¿Sientes que con tu trabajo ayudas a otras personas a decidir qué hacer en su futuro?',
    carrera: 'Indirectamente puede influir. Como creador, busco hacer un vínculo con las personas, motivarlas y alegrarles el día: que puedan reírse, salir de la monotonía y, con base en mi experiencia, aconsejarlas para que eviten cometer los mismos errores que cometí.'
  },
  {
    area: 'Social y Humanidades - Abogado',
    nombre: 'Sebastián Días Bolívar',
    profesion: 'Abogado',
    imagen: '../assets/img/abogado.jpg',
    audio: '../assets/audio/sebastian.mp3',
    pregunta1: '¿Qué le dirías a alguien que aún no sabe qué estudiar?',
    orientacion: 'Debe considerar varios aspectos. Es importante escoger algo que te llame la atención y se alinee con tus gustos; también debes considerar la salida laboral y económica. La combinación de estos aspectos es fundamental para escoger tu vocación.',
    pregunta2: '¿Qué consejo le darías a alguien que va a estudiar Derecho?',
    carrera: 'Que sea el mejor. Si vas a estudiar Derecho, dedícate completamente: lee más de lo que te dan en clase, estudia muchos libros y busca prácticas adicionales. No te quedes con lo mínimo; métete con muchas ganas y de lleno a estudiar Derecho.'
  },
  {
    area: 'Arte y cine - Dirección',
    nombre: 'Victor Manuel Gaviria Gonzales',
    profesion: 'Director de cine',
    imagen: '../assets/img/victor-cine.jpg',
    video: '../assets/video/VICTOR.mp4',
    pregunta1: '¿Qué te inspiró en el arte?',
    orientacion: 'Tuve un papá muy narrador. Contaba historias de su vida y de su pueblo, donde aparecían duendes, brujas, almas y el diablo. Esas historias nos marcaron. Cuando terminé el bachillerato, le pedí unos libros; empecé a escribir poesía y me fui convirtiendo en escritor.',
    pregunta2: '¿Qué consejos le darías a las personas que quieren estudiar cine?',
    carrera: 'Pienso que deberían empezar grabando una historia cercana y sencilla de hacer: un personaje que conozcan, una anécdota que hayan visto o algo que haya ocurrido en su barrio, en su calle o en su propia vida. Después pueden explorar cómo darle forma de cortometraje.'
  }
];

/**
 *
 * cuando la página termina de cargar se piden las entrevistas y se pintan
 *
 */
document.addEventListener('DOMContentLoaded', function(){

  /**
   *
   * la caja del acordeón y el audio que está sonando ahora (para pausarlo si
   * se reproduce otro)
   *
   */
  var lista=document.getElementById('entrevistas-lista');var audioActual=null;

  /**
   *
   * convierte segundos en el texto mm:ss, por ejemplo 124 → "02:04". Si el
   * dato no sirve devuelve "00:00"
   *
   */
  function formatoTiempo(segundos) {
    if (isNaN(segundos) || segundos < 0) return '00:00';
    var m = Math.floor(segundos / 60);
    var s = Math.floor(segundos % 60);
    return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
  }

  /**
   *
   * arma todo el acordeón, con una fila por entrevista
   *
   * la primera fila empieza abierta. Cada fila tiene un botón con el número
   * y el nombre del área, y un panel con la entrevista y su reproductor
   *
   */
  function pintar(datos){
    if(!lista)return;lista.innerHTML='';
    datos.forEach(function(dato,indice){
      var item=document.createElement('article');item.className='area'+(indice===0?' abierta':'');
      var boton=document.createElement('button');boton.type='button';boton.className='area__boton';boton.setAttribute('aria-expanded',indice===0?'true':'false');
      var panelId='area-panel-'+indice;boton.setAttribute('aria-controls',panelId);
      boton.innerHTML='<span class="area__numero">'+String(indice+1).padStart(2,'0')+'</span><span class="area__nombre"></span><span class="area__icono" aria-hidden="true">+</span>';
      boton.querySelector('.area__nombre').textContent=dato.area;
      
      /**
       *
       * el panel de la entrevista: la imagen, el nombre, la profesión, los
       * dos consejos y el reproductor (botón, tiempo actual, barra y
       * duración total)
       *
       */
      var panel=document.createElement('div');panel.className='area__panel';panel.id=panelId;
      panel.innerHTML='<div class="area__interior"><div class="entrevista"><figure class="entrevista__imagen"><img loading="lazy" width="900" height="700"></figure><div class="entrevista__contenido"><h3 class="entrevista__nombre"></h3><p class="entrevista__profesion"></p><div class="consejos"><section class="consejo"><h4 class="consejo__pregunta1">Si aún no sabes qué estudiar</h4><p class="consejo__orientacion"></p></section><section class="consejo"><h4 class="consejo__pregunta2">Si contemplas esta carrera</h4><p class="consejo__carrera"></p></section></div><div class="audio"><video class="entrevista__video" preload="metadata" playsinline hidden></video><button class="audio__boton" type="button"><span class="audio__icono" aria-hidden="true">▶</span><span class="audio__texto">Reproducir entrevista</span></button><div class="audio__progreso-wrapper" style="display:flex; align-items:center; gap:8px; width:100%; margin-top:8px;"><span class="audio__tiempo-actual" style="font-size:0.8rem; color:rgba(252,252,251,0.8);">00:00</span><input type="range" class="audio__barra" value="0" min="0" max="100" style="flex:1; cursor:pointer;"><span class="audio__tiempo-total" style="font-size:0.8rem; color:rgba(252,252,251,0.8);">00:00</span></div><audio preload="metadata"></audio></div></div></div></div>';
      
      var img=panel.querySelector('img');img.src=dato.imagen;img.alt='Ilustración del área de '+dato.area;
      panel.querySelector('.entrevista__nombre').textContent=dato.nombre;panel.querySelector('.entrevista__profesion').textContent=dato.profesion;
      panel.querySelector('.consejo__orientacion').textContent=dato.orientacion;panel.querySelector('.consejo__carrera').textContent=dato.carrera;panel.querySelector('.consejo__pregunta1').textContent=dato.pregunta1||'Si aún no sabes qué estudiar';panel.querySelector('.consejo__pregunta2').textContent=dato.pregunta2||'Si contemplas esta carrera';
      
      /**
       *
       * el audio de la entrevista y las partes del reproductor
       *
       */
      var audio=panel.querySelector('audio');var video=panel.querySelector('.entrevista__video');var medio=dato.video?video:audio;if(dato.video){video.src=dato.video;video.hidden=false;}else if(dato.audio){audio.src=dato.audio;}
      var play=panel.querySelector('.audio__boton');
      var texto=panel.querySelector('.audio__texto');
      var icono=panel.querySelector('.audio__icono');
      var barra=panel.querySelector('.audio__barra');
      var tiempoActual=panel.querySelector('.audio__tiempo-actual');
      var tiempoTotal=panel.querySelector('.audio__tiempo-total');

      /**
       *
       * cambian el botón entre "Pausar entrevista" (Ⅱ) y "Reproducir
       * entrevista" (▶)
       *
       */
      function mostrarPausa(){texto.textContent='Pausar entrevista';icono.textContent='Ⅱ';}
      function mostrarPlay(){texto.textContent='Reproducir entrevista';icono.textContent='▶';}

      /**
       *
       * el botón reproduce o pausa. Antes de reproducir pausa cualquier otra
       * entrevista que esté sonando. Si el audio no se puede reproducir (por
       * ejemplo porque el archivo no existe) el botón dice "Reemplaza el audio"
       *
       */
      play.addEventListener('click',function(){
        if(medio.paused){
          if(audioActual&&audioActual!==medio){
            audioActual.pause();
          }
          medio.play().then(function(){
            audioActual=medio;
            mostrarPausa();
          }).catch(function(){
            texto.textContent='No se pudo cargar la entrevista';
          });
        }else{
          medio.pause();
          mostrarPlay();
        }
      });

      /**
       *
       * cuando se conoce la duración del audio se muestra a la derecha de la
       * barra
       *
       */
      medio.addEventListener('loadedmetadata', function(){
        tiempoTotal.textContent = formatoTiempo(medio.duration);
      });

      /**
       *
       * mientras suena, mueve la barra (de 0 a 100) y actualiza el tiempo
       * actual
       *
       */
      medio.addEventListener('timeupdate', function(){
        if(medio.duration){
          var porcentaje = (medio.currentTime / medio.duration) * 100;
          barra.value = porcentaje;
          tiempoActual.textContent = formatoTiempo(medio.currentTime);
        }
      });

      /**
       *
       * al arrastrar la barra, el audio salta a ese punto
       *
       */
      barra.addEventListener('input', function(){
        if(medio.duration){
          var nuevoTiempo = (barra.value / 100) * medio.duration;
          medio.currentTime = nuevoTiempo;
        }
      });

      /**
       *
       * al pausar vuelve el botón de reproducir; al terminar, además, la
       * barra y el tiempo vuelven a cero
       *
       */
      medio.addEventListener('pause',mostrarPlay);
      medio.addEventListener('ended',function(){
        mostrarPlay();
        barra.value = 0;
        tiempoActual.textContent = '00:00';
      });

      /**
       *
       * al hacer clic en un área se abre (o se cierra si ya estaba abierta)
       * y se cierran todas las demás
       *
       */
      boton.addEventListener('click',function(){
        var abrir=!item.classList.contains('abierta');
        document.querySelectorAll('.area.abierta').forEach(function(otro){
          if(otro!==item){
            otro.classList.remove('abierta');
            otro.querySelector('.area__boton').setAttribute('aria-expanded','false');
          }
        });
        item.classList.toggle('abierta',abrir);
        boton.setAttribute('aria-expanded',String(abrir));
      });

      item.appendChild(boton);item.appendChild(panel);lista.appendChild(item);
    });
  }

  /**
   *
   * pide las entrevistas al servidor; si no llegan, usa las de respaldo
   *
   */
  fetch('../api/entrevistas.php')
    .then(function(r){if(!r.ok)throw new Error('No disponible');return r.json();})
    .then(function(data){pintar(data&&data.ok&&data.entrevistas?data.entrevistas:ENTREVISTAS_RESPALDO);})
    .catch(function(){pintar(ENTREVISTAS_RESPALDO);});
});
