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
function eh_feriados($data){
    $ano=substr($data,0,4);
    $feriados=[
        "Confraternização Universal" => "{$ano}/01/01",
        "Carnaval" => "{$ano}/03/01", 
        "Sexta-feira Santa" => "{$ano}/04/02",  
        "Páscoa"=>"{$ano}/04/17", 
        "Tiradentes" => "{$ano}/04/21", 
        "Dia Mundial do Trabalho" => "{$ano}/05/01", 
        "Corpus Christi" => "{$ano}/06/16",
        "Independência do Brasil" => "{$ano}/09/07", 
        "Nossa Senhora Aparecida" => "{$ano}/10/12", 
        "Finados" => "{$ano}/11/02", 
        "Proclamação da República" => "{$ano}/11/15", 
        "Natal" => "{$ano}/12/25"
    ];
    if(in_array($data,$feriados)) return true;
    else return false;
};
function calculardata($data,$dias){
    $newdata=date('Y/m/d',$data);
    echo "loop start"."<br>";
    $c=0;
    while($c<$dias){
        $newdata=date('Y/m/d',strtotime($newdata ."+1 day"));
        if(!eh_feriados($newdata)){
            $weekday=date('N',strtotime($newdata));
            if($weekday!=6&&$weekday!=7){
                $c++;
                echo "não é feriado e é dia de semana ".$newdata."<br>";
            }
        }
        else echo "é feriado ".$newdata."<br>";
    }
    echo "loop end"."<br>";
    return date("d/m/Y",strtotime($newdata));
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
                echo "dias uteis ".$dias."<br>";
                echo "Data Final(contado apartir do dia informado):".calculardata(strtotime($format_data),$dias)."<br>";
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
    
    echo "<h3>Exercicio 4</h3>";
    if(isset($_POST["numero1"])&&isset($_POST["operation"])&&isset($_POST["numero2"])){
        $numero1=$_POST["numero1"];
        $operacao=$_POST["operation"];
        $numero2=$_POST["numero2"];        
        echo 'numero1:'.$numero1."<br>";
        echo 'operacao:'.$operacao."<br>";
        echo 'numero2:'.$numero2."<br>";
        //echo (preg_match("#^[0-9]{9}-[0-9]{2}#",$cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
    } else echo "operador e numeros nao foram enviados";
    
    echo "<h3>Exercicio 5</h3>";
    if(isset($_POST['submited'])){
        var_dump($_POST);
        //forech numero e operation;
    }else echo "operador e numeros nao foram enviados";
      
?>
</body>
</html>