<?php
    echo "<h3>Exercicio 1</h3>";
    echo "<br>";
    if(isset($_POST["cpf"])){
        $cpf=$_POST["cpf"];
        echo (preg_match("#^[0-9]{9}-[0-9]{2}$#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "CPF não foi enviado";
    echo "<br>";
    echo "<h3>Exercicio 2</h3>";
    if(isset($_POST["data"])&&isset($_POST["dias"])){
        $data=$_POST["data"];
        $dias=$_POST["dias"];
        echo 'data:'.$data;
        echo "<br>";
        echo 'dias:'.$dias;
        //echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "a Data e os Dias uteis não foram enviados";
    echo "<br>";
    echo "<h3>Exercicio 3</h3>";
    if(isset($_POST["valor"])){
        $valor=$_POST["valor"];
        echo 'valor:'.$valor;
        //echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "valor não foi enviado";
?>