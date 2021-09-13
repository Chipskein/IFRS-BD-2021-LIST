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
    //document.getElementById('form2').submit()
}
function validarvalor(){
    //document.getElementById('form3').submit()
}
function validarcalc(){
    //document.getElementById('form4').submit()
}
function validarcalc(){
    //document.getElementById('form5').submit()
}
