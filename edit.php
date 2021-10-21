<?php
    if(isset($_GET['codigo_s'])){
        $sabor=$_GET['codigo_s'];
        $db=new SQLite3('pizza.db');
    }
    else{
        echo "XIIIIII";
    }
?>