/**
 *
 * esta página muestra dos pruebas externas: una para explorar áreas
 * profesionales (CHASIDE) y otra para conocer el perfil de personalidad
 * profesional (Holland/RIASEC). Cada tarjeta usa la imagen que corresponde
 * al tema
 *
 */
document.addEventListener('DOMContentLoaded', () => {
  const grid = document.getElementById('tests-grid');
  if (!grid) return;

  const resumenEl = document.getElementById('test-resumen');

  const RESPALDO = {
    resumen:
      'Explora dos aspectos complementarios de tu futuro: tus intereses y aptitudes para distintas áreas profesionales, y los rasgos de personalidad que suelen relacionarse con diferentes entornos de trabajo. Son herramientas de orientación, no decisiones definitivas.',
    tests: [
      {
        id: 'chaside',
        nombre: 'Test CHASIDE · Áreas profesionales',
        etiqueta: 'Intereses y aptitudes',
        descripcion:
          'Explora tus intereses y aptitudes en áreas como ciencias, salud, arte, comunicación, administración y tecnología. El resultado puede ayudarte a identificar campos profesionales que vale la pena investigar.',
        etiquetas: ['Áreas profesionales', 'Intereses', 'Aptitudes', 'Orientativo'],
        boton: 'Explorar áreas profesionales',
        enlace: 'https://orientacion-psicopedagogica.net/test/test-chaside/',
        imagen: '../assets/img/test-2.svg'
      },
      {
        id: 'holland',
        nombre: 'Test de personalidad Holland (RIASEC)',
        etiqueta: 'Personalidad profesional',
        descripcion:
          'Relaciona tus preferencias con seis perfiles: Realista, Investigador, Artístico, Social, Emprendedor y Convencional. Conoce los entornos y tipos de actividad que podrían encajar mejor contigo.',
        etiquetas: ['Personalidad', '6 perfiles', 'RIASEC', 'Orientativo'],
        boton: 'Conocer mi perfil',
        enlace: 'https://www.orientacionuniversitaria.com/test-vocacional/test-de-holland/',
        imagen: '../assets/img/test-3.svg'
      }
    ]
  };

  fetch('../api/test-vocacional.php')
    .then((r) => (r.ok ? r.json() : Promise.reject()))
    .then((d) => {
      if (d.resumen && resumenEl) resumenEl.textContent = d.resumen;
      pintar(d.tests || RESPALDO.tests);
    })
    .catch(() => pintar(RESPALDO.tests));

  function pintar(tests) {
    grid.innerHTML = '';
    tests.forEach((t, i) => grid.appendChild(tarjeta(t, i)));
  }

  function tarjeta(t, i) {
    const article = document.createElement('article');
    article.className = 'test' + (i % 2 === 1 ? ' test--alterno' : '');
    article.id = t.id;

    const etiquetas = (t.etiquetas || [])
      .map((e) => '<li>' + e + '</li>')
      .join('');

    article.innerHTML = `
      <div class="test__imagen">
        <span class="test__etiqueta">${t.etiqueta}</span>
        <img src="${t.imagen}" alt="Ilustración del ${t.nombre}" width="800" height="600" loading="lazy">
      </div>
      <div class="test__cuerpo">
        <h3 class="test__titulo">${t.nombre}</h3>
        <p class="test__texto">${t.descripcion}</p>
        <ul class="test__lista">${etiquetas}</ul>
        <a class="test__boton" href="${t.enlace}" target="_blank" rel="noopener noreferrer">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
            <path d="M5 12h14"/>
            <path d="M12 5l7 7-7 7"/>
          </svg>
          ${t.boton}
        </a>
      </div>`;

    return article;
  }
});
