function validarcpf(){
    const input=document.getElementById('cpf')
    const cpf=input.value
    console.log('validando')
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
        document.getElementById('form1').submit()
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
  console.log("enviando numba_one  e numba_two");
  let teste1=false;
  let teste2=false;
  const input=document.getElementById('numero1');
  const input2=document.getElementById('numero2');
  let regexp = new RegExp(input.pattern);
  let regexp2 = new RegExp(input2.pattern);
  if(!regexp.test(input.value)){
      console.log("erro no numba one");
      input.value = "";
      input.focus();
  }
  else{
    console.log("numba one passou");
    if(verifynumba(input.value)) teste1=true;
    else{
      console.log("erro no numba one");
      input.value = "";
      input.focus();
    }
  }
  if(!regexp2.test(input2.value)){
    console.log("erro no numba two");
    input2.value = "";
    input2.focus();
  }
  else{
    console.log("numba two passou");
    if(verifynumba(input2.value)) teste2=true;
    else{
      console.log("erro no numba two");
      input2.value = "";
      input2.focus();
    }
  }
  if(teste1&&teste2){
      document.getElementById('form4').submit();   
  }
}
function validarcalcr(){
    
    //se for valido
    /*
    const form=document.getElementById('form5');
    const input=document.createElement("input")
      input.type='hidden';
      input.name='submited'
      input.value=true;
    form.append(input);
    form.submit();
  */
 //senão
    /*
        console.log("erro");
        input.value = "";
        input.focus();
    */
}
function addr(){
    
    const div=document.getElementById('form-div1');
    const div_count=document.querySelectorAll('select').length
    const input_count=document.querySelectorAll('input').length-6
    //numero
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
        input.name=`numero${input_count}`
        input.required=true;
    div.append(input);
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
  let eh_palavra_valida=false;
  const palavras_validas=[
  "cento","duzentos","trezentos","quatrocentos","quinhentos","seissentos","setecentos","oitocentus","novecentos",
  "dez","vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa","um","dois","tres"
  ,"quatro","cinco","seis","sete","oito","nove","cem","onze","doze","treze","quatorze","quinze","desseseis","dessete","dezoito","dezenove"
  ,"e","mil","milhoes"
  ]
  //verificar se a as palavras da string são válidas 
  numba=numba.split(" ");
  for(c=0;c<=numba.length-1;c++){
    let palavra=numba[c];
    if(palavras_validas.includes(palavra)) eh_palavra_valida=true;
    else return false;
  }
  numba=numba.join(" ");
  //validar a orderm das palavras
  if(eh_palavra_valida){
    const unidade=["um","dois","tres","quatro","cinco","seis","sete","oito","nove","dez","onze","doze","treze","quatorze","quinze","desseseis","dessesete","dezoito","dezenove","cem"];
    const dezena=["vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa"]
    const centena=["cento","duzentos",'trezentos',"quatrocentos","quinhentos","seiscentos","setecentos","oitocentos","novecentos"]
    just_numba=numba.split(" e ");
    tamanho=0;
    let valido=false;
    switch(just_numba.length){
        case 1:
          //dezena|unidade|centena :cem,duzentos,um,dois,treze
          if(dezena.indexOf(just_numba[tamanho])!=-1||unidade.indexOf(just_numba[tamanho])!=-1||centena.indexOf(just_numba[tamanho])!=-1) valido=true;
          break
        case 2:
          //centena+unidade || dezena+unidade
          console.log(just_numba[tamanho])
          if(dezena.indexOf(just_numba[tamanho])!=-1&&unidade.indexOf(just_numba[tamanho+1])!=-1||centena.indexOf(just_numba[tamanho])!=-1&&dezena.indexOf(just_numba[tamanho+1])!=-1||centena.indexOf(just_numba[tamanho])!=-1&&unidade.indexOf(just_numba[tamanho+1])!=-1) valido=true;
          break;
        case 3:
          //centena+dezena+unidade;
          if(centena.indexOf(just_numba[tamanho])!=-1&&dezena.indexOf(just_numba[tamanho+1])!=-1&&unidade.indexOf(just_numba[tamanho+2])!=-1) valido=true;
          break;
    }
    console.log(valido);
    //if(valido) return true;
    //else return false;
    
  }
}
