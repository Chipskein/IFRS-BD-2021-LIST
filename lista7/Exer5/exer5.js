
function validarcalcr(){
    const inputs=document.querySelectorAll("div#form-div1>input");
    for(let c=0;c<=inputs.length-1;c++){
      let input=inputs[c];
      let regexp = new RegExp(input.pattern);
      if(!regexp.test(input.value.toUpperCase())){
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
    const input_count=document.querySelectorAll('input').length
    //numero
    if(input_count < 10 ){
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
