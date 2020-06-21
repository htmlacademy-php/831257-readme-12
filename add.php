<?php

require_once 'bootstrap.php';

session_start();

if (!isset($_SESSION['login'])) {
    header('Location: index.php');
}

$is_auth = 1;

$user_id = $_SESSION['id'];
$user_name = $_SESSION['login'];
$user_avatar = $_SESSION['avatar'];

$types = dbGetTypes($connect);

$typeId = getTypeFromRequest($_GET, $_POST);

$errors = checkForm($_POST, $_FILES);

$page_content = include_template("adding-post.php", ['types' => $types, 'type_id' => $typeId, 'errors' => $errors]);

if ($errors === []) {
    $postId = dbAddPost($connect, $user_id, $_POST, $_FILES);
    if (!is_null($postId)) {
        $url = "post.php?post_id="."$postId";
        header("HTTP/1.1 301 Moved Permanently");
        header('Location: '.$url);
        exit();
    }
}

$layout_content = include_template("layout.php", ['content' => $page_content, 'title' => 'readme: популярное', 'user' => $user_name, 'avatar' => $user_avatar, 'is_auth' => $is_auth]);

print($layout_content);
