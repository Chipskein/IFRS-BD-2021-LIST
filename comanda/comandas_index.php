
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
    <?php
        function url($campo, $valor) {
            $result = array();
            //if (isset($_GET["sabor"])) $result["sabor"] = "sabor=".$_GET["sabor"];
            //if (isset($_GET["tipo"])) $result["tipo"] = "tipo=".$_GET["tipo"];
            if (isset($_GET["orderby"])) $result["orderby"] = "orderby=".$_GET["orderby"];
            if (isset($_GET["offset"])) $result["offset"] = "offset=".$_GET["offset"];
            $result[$campo] = $campo."=".$valor;
            return("comandas_index.php?".strtr(implode("&", $result), " ", "+"));
        }
        $db=new SQLite3('../pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $result=$db->query("select count(*) as total from comanda");
        $total=$result->fetchArray()['total'];
        
        $limit=500;
        $offset = (isset($_GET["offset"])) ? max(0, min($_GET["offset"], $total-1)) : 0;
        $offset = $offset-($offset%$limit);
        $orderby = (isset($_GET["orderby"])) ? $_GET["orderby"] : 'numero desc';

        $results=$db->query("
            select 
            comanda.numero as numero,
            comanda.data as data,
            mesa.nome as mesa,
            tmp.count as pizzas,
            tmp2.preco as preco,
            case 
                when comanda.pago=1 then \"SIM\"
                when comanda.pago=0 then \"NAO\"
            end as pago 
            from 
            comanda
            join mesa on mesa.codigo=comanda.mesa
            join (select 
                    comanda.numero as comanda,count(*) as count
                    from 
                    comanda 
                    join pizza on pizza.comanda=comanda.numero
                    group by comanda.numero
                ) as tmp on comanda.numero=tmp.comanda
            join (
                    select 
                        tmp.comanda as comanda,
                        sum(tmp.preco) as preco
                    from
                    (
                    select 
                        comanda.numero as comanda, 
                        pizza.codigo as pizza,
                        sum(case 
                            when borda.preco is null then 0
                            else borda.preco
                        end+precoportamanho.preco) as preco
                    from 
                        comanda 
                            join pizza on pizza.comanda=comanda.numero
                            join pizzasabor on pizza.codigo=pizzasabor.pizza
                            join sabor on pizzasabor.sabor=sabor.codigo
                            join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                            left join borda on pizza.borda=borda.codigo
                    group by pizza.codigo
                    ) as tmp
                    group by tmp.comanda 
                ) as tmp2 on comanda.numero=tmp2.comanda
                order by $orderby
                limit $limit
                offset $offset
        ");
        
        echo "<br><div align='center'>";
            echo "<h2>Pizzaria</h2>";
            echo "<div id='div_table'>";             
                echo "<div id='div_select'>";
                    echo "<select>";
                        echo "<option>Nome</option>";
                        echo "<option>Tipo</option>";
                        echo "<option>Ingrediente</option>";
                    echo "</select>   ";
                    echo "<input name='filter_txt' type='text' placeholder='Selecione o campo e pesquise'>  <a href=\"comandas_index.php\">🔎</a>";
                echo "</div><br>";                      
                echo "<table>";
                    echo "<tr>\n";
                    echo "<td><a href=\"add_comanda.php\">➕</a></td>";
                    echo "<td><b>Número</b> <a href=\"".url("orderby", "numero+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "numero+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Data</b> <a href=\"".url("orderby", "data+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "data+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Mesa</b> <a href=\"".url("orderby", "mesa+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "mesa+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Pizzas</b> <a href=\"".url("orderby", "pizzas+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "pizzas+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Valor</b> <a href=\"".url("orderby", "preco+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "preco+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Pago</b> <a href=\"".url("orderby", "pago+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "pago+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td>🍕</td>";
                    echo "</tr>\n";
                    while ($row = $results->fetchArray()) {
                        echo "<tr>";
                            $comanda=$row["numero"];
                            echo $row["pago"]=="NAO" ? "<td><a href=\"add_pizza.php?comanda=$comanda\">📝</a></td>":"<td></td>";
                            echo "<td>".$row["numero"]."</td>";
                            echo "<td>".$row["data"]."</td>";
                            echo "<td>".$row["mesa"]."</td>";
                            echo "<td>".$row["pizzas"]."<a href=\"list_pizzas.php?comanda=$comanda\">📖</a>"."</td>";
                            echo "<td>R$ ".$row["preco"]."</td>";
                            echo  $row["pago"]=="NAO" ? "<td>".$row["pago"]."<a href=\"\">💸</a><a href=\"\">💳</a></td>":"<td>".$row["pago"]."</td>";
                            echo  $row["pizzas"]==0 ?"<td><a href=\"\" onclick=\"return(confirm('Excluir a comanda ".$row["numero"]."?'));\">❌</a></td>":"<td></td>";
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
    
</body>
</html>
