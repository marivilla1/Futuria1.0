<?php
/**
 * Copia este archivo como config.php y completa los datos del servidor.
 * config.php está excluido de Git para no publicar contraseñas.
 *
 * XAMPP suele usar localhost, base futuria1_0 y usuario root.
 * En InfinityFree, copia el host, base y usuario de MySQL Databases;
 * el host no es localhost. El puerto habitual es 3306.
 * Para la IA, crea una clave de OpenRouter y escríbela en ia_api_key.
 * Guarda la clave solo en config.php; nunca la publiques en GitHub.
 */
return [
    'host' => 'localhost',
    'puerto' => 3306,
    'base' => 'futuria1_0',
    'usuario' => 'root',
    'contrasena' => '',
    'ia_api_key' => '', // Clave privada de OpenRouter: solo en config.php
    'ia_modelo' => 'openrouter/free', // Modelo gratuito de instrucciones, con soporte multilingüe
];
