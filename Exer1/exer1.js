function validarcpf(){
    const input=document.getElementById('cpf');
    const cpf=input.value;
    let regexp = new RegExp(input.pattern);
    if (!regexp.test(cpf)) {
        input.value = "";
        input.focus();
        return;
    }
    else{
      if(cpf_eh_valido(cpf)&&cpf!="000000000-00"){
        document.getElementById('form1').submit()
      }
      else{
        input.value = "";
        input.focus();
      }
    }

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