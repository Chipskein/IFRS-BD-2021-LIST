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
            background-color: #504E4E;
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
function convertToNumber($name){
    $numeros = array(
        "um" => 1,
        "dois" => 2,
        "tres" => 3,
        "quatro" => 4,
        "cinco" => 5,
        "seis" => 6,
        "sete" => 7,
        "oito" => 8,
        "nove" => 9,
        'dez' => 10,
        'onze' => 11,
        'doze' => 12,
        'treze' => 13,
        'quatorze' => 14,
        'quinze' => 15,
        'dezesseis' => 16,
        'dezessete' => 17,
        'dezoito' => 18,
        'dezenove' => 19,
        "vinte" => 20,
        "trinta" => 30,
        "quarenta" => 40,
        "cinquenta" => 50,
        "sessenta" => 60,
        "setenta" => 70,
        "oitenta" => 80,
        "noventa" => 90,
        "cem" => 100,
        "cento" => 100,
        "duzentos" => 200,
        "trezentos" => 300,
        "quatrocentos" => 400,
        "quinhentos" => 500,
        "seiscentos" => 600,
        "setecentos" => 700,
        "oitocentos" => 800,
        "novecentos" => 900,
    );
    $value1=0;
    $value2=0;
    $value3=0;
    $name = explode(" ",$name);
    for($c=0;$c<=count($name)-1;$c++){            
        if($name[$c]=='milhao'|$name[$c]=='milhoes'){
            for($c1=$c;$c1>=0;$c1--){
                $value1+=$numeros["{$name[$c1]}"];
            };
            $value1*=1000000;
        }
        if($name[$c]=='mil'){
            if(array_search('milhao',$name)===false&&array_search('milhoes',$name)===false){
                for($c1=$c;$c1>=0;$c1--){
                    $value2+=$numeros["{$name[$c1]}"];
                };
                $value2*=1000;
            }
            else{
                if(array_search('milhao',$name)){
                    for($c1=$c;$c1>array_search('milhao',$name);$c1--){
                        $value2+=$numeros["{$name[$c1]}"];
                    };
                    $value2*=1000;
                };
                if(array_search('milhoes',$name)){
                    for($c1=$c;$c1>array_search('milhoes',$name);$c1--){
                        $value2+=$numeros["{$name[$c1]}"];
                    };
                    $value2*=1000;
                }
            }
        }
        if(array_search('mil',$name)===false&&array_search('milhoes',$name)===false&&array_search('milhao',$name)===false){
            $value3+=$numeros["{$name[$c]}"];
        }
        else{
            if($c>array_search('mil',$name)&&$c>array_search('milhoes',$name)&&$c>array_search('milhao',$name)){
                $value3+=$numeros["{$name[$c]}"];
            }
        }
    };
    $value=$value1+$value2+$value3;
    return $value;
};
function validar_number($numba1,$numba2){
        
    $regexp="((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|((e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(e (dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|((e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(e (dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|((e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(e (dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$))))$|(((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|((e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(e (dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)";
    //remove os espaços entre as palavras e compara com o padrão
    $numba1=trim($numba1);
    $numba2=trim($numba2);
    $numba1_corrigido=[];
    $numba2_corrigido=[];
    $numba1_array=explode(" ",$numba1);
    foreach( $numba1_array as $index => $palavra){
        if(trim($palavra)!=""){
            array_push($numba1_corrigido,$palavra);
        }
    };
    $numba2_array=explode(" ",$numba2);
    foreach( $numba2_array as $index => $palavra){
        if(trim($palavra)!=""){
            array_push($numba2_corrigido,$palavra);
        }
    };
    //correçẽos
    if($numba1_corrigido[0]=='um'&&$numba1_corrigido[1]=='milhoes') $numba1_corrigido[1]='bloqueado';
    if($numba2_corrigido[0]=='um'&&$numba2_corrigido[1]=='milhoes') $numba2_corrigido[1]='bloqueado'; 
    if($numba1_corrigido[0]=='um'&&$numba1_corrigido[1]=='milhao') $numba1_corrigido[1]='milhoes';
    if($numba2_corrigido[0]=='um'&&$numba2_corrigido[1]=='milhao') $numba2_corrigido[1]='milhoes'; 
    $numba1=implode(" ",$numba1_corrigido);
    $numba2=implode(" ",$numba2_corrigido);
    //regex
    if(preg_match("#$regexp#",$numba1)&&preg_match("#$regexp#",$numba2)) return true;
    else false;
};
function calcular_number($n1,$n2,$operacao){
    $result=0;
    switch($operacao){
        case "+":
            $result=$n1+$n2;
        break;
        case "*":
            $result=$n1*$n2;
        break;
        case "-":
            $result=$n1-$n2;
        break;
        case "/":
            $result=$n1/$n2;
        break;
    }
    return $result;
};
?>
<?php
    echo "<div id='main' align=center>";        
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
                    echo "Resultado de {$n1}{$operacao}{$n2}={$calculo}<br>";
                }
                else echo "Valores inválidos";        

            } else echo "operador e numeros nao foram enviados";
        echo "</div>";
        echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
