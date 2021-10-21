<?php
    if(isset($_GET['codigo_s'])){
        $sabor=$_GET['codigo_s'];
        $db=new SQLite3('pizza.db');
        $result=$db->query("delete from sabor where sabor.codigo=$sabor");
        if($result) echo "Sabor Removido";
        else echo "Erro retornando";
    }
    else{
        echo "Erro retornando";
    }
    header( "refresh:1;url=index.php" );
    die();
       
?>