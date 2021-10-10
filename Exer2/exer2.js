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