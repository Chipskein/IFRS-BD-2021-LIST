<?php
    $sabor=$_GET['codigo_s'];
    $db=new SQLite3('pizza.db');
    $db->query("delete from sabor where sabor.codigo=$sabor")
    
    
?>