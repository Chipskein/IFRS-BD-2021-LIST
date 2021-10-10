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
 function calculatedatabypascoa($ano,$feriado_name){
    $data="";
    switch($feriado_name){
        case "pascoa":
            $data=date("Y/m/d",easter_date((int)$ano));
            break;
        case "carnaval":
            $data=date("Y/m/d",strtotime("-47 days",easter_date((int)$ano)));
            break;
        case "corpos":
            $data=date("Y/m/d",strtotime("+60 days",easter_date((int)$ano)));
            break;
        case "sexta":
            $data=date("Y/m/d",strtotime("-2 days",easter_date((int)$ano)));
        break;
    }
    //echo $feriado_name.": ".$data."<br>";
    return $data;
}
function eh_feriados($data){
    $ano=substr($data,0,4);
    $pascoa=calculatedatabypascoa($ano,"pascoa");
    $carnaval=calculatedatabypascoa($ano,"carnaval");
    $corpos=calculatedatabypascoa($ano,"corpos");
    $sexta=calculatedatabypascoa($ano,"sexta");
    $feriados=[
        "Confraternização Universal" => "{$ano}/01/01",
        "Carnaval" => "{$carnaval}", 
        "Sexta-feira Santa" => "{$sexta}",  
        "Páscoa"=>"{$pascoa}", 
        "Tiradentes" => "{$ano}/04/21", 
        "Dia Mundial do Trabalho" => "{$ano}/05/01", 
        "Corpus Christi" => "{$corpos}",
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
    $c=0;
    while($c<$dias){
        $newdata=date('Y/m/d',strtotime($newdata ."+1 day"));
        if(!eh_feriados($newdata)){
            $weekday=date('N',strtotime($newdata));
            if($weekday!=6&&$weekday!=7){
                $c++;
                //echo "não é feriado e é dia de semana ".$newdata."<br>";
            }
        }
        //else echo "é feriado ".$newdata."<br>";
    }
    return date("d/m/Y",strtotime($newdata));
}
function validar_data($data){
    $day=substr($data,0,2);
    $month=substr($data,3,2);
    $year=substr($data,6);    
    $day_qt=0; //31,30,29,28
    $bissexto = false;
    if (($year % 4 == 0 && $year % 100 !== 0) || ($year % 400 == 0)) $bissexto = true;
    switch ($month) {
      case 1:
        $day_qt = 31;
        break;
      case 2:
        if ($bissexto) $day_qt = 29;
        else $day_qt = 28;
        break;
      case 3:
        $day_qt = 31;
        break;
      case 4:
        $day_qt = 30;
        break;
      case 5:
        $day_qt = 31;
        break;
      case 6:
        $day_qt = 30;
        break;
      case 7:
        $day_qt = 31;
        break;
      case 8:
        $day_qt = 31;
        break;
      case 9:
        $day_qt = 30;
        break;
      case 10:
        $day_qt = 31;
        break;
      case 11:
        $day_qt = 30;
        break;
      case 12:
        $day_qt = 31;
        break;
    }
    if ($day <= $day_qt) return true;
    else return false;
};
?>
<?php
    echo "<div id='main' align=center>";        
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
            echo "</div>";
            echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
