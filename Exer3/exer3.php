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
    $dezena_bug=['dez','onze','doze','treze','quatorze','quinze','dezesseis','dezessete','dezoito','dezenove'];
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
            //$newstring=preg_replace("/e um mil/","e mil",$newstring);
            $newstring=preg_replace("/cento e mil/"," cento e um mil ",$newstring);

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
        $valor=preg_replace("/ reais tres /"," reais e tres ",$valor);
        $valor=preg_replace("/ reais quatro /"," reais e quatro ",$valor);
        $valor=preg_replace("/ reais cinco /"," reais e cinco ",$valor);
        $valor=preg_replace("/ reais seis /"," reais e seis ",$valor);
        $valor=preg_replace("/ reais sete /"," reais e sete ",$valor);
        $valor=preg_replace("/ reais oito /"," reais e oito ",$valor);
        $valor=preg_replace("/ reais nove /"," reais e nove ",$valor);
        
        $valor=preg_replace("/ real um /"," real e um ",$valor);
        $valor=preg_replace("/ real dois /"," real e dois ",$valor);
        $valor=preg_replace("/ real tres /"," real e tres ",$valor);
        $valor=preg_replace("/ real quatro /"," real e quatro ",$valor);
        $valor=preg_replace("/ real cinco /"," real e cinco ",$valor);
        $valor=preg_replace("/ real seis /"," real e seis ",$valor);
        $valor=preg_replace("/ real sete /"," real e sete ",$valor);
        $valor=preg_replace("/ real oito /"," real e oito ",$valor);
        $valor=preg_replace("/ real nove /"," reais e nove ",$valor);
        $valor=preg_replace("/ e   centavos/","",$valor);
            
        $valor=preg_replace("/ mil cem reais/ "," mil e cem reais",$valor);
        $valor=preg_replace("/ mil duzentos reais/ "," mil e duzentos reais",$valor);
        $valor=preg_replace("/ mil trezentos reais/ "," mil e trezentos reais",$valor);
        $valor=preg_replace("/ mil quatrocentos reais/ "," mil e quatrocentos reais",$valor);
        $valor=preg_replace("/ mil quinhentos reais/ "," mil e quinhentos reais",$valor);
        $valor=preg_replace("/ mil seiscentos reais/ "," mil e seiscentos reais",$valor);
        $valor=preg_replace("/ mil setecentos reais/ "," mil e setecentos reais",$valor);            
        $valor=preg_replace("/ mil oitocentos reais/ "," mil e oitocentos reais",$valor);
        $valor=preg_replace("/ mil novecentos reais/ "," mil e novecentos reais",$valor);

        $valor=preg_replace("/ milhao cem reais/ "," milhao e cem reais",$valor);
        $valor=preg_replace("/ milhao duzentos reais/ "," milhao e duzentos reais",$valor);
        $valor=preg_replace("/ milhao trezentos reais/ "," milhao e trezentos reais",$valor);
        $valor=preg_replace("/ milhao quatrocentos reais/ "," milhao e quatrocentos reais",$valor);
        $valor=preg_replace("/ milhao quinhentos reais/ "," milhao e quinhentos reais",$valor);
        $valor=preg_replace("/ milhao seiscentos reais/ "," milhao e seiscentos reais",$valor);
        $valor=preg_replace("/ milhao setecentos reais/ "," milhao e setecentos reais",$valor);            
        $valor=preg_replace("/ milhao oitocentos reais/ "," milhao e oitocentos reais",$valor);
        $valor=preg_replace("/ milhao novecentos reais/ "," milhao e novecentos reais",$valor);
       
        $valor=preg_replace("/ milhoes cem reais/ "," milhoes e cem reais",$valor);
        $valor=preg_replace("/ milhoes duzentos reais/ "," milhoes e duzentos reais",$valor);
        $valor=preg_replace("/ milhoes trezentos reais/ "," milhoes e trezentos reais",$valor);
        $valor=preg_replace("/ milhoes quatrocentos reais/ "," milhoes e quatrocentos reais",$valor);
        $valor=preg_replace("/ milhoes quinhentos reais/ "," milhoes e quinhentos reais",$valor);
        $valor=preg_replace("/ milhoes seiscentos reais/ "," milhoes e seiscentos reais",$valor);
        $valor=preg_replace("/ milhoes setecentos reais/ "," milhoes e setecentos reais",$valor);            
        $valor=preg_replace("/ milhoes oitocentos reais/ "," milhoes e oitocentos reais",$valor);
        $valor=preg_replace("/ milhoes novecentos reais/ "," milhoes e novecentos reais",$valor);

        $valor=preg_replace("/ milhao cem mil / "," milhao e cem mil ",$valor);
        $valor=preg_replace("/ milhao duzentos mil / "," milhao e duzentos mil ",$valor);
        $valor=preg_replace("/ milhao trezentos mil / "," milhao e trezentos mil ",$valor);
        $valor=preg_replace("/ milhao quatrocentos mil / "," milhao e quatrocentos mil ",$valor);
        $valor=preg_replace("/ milhao quinhentos mil / "," milhao e quinhentos mil ",$valor);
        $valor=preg_replace("/ milhao seiscentos mil / "," milhao e seiscentos mil ",$valor);
        $valor=preg_replace("/ milhao setecentos mil / "," milhao e setecentos mil ",$valor);
        $valor=preg_replace("/ milhao oitocentos mil / "," milhao e oitocentos mil ",$valor);
        $valor=preg_replace("/ milhao novecentos mil / "," milhao e novecentos mil ",$valor);

        $valor=preg_replace("/ milhoes cem mil / "," milhoes e cem mil ",$valor);
        $valor=preg_replace("/ milhoes duzentos mil / "," milhoes e duzentos mil ",$valor);
        $valor=preg_replace("/ milhoes trezentos mil / "," milhoes e trezentos mil ",$valor);
        $valor=preg_replace("/ milhoes quatrocentos mil / "," milhoes e quatrocentos mil ",$valor);
        $valor=preg_replace("/ milhoes quinhentos mil / "," milhoes e quinhentos mil ",$valor);
        $valor=preg_replace("/ milhoes seiscentos mil / "," milhoes e seiscentos mil ",$valor);
        $valor=preg_replace("/ milhoes setecentos mil / "," milhoes e setecentos mil ",$valor);
        $valor=preg_replace("/ milhoes oitocentos mil / "," milhoes e oitocentos mil ",$valor);
        $valor=preg_replace("/ milhoes novecentos mil / "," milhoes e novecentos mil ",$valor);
        
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
                }
                else{
                    echo "<h3>Valor Inválido</h3>";
                    echo "Valor máximo=999999999.99<br>";
                    echo "Valor Mínimo=0.01<br>";
                }
            } else echo "valor não foi enviado";
        echo "</div>";
        echo "<br>";
    echo "</div>"; 
?>
</main>
</body>
</html>
