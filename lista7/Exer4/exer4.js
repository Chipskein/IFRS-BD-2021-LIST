function validarcalc(){
    let teste1=false;
    let teste2=false;
    const input=document.getElementById('numero1');
    const input2=document.getElementById('numero2');
    let regexp = new RegExp(input.pattern);
    let regexp2 = new RegExp(input2.pattern);
    let numba1=input.value.trim();
    let numba2=input2.value.trim();
    let numba1_corrigido=[];
    let numba2_corrigido=[];
    numba1_array=numba1.split(" ");
    numba1_array.forEach(palavra => {
      if(palavra.trim()!=""){
        numba1_corrigido.push(palavra);
      }
    });
    numba2_array=numba2.split(" ");
    numba2_array.forEach(palavra => {
      if(palavra.trim()!=""){
        numba2_corrigido.push(palavra);
      }
    });
    if(numba1_corrigido[0]=='um'&&numba1_corrigido[1]=='milhoes') numba1_corrigido[1]='bloqueado';
    if(numba2_corrigido[0]=='um'&&numba2_corrigido[1]=='milhoes') numba2_corrigido[1]='bloqueado'; 
    if(numba1_corrigido[0]=='um'&&numba1_corrigido[1]=='milhao') numba1_corrigido[1]='milhoes';
    if(numba2_corrigido[0]=='um'&&numba2_corrigido[1]=='milhao') numba2_corrigido[1]='milhoes'; 
    numba1=numba1_corrigido.join(" ");
    numba2=numba2_corrigido.join(" ");
    if(regexp.test(numba1)) teste1=true;
    else{
      input.value = "";
      input.focus();
    }
    if(regexp2.test(numba2)) teste2=true;
    else{
      input2.value = "";
      input2.focus();
    }
    if(teste1&&teste2) document.getElementById('form4').submit();
  }