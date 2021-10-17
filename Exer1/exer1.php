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
            width: 50%;
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
    function validar_cpf($cpf){
        if($cpf!=="000000000-00"&&$cpf!=="111111111-11"&&$cpf!=="222222222-22"&&$cpf!=="333333333-33"&&$cpf!=="444444444-44"&&$cpf!=="555555555-55"&&$cpf!=="666666666-66"&&$cpf!=="777777777-77"&&$cpf!=="888888888-88"&&$cpf!=="999999999-99"){
            $digitos=$cpf;
            $validata_numba1=(($digitos[0]*10+$digitos[1]*9+$digitos[2]*8+$digitos[3]*7+$digitos[4]*6+$digitos[5]*5+$digitos[6]*4+$digitos[7]*3+$digitos[8]*2)*10)%11;
            $validata_numba2=(($digitos[0]*11+$digitos[1]*10+$digitos[2]*9+$digitos[3]*8+$digitos[4]*7+$digitos[5]*6+$digitos[6]*5+$digitos[7]*4+$digitos[8]*3+$validata_numba1*2)*10)%11;
            if($validata_numba1==10) $validata_numba1=0;
            if($validata_numba2==10) $validata_numba2=0;
            if($validata_numba1==$digitos[10]&&$validata_numba2==$digitos[11]) return true;
            else false;
        }
        else return false;
    };
?>
<?php
    echo "<div id='main' align=center>";        
        echo "<div class='exerc'>";
            echo "<h3>Exercicio 1</h3>";
            if(isset($_POST["cpf"])){
                $cpf=$_POST["cpf"];
                echo (preg_match("#[0-9]{9}-[0-9]{2}$#",$cpf)&&validar_cpf($cpf)) ?  "CPF ".$cpf." foi cadastrado com sucesso":"Seu cpf não foi cadastrado com sucesso";
            } else echo "CPF não foi enviado";
            echo "</div>";
            echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
