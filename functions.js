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
    console.log(input);
    console.log(valor);
    //se for valido
      //document.getElementById('form3').submit()
    //senão
    /*
        console.log("erro");
        input.value = "";
        input.focus();
    */
}
function validarcalc(){
    //se for valido
      //document.getElementById('form4').submit()
    //senão
    /*
        console.log("erro");
        input.value = "";
        input.focus();
    */
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
