function validarcpf(){
    const input=document.getElementById('cpf');
    const cpf=input.value;
    console.log('validando');
    console.log(cpf);
    let regexp = new RegExp(input.pattern);
    console.log(regexp)
    if (!regexp.test(cpf)) {
        console.log("erro");
        input.value = "";
        input.focus();
        return;
    }
    else{
      if(cpf_eh_valido(cpf)&&cpf!="000000000-00"){
        document.getElementById('form1').submit()
      }
      else{
        console.log("erro");
        input.value = "";
        input.focus();
      }
    }

} 
function validardata(){
    console.log("enviando data e dias uteis");
    let teste1=false;
    let teste2=false;
    const input=document.getElementById('data');
    const input2=document.getElementById('dias');
    let regexp = new RegExp(input.pattern);
    let regexp2 = new RegExp(input2.pattern);
    if(!regexp.test(input.value)){
        console.log("erro na data");
        input.value = "";
        input.focus();
    }
    else{
      const day=parseInt(input.value.slice(0,2));
      const mounth=parseInt(input.value.slice(3,5));
      const year=parseInt(input.value.slice(6));        
      if(!verifydate(day,mounth,year)){
          console.log("erro na data");
          input.value = "";
          input.focus();
      }
      else teste1=true;
    }
    if(!regexp2.test(input2.value)){
      console.log("erro nos dias");
      input2.value = "";
      input2.focus();
    } else teste2=true;
    if(teste1&&teste2){
      document.getElementById('form2').submit();   
    }   
}
function validarvalor(){
    
    const input=document.getElementById("valor");
    const valor=input.value;
    let regexp = new RegExp(input.pattern);
    console.log(regexp)
    if (!regexp.test(valor)) {
        console.log("erro");
        input.value = "";
        input.focus();
        return;
    }
    else{
      if(valor.includes(',')){
        input.value=valor.replace(",",".");
      }
      document.getElementById('form3').submit()

    }
}
function validarcalc(){
  /*

//qualquer numero milhão sem mil sem unidade
(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um) milhoes$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)) milhoes$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem) milhoes$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um) milhoes$)|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze) milhoes$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um) milhoes$)
//(qualquer numero) mil sem unidade
//qualquer numero menor q mil
(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um) mil$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)) mil$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem) mil$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um) mil$)|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze) mil$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um) mil$)
(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)
((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) mil$
((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$
//milhoes com centenas de milhar e unidade
((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))))$)
//milhoes
((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$))))$
//999999 pra baixo
(((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)

//regex
"((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((milhoes|milhoes (((((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$))))$|(((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))) ((mil|mil (((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))|((novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem))|(((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um))|(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze))|((dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um)))))$)|((^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e (noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dez) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cento) e ((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)|(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)|(^(novecentos|oitocentos|setecentos|seiscentos|quinhentos|quatrocentos|trezentos|duzentos|cem)$)|(^((noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte) e (nove|oito|sete|seis|cinco|quatro|tres|dois|um)$)|^(noventa|oitenta|setenta|sessenta|cinquenta|quarenta|trinta|vinte|dezenove|dezoito|dezessete|dezesseis|quinze|quatorze|treze|doze|onze)$)|(^(dez|nove|oito|sete|seis|cinco|quatro|tres|dois|um))$)"
  */
  console.log("enviando numba_one  e numba_two");
  let teste1=false;
  let teste2=false;
  const input=document.getElementById('numero1');
  const input2=document.getElementById('numero2');
  let regexp = new RegExp(input.pattern);
  let regexp2 = new RegExp(input2.pattern);
  if(regexp.test(input.value)) teste1=true;
  else{
    console.log("erro no numba one");
    input.value = "";
    input.focus();
  }
  if(regexp2.test(input2.value)) teste2=true;
  else{
    console.log("erro no numba twuuu");
    input2.value = "";
    input2.focus();
  }
  if(teste1&&teste2) document.getElementById('form4').submit();
}
function validarcalcr(){
    //se for valido
    //^(?=[MDCLXVI])M*(C[MD]|D?C*)(X[CL]|L?X*)(I[XV]|V?I*)$ regex 1
    //^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$ regex2
    const inputs=document.querySelectorAll("div#form-div1>input");
    for(let c=0;c<=inputs.length-1;c++){
      let input=inputs[c];
      let regexp = new RegExp(input.pattern);
      if(!regexp.test(input.value)){
        console.log("erro");
        input.value = "";
        input.focus();
        teste=false;
        break;
      }
      else teste=true;
    };
    if(teste){
        const form=document.getElementById('form5');
        const input=document.createElement("input")
        input.type='hidden';
        input.name='submited'
        input.value=true;
        form.append(input);
        form.submit();
    }
}
function addr(){
    
    const div=document.getElementById('form-div1');
    const div_count=document.querySelectorAll('select').length
    const input_count=document.querySelectorAll('input').length-6
    console.log( input_count)
    //numero
    if(input_count <= 10 ){
      const select=document.createElement('select');
          option=document.createElement("option")
              option.value="+";
              option.innerHTML='+';
              select.append(option)
          option=document.createElement("option")
              option.value="/";
              option.innerHTML='/';
              select.append(option)
          option=document.createElement("option")
              option.value="*";
              option.innerHTML='*';
              select.append(option)
          option=document.createElement("option")
              option.value="-";
              option.innerHTML='-';
              select.append(option)
          select.name=`operation${div_count}`
          div.append(select)
          const input=document.createElement('input');
              input.type='text';
              input.size=10;
              input.name=`numero${input_count}`;
              input.pattern="^(?=[MDCLXVI])M*(C[MD]|D?C*)(X[CL]|L?X*)(I[XV]|V?I*)$";
              input.required=true;
          div.append(input);
    }
}
function verifydate(day,month,year){

        let day_qt //31,30,29,28
        let bissexto = false;
        if ((year % 4 == 0 && year % 100 !== 0) || (year % 400 == 0)) bissexto = true;//
        switch (month) {
          case 1:
            day_qt = 31
            break
          case 2:
            if (bissexto) day_qt = 29
            else day_qt = 28
            break
          case 3:
            day_qt = 31
            break
          case 4:
            day_qt = 30
            break
          case 5:
            day_qt = 31
            break
          case 6:
            day_qt = 30
            break
          case 7:
            day_qt = 31
            break
          case 8:
            day_qt = 31
            break
          case 9:
            day_qt = 30
            break
          case 10:
            day_qt = 31
            break
          case 11:
            day_qt = 30
            break
          case 12:
            day_qt = 31
            break
        }
        if (day <= day_qt) return true
        else return false
}
function verifynumba(numba){
}
function cpf_eh_valido(cpf){
  const digitos=cpf.split("");
  let validata_numba1=((digitos[0]*10+digitos[1]*9+digitos[2]*8+digitos[3]*7+digitos[4]*6+digitos[5]*5+digitos[6]*4+digitos[7]*3+digitos[8]*2)*10)%11
  let validata_numba2=((digitos[0]*11+digitos[1]*10+digitos[2]*9+digitos[3]*8+digitos[4]*7+digitos[5]*6+digitos[6]*5+digitos[7]*4+digitos[8]*3+validata_numba1*2)*10)%11
  if(validata_numba1==10){
    validata_numba1=0
  }
  if(validata_numba2==10){
    validata_numba2=0
  }
  if(validata_numba1==digitos[10]&&validata_numba2==digitos[11]) return true;
  else false;
};