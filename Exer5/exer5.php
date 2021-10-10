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
    function converteToRoman($roman){
        $romans = array(
            'M' => 1000,
            'CM' => 900,
            'D' => 500,
            'CD' => 400,
            'C' => 100,
            'XC' => 90,
            'L' => 50,
            'XL' => 40,
            'X' => 10,
            'IX' => 9,
            'V' => 5,
            'IV' => 4,
            'I' => 1,
        );
        
        $result = 0;
        
        foreach ($romans as $key => $value) {
            while (strpos($roman, $key) === 0) {
                $result += $value;
                $roman = substr($roman, strlen($key));
            }
        }
        return $result;
    };
    function calcular_roman($numeros,$operations){
        $string_num="";
        $c=0;
        $cal_params=[];
        foreach($numeros as $index=>$numero){
            if($c<count($numeros)-1){
                $string_num.=converteToRoman($numero).$operations[$c];
                array_push($cal_params,converteToRoman($numero),$operations[$c]);
            }
            else{ 
                $string_num.=converteToRoman($numero);
                array_push($cal_params,converteToRoman($numero));
            }
            $c++;
        };
        $result=0;
        //calcula os 2 primeiros
        switch($cal_params[1]){
            case "+":
                $result=$cal_params[0]+$cal_params[2];
            break;
            case "*":
                $result=$cal_params[0]*$cal_params[2];
            break;
            case "-":
                $result=$cal_params[0]-$cal_params[2];
            break;
            case "/":
                $result=$cal_params[0]/$cal_params[2];
            break;
        }
        //calcula o resto se tiver
        for($c=2;$c<=count($cal_params)-1;$c++){
            if($c%2!=0){
            switch($cal_params[$c]){
                case "+":
                    $result+=$cal_params[$c+1];
                break;
                case "*":
                    $result*=$cal_params[$c+1];
                break;
                case "-":
                    $result-=$cal_params[$c+1];
                break;
                case "/":
                    $result/=$cal_params[$c+1];
                break;
                }
            }   
            }
        echo "Conta: ".$string_num."=".$result."<br>";

    };
?>
<?php
    echo "<div id='main' align=center>";        
    echo "<div class='exerc'>";
    echo "<h3>Exercicio 5</h3>";
    if(isset($_POST['submited'])){
        $numeros=[];
        $operations=[];
        $pass=false;
        foreach ($_POST as $key => $value){
            if(preg_match('/numero/',$key)){
                $value=strtoupper($value);
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
