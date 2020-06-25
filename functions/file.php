<?php

/**
 * Сохранение аватара нового пользователя локально
 *
 * @param  mysqli $con Объект-соединение с БД
 * @param  array $files массив с данными о загружаемом аватаре пользователя
 *
 * @return string возвращает относительный путь к загруженному файлу либо null
 */
function savePicture(mysqli $con, array $files) : ?string
{
    $file = $files[key($files)];

    if (!empty($file['name'])) {
        $file_path = 'uploads/';

        //формируем новое имя файла
        $file_name = md5(uniqid());
        $file_ext = mb_substr($file['type'], mb_strpos($file['type'], '/') + 1);
        $file_ext = $file_ext === 'jpeg' ? 'jpg' : $file_ext;
        $picture = $file_path.$file_name.'.'.$file_ext;

        if (!move_uploaded_file($file['tmp_name'], $picture)) {
            echo "Ошибка перемещения файла";
            return null;
        };
    }
    return $picture;
}

/**
 * Возвращает массив, отсортированный по убыванию (пузырьковый метод)
 *
 * @param array $arr Массим данных
 * @param $user_id int поле, по которому сортируется массив
 *
 * @return array Отсортированный массив
 */
function sortBubbleDescArray($arr, $field)
{
    $size = count($arr);

    for( $i=0; $i < $size; $i++) {
        for( $j = $size-1; $j > $i; $j-- ) {
            if ( $arr[$j-1][$field] < $arr[$j][$field] ) {
                $temp = $arr[$j-1];
                $arr[$j-1]=$arr[$j];
                $arr[$j]= $temp;
            }
        }
    }
    return $arr;
}