<?php

/**
 * Возвращает id типа контента из массива параметров запроса, если такой тип существует, иначе возвращает null
 * ('type_id' == 0  равноценно null)
 * @param array $get массив параметров запроса
 * @param array $post массив параметров запроса
 *
 * @return int or null
 */
function getTypeFromRequest(array $get, array $post = []) : ?int
{
    if (isset($get['type_id'])) {
        return empty($get['type_id']) ? null : (int) $get['type_id'];
    } elseif (isset($post['type_id'])) {
        return (int) $post['type_id'];
    }
    return null;
}

/**
 * Возвращает id поста из массива параметров запроса, если id найден, иначе возвращает null
 *
 * @param array $get массив параметров запроса
 * @param array $post массив параметров запроса
 *
 * @return int or null
 */
function getPostIdFromRequest(array $get, array $post = []) : ?int
{
    if (isset($get['post_id'])) {
        return (int) $get['post_id'];
    } elseif (isset($post['post_id'])) {
        return (int) $post['post_id'];
    }
    return null;
}


/**
 * Возвращает признак сортировки из массива параметров запроса, если параметр найден, иначе возвращает null
 *
 * @param array $arr массив параметров запроса
 *
 * @return int or null
 */
function getSortFromRequest(array $arr) : ?string
{
    return empty($arr['sort']) ? null : $arr['sort'];
}

/**
 * Возвращает значение массива по ключу $key, если такое существует, иначе - пустую строку
 *
 * @param  array $arr ассоциативный массив
 * @param  string $key ключ массива
 *
 * @return string
 */
function getPostVal(array $arr, string $key) : string
{
    return $arr[$key] ?? "";
}
