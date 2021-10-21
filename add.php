<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Sabor</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<?php
    echo "<main align='center'>";
    echo "<h2>Pizzaria</h2>";   
    $db=new SQLite3('pizza.db');
    $db->exec("PRAGMA foreign_keys = ON");
    $types=$db->query("select * from tipo");
    $ingredientes=$db->query("select * from ingrediente"); 

    echo "<form method=POST action=\"insert.php\">";
    echo "<label>Nome do Sabor<br>";               
        echo "<input name=\"name_sabor\" type='text'".">";
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
    echo "<br><input id=\"send\" type='button' value=\"Incluir\" >";
    echo "</form>"; 
    $db->close();
    echo "</main>";
?>
<script>
    function remove_flist(id){
        const tr=document.getElementById(`${id}`);
        const option=document.createElement("option");
        option.value=tr.children[0].value;
        option.innerHTML=tr.children[1].innerHTML;
        option.selected=true;
        select_add.append(option);
        tr.remove();
    }
   const select_add=document.querySelector("#select_add");
   const table=document.querySelector("table");
   const input_add=document.querySelector("#add");
   const send=document.querySelector("#send");
   input_add.addEventListener("click",()=>{
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
    });
   send.addEventListener("click",()=>{
        table.children.length==0 ? alert("Adicione ao menos um ingrediente"):document.querySelector("form").submit();
    });
</script>    
</body>
</html>
