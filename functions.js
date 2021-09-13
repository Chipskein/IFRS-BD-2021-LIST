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
function validarcalcr(){
    //document.getElementById('form5').submit()
}
