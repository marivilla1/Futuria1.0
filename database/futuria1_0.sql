-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-10-2026 a las 17:22:14
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Importa este archivo dentro de la base creada en tu hosting; no incluye credenciales.
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `integrantes_equipo`
--

CREATE TABLE `integrantes_equipo` (
  `id_integrante` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` varchar(100) NOT NULL,
  `media_tecnica` varchar(100) NOT NULL,
  `bio` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `integrantes_equipo`
--

INSERT INTO `integrantes_equipo` (`id_integrante`, `nombre`, `rol`, `media_tecnica`, `bio`) VALUES
(1, 'Isabela M.', 'Líder creativa e identidad visual', 'Pre-Prensa Digital', 'Líder creativa del equipo: coordinó la identidad visual de Futuria y definió la paleta y el logo del zorro.'),
(2, 'María R.', 'Investigación vocacional', 'Pre-Prensa Digital', 'Encargada de la investigación vocacional: diseñó las preguntas del test y estudió los perfiles de interés de los estudiantes.'),
(3, 'Estefanía A.', 'Pre-prensa y diagramación', 'Pre-Prensa Digital', 'Responsable de pre-prensa y diagramación: preparó los folletos, revisó márgenes, tipografías y colores para impresión.'),
(4, 'Carolina P.', 'Community manager', 'Pre-Prensa Digital', 'Community manager del proyecto: administra las redes de Futuria y responde a los estudiantes que escriben.'),
(5, 'Mariana V.', 'Gestión del tiempo', 'Programación de Software', 'Especialista en gestión del tiempo: construyó la agenda inteligente y las plantillas de horarios.'),
(6, 'Paulina L.', 'Métodos de estudio', 'Programación de Software', 'Encargada de los métodos de estudio: recopiló técnicas como Pomodoro, flashcards y mapas mentales.'),
(7, 'Luciana D.', 'Entrevistas', 'Programación de Software', 'Responsable de las entrevistas: contactó a profesionales y estudiantes para recoger sus historias vocacionales.'),
(8, 'Juan C.', 'Desarrollo del sitio e IA', 'Programación de Software', 'Desarrollador del sitio y de la sección de IA: programó la página, el formulario de contacto y el asistente.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramientas_datos`
--

CREATE TABLE `herramientas_datos` (
  `id_usuario` int(11) NOT NULL,
  `herramienta` varchar(30) NOT NULL,
  `datos` mediumtext NOT NULL,
  `actualizado_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `herramientas_datos`
--

INSERT INTO `herramientas_datos` (`id_usuario`, `herramienta`, `datos`, `actualizado_en`) VALUES
(1, 'flashcards', '{\"mazos\":[{\"nombre\":\"Biología\",\"tarjetas\":[{\"pregunta\":\"¿Qué es la mitosis?\",\"respuesta\":\"División de una célula en dos células hijas idénticas.\"},{\"pregunta\":\"¿Qué orgánulo produce energía?\",\"respuesta\":\"La mitocondria.\"}]},{\"nombre\":\"Historia\",\"tarjetas\":[{\"pregunta\":\"¿En qué año se independizó Colombia?\",\"respuesta\":\"1810 (grito de independencia) y 1819 (Batalla de Boyacá).\"}]}]}', '2026-10-27 15:24:50'),
(1, 'mapas_mentales', '{\"mapas\":[{\"tema\":\"La célula\",\"ramas\":[{\"nombre\":\"Tipos\",\"hijos\":[\"Procariota\",\"Eucariota\"]},{\"nombre\":\"Partes\",\"hijos\":[\"Núcleo\",\"Membrana\",\"Mitocondria\"]}]}]}', '2026-10-27 15:24:50'),
(1, 'pomodoro', '{\"minutos_estudio\":25,\"minutos_descanso\":5,\"ciclos_para_descanso_largo\":4,\"ciclos_completados_hoy\":3}', '2026-10-27 15:24:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interacciones_ia`
--

CREATE TABLE `interacciones_ia` (
  `id_interaccion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_resultado` int(11) DEFAULT NULL,
  `prompt_usuario` text NOT NULL,
  `respuesta_ia` text NOT NULL,
  `fecha_consulta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `interacciones_ia`
--

INSERT INTO `interacciones_ia` (`id_interaccion`, `id_usuario`, `id_resultado`, `prompt_usuario`, `respuesta_ia`, `fecha_consulta`) VALUES
(1, 1, 1, 'Salió Investigador y Artístico. ¿Qué carreras me recomiendas?', 'Tu perfil combina curiosidad científica con creatividad. Algunas carreras que podrías explorar son Diseño industrial, Arquitectura, Diseño de videojuegos, Comunicación audiovisual y Psicología. Te recomiendo investigar el plan de estudios de cada una y hablar con alguien que ya la esté estudiando.', '2026-10-27 15:27:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_estudio`
--

CREATE TABLE `metodos_estudio` (
  `id_metodo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `metodos_estudio`
--

INSERT INTO `metodos_estudio` (`id_metodo`, `nombre`, `descripcion`, `categoria`) VALUES
(1, 'Pomodoro', 'Bloques de 25 minutos de estudio con descansos de 5 minutos.', 'Gestión del tiempo'),
(2, 'Flashcards', 'Tarjetas de pregunta y respuesta para practicar la memoria activa.', 'Memorización'),
(3, 'Mapas mentales', 'Un tema central con ramas de ideas para organizar y relacionar conceptos.', 'Organización de ideas'),
(4, 'Agenda', 'Calendario con tareas por día y hora para que nada se olvide.', 'Planificación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificador_tareas`
--

CREATE TABLE `planificador_tareas` (
  `id_tarea` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_metodo` int(11) DEFAULT NULL,
  `titulo_tarea` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_limite` datetime NOT NULL,
  `estado` enum('Pendiente','En Progreso','Completada') NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planificador_tareas`
--

INSERT INTO `planificador_tareas` (`id_tarea`, `id_usuario`, `id_metodo`, `titulo_tarea`, `descripcion`, `fecha_limite`, `estado`) VALUES
(1, 1, 1, 'Estudiar para el examen de biología', 'Repasar mitosis y meiosis con 3 pomodoros.', '2026-11-03 18:00:00', 'Pendiente'),
(2, 1, NULL, 'Entregar taller de historia', 'Subirlo a la plataforma del colegio.', '2026-10-30 23:59:00', 'En Progreso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas_test`
--

CREATE TABLE `preguntas_test` (
  `id_pregunta` int(11) NOT NULL,
  `id_test` int(11) NOT NULL,
  `enunciado` text NOT NULL,
  `categoria_vocacional` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `preguntas_test`
--

INSERT INTO `preguntas_test` (`id_pregunta`, `id_test`, `enunciado`, `categoria_vocacional`) VALUES
(1, 2, '¿Te gusta arreglar, construir o armar cosas con tus manos?', 'Realista'),
(2, 2, '¿Disfrutas investigar por qué pasan las cosas y resolver problemas?', 'Investigador'),
(3, 2, '¿Te gusta dibujar, escribir, componer o crear cosas originales?', 'Artístico'),
(4, 2, '¿Disfrutas ayudar, enseñar o acompañar a otras personas?', 'Social'),
(5, 2, '¿Te gusta liderar grupos o convencer a otros de tus ideas?', 'Emprendedor'),
(6, 2, '¿Prefieres tener tus tareas ordenadas, con pasos y reglas claras?', 'Convencional'),
(7, 2, '¿Te gustaría trabajar con herramientas, máquinas o equipos?', 'Realista'),
(8, 2, '¿Prefieres las actividades al aire libre antes que estar todo el día en una oficina?', 'Realista'),
(9, 2, '¿Te interesa saber cómo funcionan los aparatos electrónicos o mecánicos?', 'Realista'),
(10, 2, '¿Disfrutas del deporte o de actividades que exigen esfuerzo físico?', 'Realista'),
(11, 2, '¿Te sientes cómodo cuidando plantas, animales o trabajando la tierra?', 'Realista'),
(12, 2, '¿Te gusta leer o ver documentales sobre ciencia y descubrimientos?', 'Investigador'),
(13, 2, '¿Disfrutas hacer experimentos o comprobar si una idea es cierta?', 'Investigador'),
(14, 2, '¿Te atraen los acertijos, la lógica y los problemas de matemáticas?', 'Investigador'),
(15, 2, '¿Te gusta analizar datos o información para sacar conclusiones?', 'Investigador'),
(16, 2, '¿Te da curiosidad entender cómo funciona el cuerpo humano, la naturaleza o el universo?', 'Investigador'),
(17, 2, '¿Te gusta expresar lo que sientes con música, dibujo o actuación?', 'Artístico'),
(18, 2, '¿Prefieres trabajos donde puedas ser creativo y no seguir siempre las mismas reglas?', 'Artístico'),
(19, 2, '¿Disfrutas diseñar, decorar o darle un estilo personal a las cosas?', 'Artístico'),
(20, 2, '¿Te gusta inventar historias, canciones o personajes?', 'Artístico'),
(21, 2, '¿Te fijas en los colores, las formas y los detalles estéticos de lo que te rodea?', 'Artístico'),
(22, 2, '¿Las personas suelen contarte sus problemas porque saben que las escuchas?', 'Social'),
(23, 2, '¿Te gustaría trabajar en algo que mejore la vida de tu comunidad?', 'Social'),
(24, 2, '¿Disfrutas explicarle a un compañero algo que no entiende?', 'Social'),
(25, 2, '¿Te sientes bien trabajando en equipo y colaborando con otros?', 'Social'),
(26, 2, '¿Te interesa cuidar la salud o el bienestar de las personas?', 'Social'),
(27, 2, '¿Te gusta tener ideas de negocios o de cómo vender un producto?', 'Emprendedor'),
(28, 2, '¿Disfrutas tomar decisiones y asumir riesgos calculados?', 'Emprendedor'),
(29, 2, '¿Te sientes cómodo hablando frente a un grupo para presentar una idea?', 'Emprendedor'),
(30, 2, '¿Te motiva competir y lograr metas ambiciosas?', 'Emprendedor'),
(31, 2, '¿Te gusta organizar eventos o proyectos y coordinar a otras personas?', 'Emprendedor'),
(32, 2, '¿Te sientes cómodo llevando cuentas, listas o registros ordenados?', 'Convencional'),
(33, 2, '¿Prefieres seguir un procedimiento claro antes que improvisar?', 'Convencional'),
(34, 2, '¿Te molesta cuando los documentos o archivos están desordenados?', 'Convencional'),
(35, 2, '¿Disfrutas trabajar con números, tablas u hojas de cálculo?', 'Convencional'),
(36, 2, '¿Eres puntual y cumples los plazos a los que te comprometes?', 'Convencional'),
(37, 1, '¿Te gustaría organizar y dirigir una empresa o un negocio?', 'Administrativas'),
(38, 1, '¿Disfrutas llevar el control de gastos, presupuestos o inventarios?', 'Administrativas'),
(39, 1, '¿Te interesa negociar, vender o buscar clientes?', 'Administrativas'),
(40, 1, '¿Te ves planeando cómo hacer crecer un proyecto propio?', 'Administrativas'),
(41, 1, '¿Te gusta estudiar la historia, las culturas y cómo vive la gente?', 'Humanísticas y Sociales'),
(42, 1, '¿Disfrutas debatir, argumentar y defender ideas?', 'Humanísticas y Sociales'),
(43, 1, '¿Te interesan las leyes, la justicia y los derechos de las personas?', 'Humanísticas y Sociales'),
(44, 1, '¿Te gustaría entender por qué las personas piensan y actúan como lo hacen?', 'Humanísticas y Sociales'),
(45, 1, '¿Te gustaría diseñar ropa, logos, espacios o ilustraciones?', 'Artísticas'),
(46, 1, '¿Disfrutas tocar un instrumento, cantar, bailar o actuar?', 'Artísticas'),
(47, 1, '¿Te atrae la fotografía, el cine o la edición de video?', 'Artísticas'),
(48, 1, '¿Te gusta escribir cuentos, guiones o poesía?', 'Artísticas'),
(49, 1, '¿Te gustaría ayudar a personas enfermas a recuperarse?', 'Ciencias de la Salud'),
(50, 1, '¿Te interesa aprender cómo funciona el cuerpo humano?', 'Ciencias de la Salud'),
(51, 1, '¿Te sentirías capaz de actuar con calma ante una emergencia médica?', 'Ciencias de la Salud'),
(52, 1, '¿Te interesan la nutrición, el deporte y el bienestar físico?', 'Ciencias de la Salud'),
(53, 1, '¿Te gusta programar, crear apps o páginas web?', 'Ingeniería y Computación'),
(54, 1, '¿Disfrutas diseñar o construir máquinas, estructuras o prototipos?', 'Ingeniería y Computación'),
(55, 1, '¿Te llama la atención la robótica y la electrónica?', 'Ingeniería y Computación'),
(56, 1, '¿Te gusta encontrar soluciones técnicas a problemas del día a día?', 'Ingeniería y Computación'),
(57, 1, '¿Te atrae la disciplina y la vida con reglas estrictas, como en una institución uniformada?', 'Defensa y Seguridad'),
(58, 1, '¿Te gustaría proteger a las personas y participar en operaciones de rescate?', 'Defensa y Seguridad'),
(59, 1, '¿Disfrutas los retos físicos que exigen resistencia y entrenamiento?', 'Defensa y Seguridad'),
(60, 1, '¿Te interesa investigar casos y descubrir cómo ocurrió un delito?', 'Defensa y Seguridad'),
(61, 1, '¿Te gustan las matemáticas y la física?', 'Ciencias Exactas y Agrarias'),
(62, 1, '¿Disfrutas trabajar en un laboratorio con experimentos y mediciones?', 'Ciencias Exactas y Agrarias'),
(63, 1, '¿Te interesa el campo, los cultivos o el cuidado del medio ambiente?', 'Ciencias Exactas y Agrarias'),
(64, 1, '¿Te llaman la atención la química, la astronomía o la geología?', 'Ciencias Exactas y Agrarias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_integrante_creador` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` enum('Plantilla','Guia','Software','Curso') NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_integrante_creador`, `nombre`, `tipo`, `descripcion`, `precio`) VALUES
(1, 3, 'Libro', 'Guia', 'Libro guía de Futuria con orientación vocacional, métodos de estudio y herramientas para organizar tu tiempo. Diseñado para estudiantes de colegio y primeros semestres.', 65000.00),
(2, 1, 'Cartas', 'Plantilla', 'Juego de cartas de Futuria con los personajes del equipo para descubrir tus intereses y repasar métodos de estudio de forma divertida, solo o con amigos.', 28000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_usuarios`
--

CREATE TABLE `productos_usuarios` (
  `id_adquisicion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `fecha_adquisicion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos_usuarios`
--

INSERT INTO `productos_usuarios` (`id_adquisicion`, `id_usuario`, `id_producto`, `fecha_adquisicion`) VALUES
(1, 1, 1, '2026-10-27 15:28:01'),
(2, 1, 2, '2026-10-27 15:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados_test`
--

CREATE TABLE `resultados_test` (
  `id_resultado` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_test` int(11) NOT NULL,
  `perfil_sugerido` varchar(100) NOT NULL,
  `puntaje` int(11) NOT NULL,
  `fecha_realizacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `resultados_test`
--

INSERT INTO `resultados_test` (`id_resultado`, `id_usuario`, `id_test`, `perfil_sugerido`, `puntaje`, `fecha_realizacion`) VALUES
(1, 1, 2, 'Investigador - Artístico', 5, '2026-10-27 15:27:03'),
(2, 1, 1, 'Ingeniería y Computación', 4, '2026-10-27 15:27:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tests_vocacionales`
--

CREATE TABLE `tests_vocacionales` (
  `id_test` int(11) NOT NULL,
  `id_integrante_creador` int(11) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `duracion_minutos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tests_vocacionales`
--

INSERT INTO `tests_vocacionales` (`id_test`, `id_integrante_creador`, `titulo`, `descripcion`, `duracion_minutos`) VALUES
(1, 2, 'Test CHASIDE', 'Mide tus intereses en siete áreas profesionales: Administrativas, Humanísticas y Sociales, Artísticas, Ciencias de la Salud, Ingeniería y Computación, Defensa y Seguridad, y Ciencias Exactas y Agrarias.', 15),
(2, 2, 'Test de Holland (RIASEC)', 'Clasifica tu personalidad profesional en seis tipos: Realista, Investigador, Artístico, Social, Emprendedor y Convencional.', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('usuario','admin') NOT NULL DEFAULT 'usuario',
  `foto` mediumtext DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password_hash`, `rol`, `foto`, `fecha_nacimiento`, `fecha_registro`) VALUES
(1, 'Estudiante Demo', 'demo@futuria.test', 'sin_contraseña_solo_para_pruebas', 'usuario', NULL, '2009-05-14', '2026-10-27 15:24:49');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `integrantes_equipo`
--
ALTER TABLE `integrantes_equipo`
  ADD PRIMARY KEY (`id_integrante`);

--
-- Indices de la tabla `herramientas_datos`
--
ALTER TABLE `herramientas_datos`
  ADD PRIMARY KEY (`id_usuario`,`herramienta`);

--
-- Indices de la tabla `interacciones_ia`
--
ALTER TABLE `interacciones_ia`
  ADD PRIMARY KEY (`id_interaccion`),
  ADD KEY `idx_ia_usuario` (`id_usuario`),
  ADD KEY `idx_ia_resultado` (`id_resultado`);

--
-- Indices de la tabla `metodos_estudio`
--
ALTER TABLE `metodos_estudio`
  ADD PRIMARY KEY (`id_metodo`),
  ADD UNIQUE KEY `uk_metodos_nombre` (`nombre`);

--
-- Indices de la tabla `planificador_tareas`
--
ALTER TABLE `planificador_tareas`
  ADD PRIMARY KEY (`id_tarea`),
  ADD KEY `idx_tareas_usuario_fecha` (`id_usuario`,`fecha_limite`),
  ADD KEY `idx_tareas_metodo` (`id_metodo`);

--
-- Indices de la tabla `preguntas_test`
--
ALTER TABLE `preguntas_test`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `idx_preguntas_test` (`id_test`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `idx_productos_integrante` (`id_integrante_creador`);

--
-- Indices de la tabla `productos_usuarios`
--
ALTER TABLE `productos_usuarios`
  ADD PRIMARY KEY (`id_adquisicion`),
  ADD KEY `idx_pu_usuario_producto` (`id_usuario`,`id_producto`),
  ADD KEY `idx_pu_producto` (`id_producto`);

--
-- Indices de la tabla `resultados_test`
--
ALTER TABLE `resultados_test`
  ADD PRIMARY KEY (`id_resultado`),
  ADD KEY `idx_resultados_usuario` (`id_usuario`),
  ADD KEY `idx_resultados_test` (`id_test`);

--
-- Indices de la tabla `tests_vocacionales`
--
ALTER TABLE `tests_vocacionales`
  ADD PRIMARY KEY (`id_test`),
  ADD UNIQUE KEY `uk_tests_titulo` (`titulo`),
  ADD KEY `idx_tests_creador` (`id_integrante_creador`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uk_usuarios_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `integrantes_equipo`
--
ALTER TABLE `integrantes_equipo`
  MODIFY `id_integrante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `interacciones_ia`
--
ALTER TABLE `interacciones_ia`
  MODIFY `id_interaccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `metodos_estudio`
--
ALTER TABLE `metodos_estudio`
  MODIFY `id_metodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `planificador_tareas`
--
ALTER TABLE `planificador_tareas`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `preguntas_test`
--
ALTER TABLE `preguntas_test`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos_usuarios`
--
ALTER TABLE `productos_usuarios`
  MODIFY `id_adquisicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `resultados_test`
--
ALTER TABLE `resultados_test`
  MODIFY `id_resultado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tests_vocacionales`
--
ALTER TABLE `tests_vocacionales`
  MODIFY `id_test` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `herramientas_datos`
--
ALTER TABLE `herramientas_datos`
  ADD CONSTRAINT `fk_herramientas_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `interacciones_ia`
--
ALTER TABLE `interacciones_ia`
  ADD CONSTRAINT `fk_ia_resultado` FOREIGN KEY (`id_resultado`) REFERENCES `resultados_test` (`id_resultado`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ia_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `planificador_tareas`
--
ALTER TABLE `planificador_tareas`
  ADD CONSTRAINT `fk_tareas_metodo` FOREIGN KEY (`id_metodo`) REFERENCES `metodos_estudio` (`id_metodo`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tareas_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `preguntas_test`
--
ALTER TABLE `preguntas_test`
  ADD CONSTRAINT `fk_preguntas_test` FOREIGN KEY (`id_test`) REFERENCES `tests_vocacionales` (`id_test`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_integrante` FOREIGN KEY (`id_integrante`) REFERENCES `integrantes_equipo` (`id_integrante`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos_usuarios`
--
ALTER TABLE `productos_usuarios`
  ADD CONSTRAINT `fk_pu_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pu_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `resultados_test`
--
ALTER TABLE `resultados_test`
  ADD CONSTRAINT `fk_resultados_test` FOREIGN KEY (`id_test`) REFERENCES `tests_vocacionales` (`id_test`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_resultados_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tests_vocacionales`
--
ALTER TABLE `tests_vocacionales`
  ADD CONSTRAINT `fk_tests_integrante` FOREIGN KEY (`id_integrante_creador`) REFERENCES `integrantes_equipo` (`id_integrante`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


