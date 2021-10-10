function validarvalor(){
    
    const input=document.getElementById("valor");
    const valor=input.value;
    let regexp = new RegExp(input.pattern);
    if (!regexp.test(valor)) {
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