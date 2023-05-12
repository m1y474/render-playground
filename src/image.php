<?php

ini_set('display_errors', "On");
ini_set('error_reporting', E_ALL);

$path = $_SERVER['REQUEST_URI'];
$number = preg_replace('/[^0-9]/', '', $path);

$file_name = getcwd() . '/img/' . $number.'.jpg';

header('Content-Type: image/png');
header('Content-Disposition: attachment; filename=' .$file_name);
header('Content-Length: ' . filesize($file_name));
header("Last-Modified: " . date('r', filectime($file_name)));
header('Pragma: cache');
header("Cache-Control: max-age=".(60*60*24*365));
readfile($file_name);
exit();
