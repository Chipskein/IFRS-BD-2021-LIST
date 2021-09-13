<?php
    if(isset($_POST["cpf"])){
        $cpf=$_POST["cpf"];
        echo (preg_match("#^[0-9]{9}-[0-9]{2}$#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "CPF não foi enviado";
    if(isset($_POST["data"])&&isset($_POST["dias"])){
        $data=$_POST["data"];
        $dias=$_POST["dias"];
        echo 'data:'.$data;
        echo 'dia:'.$data;
        //echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    }
?>