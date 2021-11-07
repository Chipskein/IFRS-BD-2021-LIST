<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Sabor</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<?php
    echo "<main align='center'>";
    echo "<h2>Pizzaria</h2>";   
    $db=new SQLite3('../pizza.db');
    $db->exec("PRAGMA foreign_keys = ON");
    $sabores_name=$db->query("select group_concat(sabor.nome,\",\") as sabores from sabor")->fetchArray();
    echo "<script>";
    echo "let sabores=\"$sabores_name[0]\".split(\",\")";
    echo "</script>";
    $types=$db->query("select * from tipo");
    $ingredientes=$db->query("select * from ingrediente"); 
    echo "<form method=POST action=\"insert.php\" id=form>";
    echo "<label>Nome do Sabor<br>";               
        echo "<input id=name_sabor name=\"name_sabor\" type=text".">";
    echo "</label>"; 
    echo "<br>";           
    echo "Tipo<br>";
        echo "<select name=tipo>";
            while($row=$types->fetchArray()){
                $nome=$row['nome'];
                $codigo=$row['codigo'];
                echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
            }
        echo "</select>";
    echo "<br>";
    echo "Ingrediente<br>";
        echo "<select id=\"select_add\">";
            while($row=$ingredientes->fetchArray()){
                $nome=$row['nome'];
                $codigo=$row['codigo'];
                echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
            }
        echo "</select><input id=\"add\" type='button' value=\"➕\"><br>";
    echo "Ingredientes:";
    echo "<div align='center'>";
        echo "<table>";
        echo "</table>";
    echo "<div>";
    echo "</form>";
    echo "<br><input id=\"send\" type='button' value=\"Incluir\" >"; 
    $db->close();
    echo "</main>";
?>
<script>
    function verificar(){
        console.log("Verificando");
        let input=document.getElementById("name_sabor");
        val=input.value
        alp='ABCDEFGHIJKLMNOPQRSTUVXYZW'.split('');
        input.value=val.toUpperCase();
        input_val=input.value;
        if(input.value.trim()!=""){
            accents=false;
            for(c=0;c<input_val.length;c++){
                if(alp.includes(input_val[c].trim().toUpperCase())||input_val[c].trim().toUpperCase()==''){
                    console.log("passou:"+input_val[c].trim().toUpperCase())
                }
                else{
                    console.log("Acento:"+input_val[c].trim().toUpperCase())
                    accents=true;
                    break;
                }
            }
            if(!accents&&!sabores.includes(input.value)){
                console.log("Válido")
                document.querySelector("form").submit();
            }
            else{
                console.log("erro");
                input.value = "";
                input.focus();
            }
        }
        else{
            console.log("erro");
            input.value = "";
            input.focus();
        }
    };
    function remove_flist(id){
        const tr=document.getElementById(`${id}`);
        const option=document.createElement("option");
        option.value=tr.children[0].value;
        option.innerHTML=tr.children[1].innerHTML;
        option.selected=true;
        select_add.append(option);
        tr.remove();
    }
   const select_add=document.querySelector("select#select_add");
   const table=document.querySelector("table");
   const input_add=document.querySelector("input#add");
   const send=document.querySelector("input#send");
   const form=document.getElementById("form");
   form.addEventListener("keydown",(event)=>{
        if(event.keyCode == 13) {
        event.preventDefault();
        return false;
    }})
   input_add.addEventListener("click",()=>{
       if(select_add.options.length>0){
        table.children.length==0 ? last_index=0:last_index=table.children.length;
        const tr=document.createElement("tr");
        let input=document.createElement("input");
            input.name=`input_ingrediente${last_index}`;
            input.type="hidden";
            input.value=select_add.options[select_add.selectedIndex].value;
            tr.append(input);
        const td=document.createElement("td");
            td.innerText=select_add.options[select_add.selectedIndex].innerText;
            tr.append(td);
        input=document.createElement("input");
            input.type="button";
            input.value="❌";
            input.addEventListener("click",()=>{remove_flist(tr.id)})
            tr.append(input);
        tr.id=`tr${last_index}`;
        select_add.options[select_add.selectedIndex].remove();
        table.append(tr);
       }
    });
   send.addEventListener("click",()=>{
        table.children.length==0 ? alert("Adicione ao menos um ingrediente"):verificar();
    });
    
</script>    
</body>
</html>
