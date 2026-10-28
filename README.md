# Futuria

Sitio de organización escolar y orientación vocacional con frontend HTML/CSS/JavaScript y API PHP/MySQL.

## Ejecutar localmente con XAMPP

1. Inicia Apache y MySQL en el panel de XAMPP.
2. En phpMyAdmin, crea una base vacía llamada `futuria1_0`.
3. Importa `database/futuria1_0.sql`.
4. Copia `api/inc/config.ejemplo.php` como `api/inc/config.php`. Para XAMPP nuevo usa `localhost`, puerto `3306`, base `futuria1_0`, usuario `root` y contraseña vacía. Si configuraste una contraseña para MySQL, úsala.
5. Abre `http://localhost/Futuria-main/`.

## Publicar con InfinityFree

1. Sube el contenido del proyecto al directorio `htdocs` del sitio.
2. Crea una base desde **MySQL Databases** e importa `database/futuria1_0.sql) en esa base.
3. Crea `api/inc/config.php) a partir del ejemplo y reemplaza host, nombre de base, usuario y contraseña por los valores del panel. El puerto es `3306`.
4. No subas `api/inc/config.php` a GitHub: está ignorado por Git para proteger la contraseña.

El SQL de este repositorio se debe importar una sola vez en una base nueva y vacía. Para XAMPP local se necesita una base local; la base de InfinityFree se usa desde el sitio alojado allí.

