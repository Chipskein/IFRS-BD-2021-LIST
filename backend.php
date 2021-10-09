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
        div.exerc{
            text-align: center;
            width: 50%;
            margin-top: 10px;
            background-color: #454141;
        }
        div#ex5{
            width: 70%;
        }
        
        div#main{
            border-top: solid 40px #296179;
            margin: 5%;
            background-color:#504E4E;
            width: 90%;
        }
</style>
<body>
<main>
<?php 

    
?>
<?php
    echo "<div id='main' align=center>";        
        echo "<br>";
        echo "<div class='exerc'>";
            echo "<br>";
            echo "<h3>Exercicio 1</h3>";
            if(isset($_POST["cpf"])){
                $cpf=$_POST["cpf"];
                echo (preg_match("#[0-9]{9}-[0-9]{2}$#",$cpf)&&validar_cpf($cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
            } else echo "CPF não foi enviado";
            echo "<br>";
        echo "</div>";
        echo "<div class='exerc'>";
            echo "<h3>Exercicio 2</h3>";
            if(isset($_POST["data"])&&isset($_POST["dias"])){
                $data=$_POST["data"];
                $dias=$_POST["dias"];
                if(preg_match("#^(0[1-9]|1[1-9]|2[1-9]|3[0-1])\/(0[1-9]|1[0-2])\/[0-9]*$#",$data)&&validar_data($data)){
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
        echo "</div>";
        echo "<div class='exerc'>";
            echo "<h3>Exercicio 3</h3>";
            if(isset($_POST["valor"])){
                $valor=$_POST["valor"];
                if(preg_match("#(^[0](,|\.)([0-9]{1,2})$)|(^[1-9]{1}[0-9]{1,8}(,|\.)[0-9]{1,2}$)|(^[1-9]{1}[0-9]{1,8}$)|(^[1-9]$)|(^[1-9](,|\.)[0-9]{1,2}$)#",$valor)){
                    echo 'valor:'." R$ ".$valor."<br>";
                    error_reporting(0);//desabilar os warning
                    echo "valor transcrito:  ".transcrever_valor($valor)."<br>";
                    /*
                    for($c=0;$c<900000000;$c++){
                        $c1=round($c,2);
                        $val=transcrever_valor($c);
                        echo $val."<br>";
                    }*/
                }
            } else echo "valor não foi enviado";
        echo "</div>";
        echo "<div class='exerc'>";
            echo "<h3>Exercicio 4</h3>";
            if(isset($_POST["numero1"])&&isset($_POST["operation"])&&isset($_POST["numero2"])){
                $numero1=$_POST["numero1"];
                $operacao=$_POST["operation"];
                $numero2=$_POST["numero2"];
                error_reporting(0);//desabilar os warning
                if(validar_number($numero1,$numero2)&&($operacao=='+'|$operacao=='-'|$operacao=='*'|$operacao=='/')){
                    echo $numero1."<br>";
                    echo $operacao."<br>";
                    echo $numero2."<br>";
                    $n1=convertToNumber($numero1);
                    $n2=convertToNumber($numero2);
                    $calculo=calcular_number($n1,$n2,$operacao);
                    echo "Resultado de {$n1}{$operacao}{$n2}={$calculo}";
                }
                else echo "Valores inválidos";        

            } else echo "operador e numeros nao foram enviados";
        echo "</div>";
        echo "<div class='exerc'>";
            echo "<h3>Exercicio 5</h3>";
            if(isset($_POST['submited'])){
                $numeros=[];
                $operations=[];
                $pass=false;
                foreach ($_POST as $key => $value){
                    if(preg_match('/numero/',$key)){
                        if(preg_match("#^(?=[MDCLXVI])M*(C[MD]|D?C*)(X[CL]|L?X*)(I[XV]|V?I*)$#",$value)) {
                            $pass=true;
                            array_push($numeros,$value);
                        }
                        else{ 
                            $pass=false;
                            break;
                        }
                    }
                    if(preg_match('/operation/',$key)){
                        if($value=="+"||$value=="-"||$value=="*"||$value=="/"){
                            $pass=true;
                            array_push($operations,$value);
                        }
                        else{
                            $pass=false;
                            break;
                        } 
                    }
                }
                if($pass) calcular_roman($numeros,$operations);
                else echo "Numeros ou operações inválidas";
            }else echo "operador e numeros nao foram enviados";
        echo "</div>";
        echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
