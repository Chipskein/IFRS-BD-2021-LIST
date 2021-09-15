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
function num_to_string($num){
    $unidade=["um","dois","tres","quatro","cinco","seis","sete","oito","nove"];//1
    $dezena_bug=['dez','onze','doze','treze','quatorze','quinze','desseseis','dessesete','dezoito','dezenove'];
    $dezena=["dez","vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa"];//2
    $centena=["cento","duzentos","trezentos","quatrocentos","quinhentos","seissentos","setecentos","oitocentus","novecentos"];//3
    //parte inteiro
    if(strpos($num,".")===false&&strpos($num,",")===false){
        $newstring="";
        $test=$num;
        $deb_dezena=false;
        $deb_dezena2=false;
        $deb_dezena3=false;
        for($c=0;$c<=strlen($num);$c++){
            switch(strlen($num)){
                case 1:
                    if(!$deb_dezena){
                        $newstring.=$unidade[((int)$num[$c]-1)]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $newstring.=$dezena_bug[((int)$num[$c])]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    break;
                case 2:
                    if($num[$c]!='1'){
                        $newstring.=$dezena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $deb_dezena=true;
                        $num=substr($num,$c+1);
                        $c--;
                    }

                    break;
                case 3:
                    if($num[$c]=='1'&&$num[$c+1]=='0'&&$num[$c+2]=='0'){
                        $newstring.='cem';
                        $num=substr($num,$c+1);
                        $c--;          
                    }
                    else{
                        $newstring.=$centena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;   
                    }
                    break;
                case 4:
                    if(!$deb_dezena2){
                        $newstring.=$unidade[((int)$num[$c])-1]." mil"." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $newstring.=$dezena_bug[((int)$num[$c])]." mil"." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    break;
                case 5:
                    if($num[$c]!='1'){
                        $newstring.=$dezena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $deb_dezena2=true;
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    break;
                
                
                
                       
                case 6:
                    if($num[$c]=='1'&&$num[$c+1]=='0'&&$num[$c+2]=='0'){
                        $newstring.='cem';
                        $num=substr($num,$c+1);
                        $c--;          
                    }
                    else{
                        $newstring.=$centena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;   
                    }
                    break;
                case 7:
                    if(!$deb_dezena3){
                        $newstring.=$unidade[((int)$num[$c])-1]." milhoes"." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $newstring.=$dezena_bug[((int)$num[$c])]." milhoes"." ";
                        $num=substr($num,$c+1);
                        $c--;
                    };
                    break;  
                case 8:
                    if($num[$c]!='1'){
                        $newstring.=$dezena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $deb_dezena3=true;
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    break;

                case 9:
                    if($num[$c]=='1'&&$num[$c+1]=='0'&&$num[$c+2]=='0'){
                        $newstring.='cem';
                        $num=substr($num,$c+1);
                        $c--;          
                    }
                    else{
                        $newstring.=$centena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;   
                    }
                    break;                     
            }
        }
        $newstring=trim($newstring);
        //correções
            $newstring=preg_replace("/ /"," e ",$newstring);
            $newstring=preg_replace("/ e  e /"," e ",$newstring);
            $newstring=preg_replace("/um e mil/"," Mil ",$newstring);
            $newstring=preg_replace("/ e milhoes/"," Milhoes ",$newstring);
            $newstring=preg_replace("/ e mil/"," Mil ",$newstring);
            $newstring=preg_replace("/  e  e /"," e ",$newstring);
            $newstring=preg_replace("/ e  Milhoes /"," Milhoes ",$newstring);
            $newstring=preg_replace("/Mil hoes/"," Milhoes ",$newstring);
            $newstring=preg_replace("/ Milhoes  e  Mil /"," Milhoes ",$newstring);
            $newstring=preg_replace("/cento e  Mil/"," cento e um Mil ",$newstring);            

        /*
        $newstring=explode(" ",$newstring);
        foreach ($newstring as $c => $char) {
            echo "CHAR{$c}:".$char."<br>";
        }
        $newstring=implode(" ",$newstring);
        echo "consertado:".$newstring."<br>";
        */
        return $newstring ." Reais";
        //echo "Test {$test}: ".$newstring."<br>";
    }
    //parte decimal
    else{
        $num=substr($num,+2);
        if(strlen($num)==1){
            $num.="0";
        }
        $newstring="";
        $deb_dezena=false;
        for($c=0;$c<=strlen($num);$c++){
            switch(strlen($num)){
                case 1:
                    if(!$deb_dezena){
                        $newstring.=$unidade[((int)$num[$c]-1)]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $newstring.=$dezena_bug[((int)$num[$c])]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    break;
                case 2:
                    if($num[$c]!='1'){
                        $newstring.=$dezena[((int)$num[$c])-1]." ";
                        $num=substr($num,$c+1);
                        $c--;
                    }
                    else{
                        $deb_dezena=true;
                        $num=substr($num,$c+1);
                        $c--;
                    }

                    break;                    
            }
        }
        return "com ".$newstring." centavos";
    }
}
function transcrever_valor($valor){
    $valor_int=$valor;
    $valor_decimal=0.0;
    //separa a parte inteira e decimal
    for($c=0;$c<=strlen($valor);$c++){
        $valor_int=substr($valor,0,$c);
        if(strpos($valor,".")!==false&&$c==strpos($valor,".")||strpos($valor,",")!==false&&$c==strpos($valor,",")) break;  
    }
    if(strpos($valor,".")!==false) $valor_decimal="0.".substr($valor,strpos($valor,".")+1);
    if(strpos($valor,",")!==false) $valor_decimal="0.".substr($valor,strpos($valor,",")+1);
    
    //converter parte inteira
    if($valor_int!='0'){
        $valor=num_to_string($valor_int)." ".num_to_string($valor_decimal);
    }
    else{
        $valor="zero Reais ".num_to_string($valor_decimal);
    }
    //correção
    $valor=preg_replace("/um Reais /"," um Real ",$valor);
    $valor=preg_replace("/e  um Real /","e um Reais ",$valor);
    $valor=preg_replace("/ Reais  Reais/"," Reais ",$valor);
    $valor=preg_replace("/ Real  Reais/"," Real ",$valor);
    return $valor;
}
?>
<?php
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
        if(preg_match("#(^[0](,|\.)([0-9]{1,2})$)|(^[1-9]{1}[0-9]{1,8}(,|\.)[0-9]{1,2}$)|(^[1-9]{1}[0-9]{1,8}$)|(^[1-9]$)|(^[1-9](,|\.)[0-9]{1,2}$)#",$valor)){
            echo 'valor:'." R$ ".$valor."<br>";
            error_reporting(0);//desabilar os warning
            echo "valor transcrito:".transcrever_valor($valor)."<br>";
        }
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