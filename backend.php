<?php
    $cpf=$_POST["cpf"];
    if(empty($cpf)){
        echo "Seu cpf não foi cadastrado";
    }
    else{
        echo "CPF ".$cpf." foi cadastrado com sucesso";
    }        
?>