<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Sabor</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<?php
    echo "<main align='center'>";
        echo "<h2>Pizzaria</h2>";
        if(isset($_GET['codigo_s'])){
            $sabor=$_GET['codigo_s'];
            $db=new SQLite3('pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $types=$db->query("select * from tipo");
            $ingredientes=$db->query("select * from ingrediente");
            $results=$db->query("
                select 
                    sabor.codigo as codigo,
                    sabor.nome as sabor,
                    tipo.nome as tipo,
                    group_concat(ingrediente.nome,',') as ingredientes
                from 
                    sabor
                    join saboringrediente on sabor.codigo=saboringrediente.sabor
                    join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
                    join tipo on sabor.tipo=tipo.codigo
                where sabor.codigo=$sabor")->fetchArray();

            if($results['codigo']&&$results['sabor']&&$results['tipo']&&$results['ingredientes']){
                $name_sabor=$results["sabor"];
                $tipo_name=$results['tipo'];
                $sabor_codigo=$results['codigo'];
                $ingredientes_sabor=explode(',',$results['ingredientes']);
                echo "<form method=POST action=update.php>";
                echo "<input name=codigo type='hidden' value=\"$sabor_codigo\">";
                echo "<label>Nome do Sabor<br>";               
                    echo "<input name=\"name_sabor\" type='text'"."value=\"$name_sabor\"".">";
                echo "</label>"; 
                echo "<br>";           
                echo "Tipo<br>";
                    echo "<select name=tipo>";
                        while($row=$types->fetchArray()){
                            $nome=$row['nome'];
                            $codigo=$row['codigo'];
                            if(strtolower($nome)==strtolower($tipo_name)) echo "<option "."value=\"$codigo\""." selected=\"selected\">".$row['nome']."</option><br>";
                            else echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
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
                    foreach($ingredientes_sabor as $val){
                        echo "<tr>";
                            echo "<input type='hidden' value=\"\">";
                            echo "<td>$val</td>";
                            echo "<td><input type='button' value=\"❌\"></td>";
                        echo "</tr>";
                    }
                    echo "</table>";
                echo "<div>";
                echo "<br><input id=\"send\" type='button' value=\"Alterar\" >";
                echo "</form>";
            }
            else{
                echo "Codigo inválido...Retornando";
                header( "refresh:1;url=index.php" );
                die();
            }
            $db->close();
        }
        else{
            echo "Erro Retornando";
            header( "refresh:1;url=index.php" );
            die();
        }
    echo "</main>";
?>
<script>
    function remove_flist(id){
        const tr=document.getElementById(`${id}`);
        tr.remove();
    }
    const main=document.querySelector("main");
    const table=document.querySelector("tbody").children;
    const table2=document.querySelector("tbody");
    const input_add=document.querySelector("#add");
    const select_add=document.querySelector("#select_add");
    const send=document.querySelector("#send");
    for(c=0;c<table.length;c++){
        const tr=table[c];
        //add values to input hidden
        const input=tr.children[0];
            input.name=`input_ingrediente${c}`;
        const txt=tr.children[1].innerHTML;
        for(c1=0;c1<select_add.children.length;c1++){
            if(select_add.children[c1].innerHTML===txt) input.value=select_add.children[c1].value;
        }
        //addevento remove inputs
        const td=tr.children[2];
        const input2=td.children[0];
        tr.id=`tr${c}`;
        input2.addEventListener("click",()=>{remove_flist(tr.id)})
    }
    input_add.addEventListener("click",()=>{
        let vals=[]
        for(c=0;c<table.length;c++){
            const tr=table[c];
            const td=tr.children[1].innerHTML;
            vals.push(td);
        }
        table.length==0 ? last_index=0:last_index=parseInt(table[table.length-1].id.substr(2))+1;
        const tr=document.createElement("tr");
        tr.id=`tr${last_index}`;
        let input=document.createElement("input");
            input.type='hidden';
            input.value=select_add.options[select_add.selectedIndex].value;
            input.name=`input_ingrediente${last_index}`;
        tr.appendChild(input);
        let td=document.createElement("td");
        td.innerHTML=select_add.options[select_add.selectedIndex].innerHTML;
        tr.appendChild(td);
        td=document.createElement("td");
        input=document.createElement("input");
            input.type='button';
            input.value="❌";
            input.addEventListener("click",()=>{remove_flist(tr.id)})
        td.appendChild(input);
        tr.appendChild(td);
        if(vals.indexOf(select_add.options[select_add.selectedIndex].innerHTML)==-1){
            table2.appendChild(tr);
        }
    });
    send.addEventListener("click",()=>{
        table.length==0 ? alert("Adicione ao menos um ingrediente"):document.querySelector("form").submit();
    });
</script>   
</body>
</html>
