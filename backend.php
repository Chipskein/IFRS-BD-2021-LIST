<?php
    if(isset($_POST["CPF"])){
        $cpf=$_POST["cpf"];
        echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    }
    else{
        echo "CPF não foi enviado";
    }
?>