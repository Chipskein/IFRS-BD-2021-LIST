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
    const input=document.getElementById('data');
    const input2=document.getElementById('dias');
    let regexp = new RegExp(input.pattern);
    let regexp2 = new RegExp(input2.pattern);
    if (!regexp.test(input.value) || !regexp2.test(input2.value)) {
        if(!regexp.test(input.value)){
            console.log("erro na data");
            input.value = "";
            input.focus();
        }else return;//se tirar o return da pau :)
        
        if(!regexp2.test(input2.value)){
            console.log("erro na dias");
            input2.value = "";
            input2.focus();
        }else return;  
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
        else document.getElementById('form2').submit();
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
  console.log("numba_one e numba_two");
  const input=document.getElementById('numero1');
  const input2=document.getElementById('numero2');
  let regexp = new RegExp(input.pattern);
  let regexp2 = new RegExp(input2.pattern);
  if (!regexp.test(input.value) || !regexp2.test(input2.value)) {
      if(!regexp.test(input.value)){
          console.log("regex:erro na numba1");
          input.value = "";
          input.focus();
      }
      
      else if(!regexp2.test(input2.value)){
          console.log("regex:erro no numba2");
          input2.value = "";
          input2.focus();
      } else return;  
  }
  else{
      if(!verifynumba(input.value)&&!verifynumba(input2.value)){
          if(!verifynumba(input.value)){
            console.log("erro na numba1");
            input.value = "";
            input.focus();
          }
          else{
            console.log("erro na numba2");
            input2.value = "";
            input2.focus();
          }  
      }
      //else document.getElementById('form4').submit();
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
const palavras_validas=[
  "cento","duzentos","trezentos","quatrocentos","quinhentos","seissentos","setecentos","oitocentus","novecentos",
  "dez","vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa","um","dois","tres"
  ,"quatro","cinco","seis","sete","oito","nove","cem","onze","doze","treze","quatorze","quinze","desseseis","dessete","dezoito","dezenove"
  ,"e","mil","milhoes"
]
//verificar se a as palavras da string são válidas 
//validar a orderm das palavras

numba=numba.split(" ");
if(palavras_validas.includes(numba)) console.log("palavra valida");
else console.log("errou");
return true;
}
