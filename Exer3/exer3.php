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
 function num_to_string($num){
    $unidade=["um","dois","tres","quatro","cinco","seis","sete","oito","nove"];//1
    $dezena_bug=['dez','onze','doze','treze','quatorze','quinze','desseseis','dessesete','dezoito','dezenove'];
    $dezena=["dez","vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa"];//2
    $centena=["cento","duzentos","trezentos","quatrocentos","quinhentos","seiscentos","setecentos","oitocentos","novecentos"];//3
    //parte inteiro
    if(strpos($num,".")===false&&strpos($num,",")===false){
        $newstring="";
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
            $newstring=preg_replace("/ e milhoes e /"," milhoes ",$newstring);
            $newstring=preg_replace("/ e mil e /"," mil ",$newstring);
            $newstring=preg_replace("/ e  e /"," e ",$newstring);
            $newstring=preg_replace("/ e  milhoes /"," milhoes ",$newstring);
            $newstring=preg_replace("/mil hoes/"," milhoes ",$newstring);
            $newstring=preg_replace("/ milhoes  e  mil /"," milhoes ",$newstring);
            $newstring=preg_replace("/ e mil/"," mil ",$newstring);            
            $newstring=preg_replace("/ e  mil /"," mil ",$newstring);  
            $newstring=preg_replace("/um milhoes /"," um milhao ",$newstring);  
            $newstring=preg_replace("/ milhao  mil/"," milhao ",$newstring);  
            $newstring=preg_replace("/ milhoes  mil/"," milhoes ",$newstring);  
            $newstring=preg_replace("/ e  um milhao /"," e um milhoes ",$newstring);
            $newstring=preg_replace("/e um mil/","e mil",$newstring);
            $newstring=preg_replace("/cento e mil/"," cento e um mil ",$newstring);           

            
            /*
        $newstring=explode(" ",$newstring);
        foreach ($newstring as $c => $char) {
            echo "CHAR{$c}:".$char."<br>";
        }
        $newstring=implode(" ",$newstring);
        echo "consertado:".$newstring."<br>";
        */
        return $newstring ." reais";
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
                        $newstring.=$dezena[((int)$num[$c])-1]." e ";
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
        return "e ".$newstring." centavos";
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
    if($valor_int!='0') $valor=num_to_string($valor_int)." ".num_to_string($valor_decimal);
    else $valor="0".num_to_string($valor_decimal)." de real";
    //correções
        $valor=preg_replace("/um reais /"," um real ",$valor);
        $valor=preg_replace("/e  um real /","e um reais ",$valor);
        $valor=preg_replace("/e   centavos/"," centavos",$valor);
        $valor=preg_replace("/ reais  reais/"," reais ",$valor);
        $valor=preg_replace("/ real  reais/"," real ",$valor);
        $valor=preg_replace("/0e  e /","",$valor);
        $valor=preg_replace("/e  e /","",$valor);
        $valor=preg_replace("/0e /","",$valor);
        $valor=preg_replace("/ reais um /"," reais e um ",$valor);
        $valor=preg_replace("/ reais dois /"," reais e dois ",$valor);
        $valor=preg_replace("/ reais três /"," reais e tres ",$valor);
        $valor=preg_replace("/ reais quatro /"," reais e quatro ",$valor);
        $valor=preg_replace("/ reais cinco /"," reais e cinco ",$valor);
        $valor=preg_replace("/ reais seis /"," reais e seis ",$valor);
        $valor=preg_replace("/ reais sete /"," reais e sete ",$valor);
        $valor=preg_replace("/ reais oito /"," reais e oito ",$valor);
        $valor=preg_replace("/ reais nove /"," reais e nove ",$valor);
    return $valor;
}
?>
<?php
    echo "<div id='main' align=center>";        
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
        echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
