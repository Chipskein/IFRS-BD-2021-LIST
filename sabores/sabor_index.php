<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🍕</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <?php
        function url($campo, $valor) {
            $result = array();
            if (isset($_GET["sabor"])) $result["sabor"] = "sabor=".$_GET["sabor"];
            if (isset($_GET["tipo"])) $result["tipo"] = "tipo=".$_GET["tipo"];
            if (isset($_GET["ingrediente"])) $result["ingrediente"] = "ingrediente=".$_GET["ingrediente"];
            if (isset($_GET["orderby"])) $result["orderby"] = "orderby=".$_GET["orderby"];
            if (isset($_GET["offset"])) $result["offset"] = "offset=".$_GET["offset"];
            $result[$campo] = $campo."=".$valor;
            return("sabor_index.php?".strtr(implode("&", $result), " ", "+"));
        }
        $db=new SQLite3('../pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $where=array();
        if (isset($_GET["sabor"])) $where[] = "where sabor.nome like '%".strtr($_GET["sabor"], " ", "%")."%'";
        if (isset($_GET["tipo"])) $where[] = "where tipo.nome like '%".strtr($_GET["tipo"], " ", "%")."%'";
        if (isset($_GET["ingrediente"])) $where[] = "where ingrediente.nome like '%".strtr($_GET["ingrediente"], " ", "%")."%'";
        $where = (count($where) > 0) ? $where[0] : "";
        $value="";
        if (isset($_GET["sabor"])) $value = $where;
        if (isset($_GET["tipo"])) $value = "join tipo on sabor.tipo=tipo.codigo $where";
        if (isset($_GET["ingrediente"])) $value = "join saboringrediente on sabor.codigo=saboringrediente.sabor join ingrediente on ingrediente.codigo=saboringrediente.ingrediente $where";;

        $result=$db->query("select count(*) as total from sabor $value");
        $total=$result->fetchArray()['total'];
        $limit=10;
        $offset = (isset($_GET["offset"])) ? max(0, min($_GET["offset"], $total-1)) : 0;
        $offset = $offset-($offset%$limit);
        $orderby = (isset($_GET["orderby"])) ? $_GET["orderby"] : "tipo asc";
        
        
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
            $where
            group by sabor.codigo 
            order by $orderby
            limit $limit
            offset $offset
        ");

        echo "<br><div align='center'>";
            echo "<h2>Pizzaria</h2>";
            echo "<div id='div_table'>";             
                echo "<div id='div_select'>";
                    echo "<select>";
                        echo "<option value=sabor >Nome</option>";
                        echo "<option value=tipo >Tipo</option>";
                        echo "<option value=ingrediente >Ingrediente</option>";
                    echo "</select>";
                    echo "<input id=filter_txt name='filter_txt' type='text' placeholder='Selecione o campo e pesquise'>  <a id=pesquisar onclick=pesquisar()>🔎</a>";
                echo "</div><br>";                      
                echo "<table>";
                    echo "<tr>\n";
                    echo "<td><a href=\"add.php\">➕</a></td>";
                    echo "<td><b>Sabor</b> <a href=\"".url("orderby", "sabor+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "sabor+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Tipo</b> <a href=\"".url("orderby", "tipo+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "tipo+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Ingredientes</b></td>\n";
                    echo "<td>🍕</td>";
                    echo "</tr>\n";
                    while ($row = $results->fetchArray()) {
                        echo "<tr>";
                            echo "<td><a href=\"edit.php?codigo_s={$row['codigo']}\">📝</a></td>";
                            echo "<td>".$row["sabor"]."</td>";
                            echo "<td>".$row["tipo"]."</td>";
                            echo "<td>".$row["ingredientes"]."</td>";
                            echo "<td><a href=\"delete.php?codigo_s={$row['codigo']}\" onclick=\"return(confirm('Excluir o Sabor ".$row["sabor"]."?'));\">❌</a></td>";
                        echo "</tr>";
                    }
                
                    echo "</table>";
                    $db->close();            
                    for ($page = 0; $page < ceil($total/$limit); $page++) {
                        echo (($offset == $page*$limit) ? ($page+1) : "<a href=\"".url("offset", $page*$limit)."\">".($page+1)."</a>")." \n";
                    }
            echo "</div>";
        echo "</div>";
    ?>
    <script>
        function pesquisar(){

            input_value=document.getElementById("filter_txt").value;
            if(input_value.trim()!=""){
                value=document.querySelector("select").options[document.querySelector("select").selectedIndex].value;
                document.getElementById("pesquisar").href=`sabor_index.php?${value}=${input_value}`;
            }
        }
    </script>
</body>
</html>