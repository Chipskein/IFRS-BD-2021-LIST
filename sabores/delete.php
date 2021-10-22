<?php
    if(isset($_GET['codigo_s'])){
        $sabor=$_GET['codigo_s'];
        $db=new SQLite3('../pizza.db');
        $result=$db->query("delete from saboringrediente where saboringrediente.sabor=$sabor");
        if($result){ 
            $result2=$db->query("delete from sabor where sabor.codigo=$sabor");
            if($result2) echo "Sabor Removido";
            else echo "Erro retornando";
        }
        else echo "Erro retornando";
    }
    else{
        echo "Erro retornando";
    }
    header( "refresh:1;url=sabor_index.php" );
    die();
       
?>