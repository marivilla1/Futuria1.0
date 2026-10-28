# Futuria 1.0 — Base de datos

El archivo [futuria1_0.sql](futuria1_0.sql) contiene el esquema y los datos iniciales compatibles con la aplicación PHP. Impórtalo una sola vez en una base de datos nueva y vacía.

## Importar con XAMPP

1. Inicia Apache y MySQL desde XAMPP.
2. Abre phpMyAdmin en `http://localhost/phpmyadmin` y crea una base de datos, por ejemplo `futuria1_0`, con cotejamiento `utf8mb4_unicode_ci`.
3. Selecciona esa base e importa `futuria1_0.sql`.
4. Copia `api/inc/config.ejemplo.php` como `api/inc/config.php` y configura la conexión local (normalmente host `localhost`, puerto `3306`, usuario `root` y contraseña vacía en una instalación XAMPP nueva).

## Importar en alojamiento PHP/MySQL

1. Crea una base MySQL desde el panel del proveedor y usa phpMyAdmin para importar `futuria1_0.sql`.
2. Copia `api/inc/config.ejemplo.php` como `api/inc/config.php`.
3. En `config.php`, escribe el host, puerto, nombre de base, usuario y contraseña que muestra el panel del hosting. El host puede ser distinto de `localhost`.
4. Sube el sitio a un hosting que ejecute PHP y MySQL/MariaDB. La app usa PDO para MySQL y requiere sesiones PHP.

`api/inc/config.php` está excluido de Git para que las contraseñas y claves privadas no se publiquen. No subas las credenciales del hosting al repositorio.

## Datos de ejemplo

El dump incluye contenido inicial para equipo, productos, preguntas, tareas y herramientas, además de una cuenta ficticia `demo@futuria.test`. Esa cuenta solo ilustra datos de prueba y no tiene una contraseña válida para iniciar sesión. En el sitio, crea una cuenta nueva mediante el formulario de registro.

## Compatibilidad con la aplicación

El dump usa los nombres que consulta el proyecto (`integrantes_equipo`, `productos.id_integrante_creador`) y codificación `utf8mb4`. También incluye el método `Agenda`, que utiliza `api/agenda.php` para clasificar las tareas.
