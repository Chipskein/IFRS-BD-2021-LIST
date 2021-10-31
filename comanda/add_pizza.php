
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📝</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div align="center">
    <?php
        if(isset($_GET["comanda"])){
            $comanda=$_GET["comanda"];
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $verify=$db->query("select * from comanda where numero=$comanda")->fetchArray()["pago"];
            $comanda_result=$db->query("select * from comanda where numero=$comanda");
            if($verify=="0"){
                echo "<form id=form action=add_p.php method=POST>";
                while($row=$comanda_result->fetchArray()){
                    $numero=$row["numero"];
                    $data=$row["data"];
                    echo "Numero: <input id=numero name=numero class=input_d type=text disabled value=$numero><br>";
                    echo "data: <input id=data name=data type=text disabled value=$data><br>";
                }
                $tamanho=$db->query("select * from tamanho");
                echo "Tamanho:<select name=tamanho id=select_tamanho>";
                while($row=$tamanho->fetchArray()){
                    $nome=$row["nome"];
                    $codigo=$row["codigo"];
                    $qt=$row["qtdesabores"];
                    echo "<option value=\"$codigo,$qt\">$nome</option>";
                }
                echo "</select><br>";
                $borda=$db->query("select codigo,nome from borda");
                echo "borda:<select name=borda>";
                echo "<option value=\"no\">S/BORDA</option>";
                while($row=$borda->fetchArray()){
                    $nome=$row["nome"];
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">$nome</option>";
                }
                echo "</select><br>";
                $sabores=$db->query("select * from sabor");
                echo "<table id=sabores style=display:none>";
                while($row=$sabores->fetchArray()){
                    echo "<tr >";
                    echo "<td>$row[codigo]</td>";
                    echo "<td>$row[nome]</td>";
                    echo "<td>$row[tipo]</td>";
                    echo "</tr>";
                }
                echo "</table>";
                $tipo=$db->query("select codigo,nome from tipo");
                echo "Sabores:<select name=tipo id=tipo>";
                while($row=$tipo->fetchArray()){
                    $nome=$row["nome"];
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">$nome</option>";
                }
                echo "</select><div id=add_selects></div><input id=input_add type=button value='➕'>";
                
                echo "<br>";
                echo "<table id=table_sabores></table>";
                echo "<input id=input_send type=button value='Incluir'>";
                echo "</form>";
                $db->close();
            }
            else{
                $db->close();
                echo "<h2>Comanda inválida</h2>";
                echo "<h2>Retornando...</h2>";
                header( "refresh:1;url=comandas_index.php" );
                die();
            }
        }
        else{
            echo "<h2>Erro</h2>";
            echo "<h2>Dados não foram enviados</h2>";
        }
    ?>
    </div>
<script>
    function remove_flist(id){
        const tr=document.getElementById(`${id}`);
        const option=document.createElement("option");
        option.value=tr.children[0].value;
        option.innerHTML=tr.children[1].innerHTML;
        option.selected=true;
        newselect.append(option);
        tr.remove();
    }
    let input=document.getElementById("input_add");
    let input_send=document.getElementById("input_send");
    let select=document.getElementById("tipo");
    let select_tamanho=document.getElementById("select_tamanho");
    let table=document.getElementById("sabores");
    let div=document.getElementById("add_selects");
    let tipo_val=select.options[select.selectedIndex].value;
    let trs=table.children[0].children;
    let newselect=document.createElement("select");
    newselect.id="sabor_select"
    for(tr of trs){
        sabor_codigo=tr.children[0].innerHTML;
        sabor_nome=tr.children[1].innerHTML;
        tipo_sabor=tr.children[2].innerHTML;
        if(tipo_sabor==tipo_val){
            option=document.createElement("option");
            option.value=sabor_codigo;
            option.innerHTML=sabor_nome;
            newselect.appendChild(option);   
        }
    }
    div.appendChild(newselect);
    select.onchange=()=>{
            table2=document.getElementById("table_sabores")
            while (table2.hasChildNodes()) {
                table2.removeChild(table2.lastChild);
            }
            document.getElementById("sabor_select").remove();
            newselect=document.createElement("select");
            newselect.id="sabor_select"
            tipo_val=select.options[select.selectedIndex].value;
            for(tr of trs){
            sabor_codigo=tr.children[0].innerHTML;
            sabor_nome=tr.children[1].innerHTML;
            tipo_sabor=tr.children[2].innerHTML;
            if(tipo_sabor==tipo_val){
                option=document.createElement("option");
                option.value=sabor_codigo;
                option.innerHTML=sabor_nome;
                newselect.appendChild(option);   
            }
            div.appendChild(newselect);
        }
    }
    select_tamanho.onchange=()=>{
        limit=select_tamanho.options[select_tamanho.selectedIndex].value.split(",")[1];
        let table=document.getElementById("table_sabores");
        if(table.children.length>limit){
            while (table.hasChildNodes()) {
                remove_flist(table.lastChild.id);
            }
        } 
    }
    input.addEventListener("click",()=>{
        limit=select_tamanho.options[select_tamanho.selectedIndex].value.split(",")[1];
        let table=document.getElementById("table_sabores");
        if(newselect.options.length>0&&table.children.length<limit){
        table.children.length==0 ? last_index=0:last_index=table.children.length;
        const tr=document.createElement("tr");
        let input=document.createElement("input");
            input.name=`input_sabor${last_index}`;
            input.type="hidden";
            input.value=newselect.options[newselect.selectedIndex].value;
            tr.append(input);
        const td=document.createElement("td");
            td.innerText=newselect.options[newselect.selectedIndex].innerText;
            tr.append(td);
        input=document.createElement("input");
            input.type="button";
            input.value="❌";
            input.addEventListener("click",()=>{remove_flist(tr.id)})
            tr.append(input);
        tr.id=`tr${last_index}`;
        newselect.options[newselect.selectedIndex].remove();
        table.append(tr);
        }
    });  
    input_send.addEventListener("click",()=>{
            let table=document.getElementById("table_sabores");
            if(table.children.length==0) alert("Adicione ao menos um sabor");
            else{
            document.getElementById("numero").disabled=false;
            document.getElementById("data").disabled=false;
            document.querySelector("form").submit();
            }
    })
</script>
</body>
</html>
