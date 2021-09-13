<?php
    $cpf=$_POST["cpf"];
    if(preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)){
        echo "CPF ".$cpf." foi cadastrado com sucesso";
    }
    else{
        echo "Seu cpf não foi cadastrado com sucesso";
    }        
?>