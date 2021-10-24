
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
        function url($numero,$campo, $valor) {
            $result = array();
            if (isset($_GET["orderby"])) $result["orderby"] = "orderby=".$_GET["orderby"];
            $result[$campo] = $campo."=".$valor;
            return("list_pizzas.php?comanda=$numero&".strtr(implode("&", $result), " ", "+"));
        }
        if(isset($_GET["comanda"])){
            $comanda=$_GET["comanda"];
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $result=$db->query("select numero from comanda");
            $orderby = (isset($_GET["orderby"])) ? $_GET["orderby"] : 'pizza asc';
            $comandas=[];
            while ($row=$result->fetchArray()){
                array_push($comandas,$row["numero"]);
            }
            if(in_array($comanda,$comandas)){
                echo "<h2>Pizzas da Comanda:$comanda</h2>";
                $results=$db->query("
                    select 
                        pizza.comanda as comanda,
                        pizza.codigo as pizza,
                        tamanho.nome as tamanho,
                        case
                            when borda.codigo is null then 'S/BORDA' 
                            when borda.codigo is not null then borda.nome  
                        end as borda,
                        group_concat(sabor.nome,\",\") as sabor,
                        preco.preco as preco
                    from 
                        pizza
                        join tamanho on tamanho.codigo=pizza.tamanho
                        left join borda on pizza.borda=borda.codigo 
                        join pizzasabor on pizza.codigo=pizzasabor.pizza
                        join sabor on sabor.codigo=pizzasabor.sabor
                        join (
                            select 
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
                            ) as preco on preco.pizza=pizza.codigo
                        where pizza.comanda=$comanda
                        group by pizza.codigo       
                        order by $orderby         
                ");
                echo "<table>";
                echo "<tr>";
                echo "<td><b>Tamanho</b> <a href=\"".url($comanda,"orderby", "tamanho+asc")."\">&#x25BE;</a> <a href=\"".url($comanda,"orderby", "tamanho+desc")."\">&#x25B4;</a></td>";
                echo "<td><b>Borda</b> <a href=\"".url($comanda,"orderby", "borda+asc")."\">&#x25BE;</a> <a href=\"".url($comanda,"orderby", "borda+desc")."\">&#x25B4;</a></td>";
                echo "<td><b>Sabores</b> <a href=\"".url($comanda,"orderby", "sabor+asc")."\">&#x25BE;</a> <a href=\"".url($comanda,"orderby", "sabor+desc")."\">&#x25B4;</a></td>";
                echo "<td><b>Preço</b> <a href=\"".url($comanda,"orderby", "preco+asc")."\">&#x25BE;</a> <a href=\"".url($comanda,"orderby", "preco+desc")."\">&#x25B4;</a></td>";
                echo "</tr>";
                while($row=$results->fetchArray()){
                    echo "<tr>";
                    echo "<td>$row[tamanho]</td>";
                    echo "<td>$row[borda]</td>";
                    echo "<td>$row[sabor]</td>";
                    echo "<td>R$$row[preco]</td>";
                    echo "</tr>";
                }
                $total=$db->query("
                    select 
                    sum(preco) as total
                    from
                    (
                        select 
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
                        where pizza.comanda=$comanda
                        group by pizza.codigo
                    )
                ")->fetchArray()["total"];
                echo "<tr>";
                echo "<td colspan=\"3\"><b>Total:</b></td>";
                echo "<td><b>R$$total</b></td>";
                echo "</tr>";
                echo "</table>";
                echo "<br>";
                echo "<div class=button><a href=\"comandas_index.php\">Voltar</a><div>";
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
    
</body>
</html>
