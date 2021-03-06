<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Sabor</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<?php
    echo "<main align='center'>";
        echo "<h2>Pizzaria</h2>";
        if(isset($_GET['codigo_s'])){
            if(preg_match("/^[1-9][0-9]*$/",$_GET["codigo_s"])){
                $sabor=$_GET['codigo_s'];
                $db=new SQLite3('../pizza.db');
                $db->exec("PRAGMA foreign_keys = ON");
                $types=$db->query("select * from tipo");
                $ingredientes=$db->query("select * from ingrediente");
                $sabor_nome=$db->query("select nome from sabor where codigo=$sabor")->fetchArray()['nome'];
                $sabores_name=$db->query("select group_concat(sabor.nome,\",\") as sabores from sabor")->fetchArray();
                echo "<script>";
                echo "let sabor_nome=\"$sabor_nome\";";
                echo "let sabores=\"$sabores_name[0]\".split(\",\");";
                echo "</script>";
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
                    echo "<form method=POST action=update.php id=form>";
                    echo "<input name=codigo type='hidden' value=\"$sabor_codigo\">";
                    echo "<label>Nome do Sabor<br>";               
                        echo "<input id=name_sabor name=\"name_sabor\" type='text'"."value=\"$name_sabor\"".">";
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
                            echo "<option hidden selected value=null>Selecione um ingrediente </option>";
                            while($row=$ingredientes->fetchArray()){
                                $nome=$row['nome'];
                                $codigo=$row['codigo'];
                                if(!in_array($nome,$ingredientes_sabor)) echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
                                else echo "<option hidden "."value=\"$codigo\"".">".$row['nome']."</option><br>";
                            }
                        echo "</select><input id=\"add\" type='button' value=\"???\"><br>";
                    echo "Ingredientes:";
                    echo "<div align='center'>";
                        echo "<table>";
                        foreach($ingredientes_sabor as $val){
                            echo "<tr>";
                                echo "<input type='hidden' value=\"\">";
                                echo "<td>$val</td>";
                                echo "<td><input type='button' value=\"???\"></td>";
                            echo "</tr>";
                        }
                        echo "</table>";
                    echo "<div>";
                    echo "<br><input id=\"send\" type='button' value=\"Alterar\" >";
                    echo "</form>";
                }
                else{
                    echo "Codigo inv??lido...Retornando";
                    header( "refresh:1;url=sabor_index.php" );
                    die();
                }
                $db->close();
            }
            else{
                echo "Codigo inv??lido...Retornando";
                header( "refresh:1;url=sabor_index.php" );
                die();
            }
            
        }
        else{
            echo "Erro Retornando";
            header( "refresh:1;url=sabor_index.php" );
            die();
        }
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
            if(!accents&&((sabores.includes(input.value)&&input.value==sabor_nome)||(!sabores.includes(input.value)&&input.value!=sabor_nome))){
                    console.log("V??lido")
                    document.querySelector("form").submit();
            }
            else{
                console.log("erro1");
                input.value = sabor_nome;
                input.focus();
            }
        }
        else{
            console.log("erro2");
            input.value = sabor_nome;
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
    const main=document.querySelector("main");
    const table=document.querySelector("tbody").children;
    const table2=document.querySelector("tbody");
    const input_add=document.querySelector("#add");
    const select_add=document.querySelector("#select_add");
    const send=document.querySelector("#send");
    const form=document.getElementById("form");
    form.addEventListener("keydown",(event)=>{
        if(event.keyCode == 13) {
        event.preventDefault();
        return false;
    }})
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
        /*
        let vals=[]
        for(c=0;c<table.length;c++){
            const tr=table[c];
            const td=tr.children[1].innerHTML;
            vals.push(td);
        }
        */
       if(select_add.options[select_add.selectedIndex].value!=="null"){
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
            input.value="???";
            input.addEventListener("click",()=>{remove_flist(tr.id)})
        td.appendChild(input);
        tr.appendChild(td);
        select_add.options[select_add.selectedIndex].remove();
        table2.appendChild(tr);
        }
    });
    send.addEventListener("click",()=>{
        table.length==0 ? alert("Adicione ao menos um ingrediente"):verificar();
    });
</script>   
</body>
</html>
