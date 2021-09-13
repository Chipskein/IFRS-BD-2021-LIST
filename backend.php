<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>backend</title>
</head>
<style>
    body{
        background-color: #454141;
        color: white;
    }
</style>
<body>
<?php
function calculardata($data,$fimdata){
    $ano=substr(date("Y/m/d",$data),0,4);
    $feriados=[
        "Confraternização Universal" => "{$ano}/01/01",
        "Carnaval" => "{$ano}/03/01", 
        "Sexta-feira Santa" => "{$ano}/04/02",  
        "Páscoa"=>"{$ano}/04/17", 
        "Tiradentes" => "{$ano}/04/21", 
        "Dia Mundial do Trabalho" => "{$ano}/05/01", 
        "Corpus Christi" => "{$ano}/16/06",
        "Independência do Brasil" => "{$ano}/09/07", 
        "Nossa Senhora Aparecida" => "{$ano}/10/12", 
        "Finados" => "{$ano}/11/02", 
        "Proclamação da República" => "{$ano}/09/15", 
        "Natal" => "{$ano}/12/25"
    ];
    
}
?>
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
        if(preg_match("#^(0[1-9]|1[1-9]|2[1-9]|3[0-1])\/(0[1-9]|1[0-2])\/[0-9]*$#",$data)){
            $format_data=substr($data,6)."/".substr($data,3,-5)."/".substr($data,0,2);
            echo 'começo data:'.$data;
            echo "<br>";
            if(preg_match("#^[1-9]{1}[0-9]*$#",$dias)){
                echo "dias uteis ".$dias;
                echo calculardata(strtotime($format_data),strtotime($format_data ."+{$dias} days"));
            }
            else echo "dias inválidos";
        }
        else echo "Data inválida";    
    } else echo "a Data e os Dias uteis não foram enviados";
    echo "<br>";






















    echo "<h3>Exercicio 3</h3>";
    if(isset($_POST["valor"])){
        $valor=$_POST["valor"];
        echo 'valor:'.$valor;
        //echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "valor não foi enviado";
?>
</body>
</html>