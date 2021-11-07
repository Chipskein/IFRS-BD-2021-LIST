
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
            if (isset($_GET["numero"])) $result["numero"] = "numero=".$_GET["numero"];
            if (isset($_GET["data"])) $result["data"] = "data=".$_GET["data"];
            if (isset($_GET["mesa"])) $result["mesa"] = "mesa=".$_GET["mesa"];
            if (isset($_GET["pizzas"])) $result["pizzas"] = "pizzas=".$_GET["pizzas"];
            if (isset($_GET["preco"])) $result["preco"] = "preco=".$_GET["preco"];
            if (isset($_GET["pago"])) $result["pago"] = "pago=".$_GET["pago"];
            if (isset($_GET["orderby"])) $result["orderby"] = "orderby=".$_GET["orderby"];
            if (isset($_GET["offset"])) $result["offset"] = "offset=".$_GET["offset"];
            $result[$campo] = $campo."=".$valor;
            return("comandas_index.php?".strtr(implode("&", $result), " ", "+"));
        }
        function pages($campo, $valor){
            $result = array();
            if (isset($_GET["page"])) $result["page"] = "page=".$_GET["page"];
            $result[$campo] = $campo."=".$valor;
            return '&'.(strtr(implode("&",$result), " ", "+"));
        }
        $db=new SQLite3('../pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $where=array();
        $value="";
        if (isset($_GET["numero"])) $where[] = "where numero =".trim($_GET["numero"]);
        if (isset($_GET["data"])) $where[] = "where strftime('%d-%m-%Y',comanda.data)="."'".trim($_GET["data"])."'";
        if (isset($_GET["mesa"])) $where[] = "where mesa.nome like '%".strtolower($_GET["mesa"])."%'";
        if (isset($_GET["pizzas"])) $where[] = "where pizzas like '%".strtr($_GET["pizzas"], " ", "%")."%'";
        if (isset($_GET["preco"])) $where[] = "where preco=".trim($_GET["preco"]);

        if (isset($_GET["pago"])){if(strtolower($_GET["pago"]) == 'sim') $where[] = "where pago = 1";}
        if (isset($_GET["pago"])){if(strtr($_GET["pago"], " ", "%") == 'NÃO' || strtr($_GET["pago"], " ", "%") == 'não'|| strtr($_GET["pago"], " ", "%") == 'Não'|| strtolower($_GET["pago"]) == 'nao') $where[] = "where pago = 0";} 
        $where = (count($where) > 0) ? $where[0] : "";
        if(isset($_GET["numero"])||isset($_GET["data"])||isset($_GET["pago"])) $value=$where;
        else{
            if(isset($_GET["mesa"])) $value="join mesa on mesa.codigo=comanda.mesa where mesa.nome like '%".strtolower($_GET["mesa"])."%'";
            if(isset($_GET["pizzas"])) $value="join 
                (
                    select 
                    comanda.numero as comanda,
                    case 
                        when tmp2.qt_pizza is null then 0 
                        when tmp2.qt_pizza is not null then tmp2.qt_pizza 
                    end as qt_pizza
                    from comanda left join (select comanda,count(*) as qt_pizza from pizza group by comanda) as tmp2 on tmp2.comanda=comanda.numero
                ) as tmp3 on tmp3.comanda=comanda.numero
                where tmp3.qt_pizza=$_GET[pizzas]
                ";
            if(isset($_GET["preco"])) $value="
                join (
                select 
                comanda.numero as comanda,
                case 
                    when tmp2.preco is null then 0
                    when tmp2.preco is not null then tmp2.preco
                end as preco 
                from comanda
                left join
                (
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
                            when borda.preco is not null then borda.preco
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
                ) as tmp3 on comanda.numero=tmp3.comanda
                where tmp3.preco=$_GET[preco]
                ";
        }
        $result=$db->query("select count(*) as total from comanda $value");
        $total=$result->fetchArray()['total'];
        $limit=200;
        $offset = (isset($_GET["offset"])) ? max(0, min($_GET["offset"], $total-1)) : 0;
        $offset = $offset-($offset%$limit);
        $orderby = (isset($_GET["orderby"])) ? $_GET["orderby"] : 'numero desc';
        $results=$db->query("
                select 
                comanda.numero as numero,
                case 
                    when strftime(\"%w\",comanda.data)='0' then strftime(\"Dom %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='1' then strftime(\"Seg %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='2' then strftime(\"Ter %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='3' then strftime(\"Qua %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='4' then strftime(\"Qui %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='5' then strftime(\"Sex %d-%m-%Y\",comanda.data)
                    when strftime(\"%w\",comanda.data)='6' then strftime(\"Sáb %d-%m-%Y\",comanda.data)
                end as data,
                mesa.nome as mesa,
                case
                    when tmp.count is null then 0
                    else tmp.count 
                end as pizzas,
                tmp3.preco as preco,
                case 
                    when comanda.pago=1 then \"SIM\"
                    when comanda.pago=0 then \"NAO\"
                end as pago 
                from 
                comanda
                join mesa on mesa.codigo=comanda.mesa
                left join (select 
                        comanda.numero as comanda,count(*) as count
                        from 
                        comanda 
                        join pizza on pizza.comanda=comanda.numero
                        group by comanda.numero
                    ) as tmp on comanda.numero=tmp.comanda
                    join (
                        select 
                        comanda.numero as comanda,
                        case 
                            when tmp2.preco is null then 0
                            when tmp2.preco is not null then tmp2.preco
                        end as preco 
                        from comanda
                        left join
                        (
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
                                    when borda.preco is not null then borda.preco
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
                        ) as tmp3 on comanda.numero=tmp3.comanda
                $where
                order by $orderby
                limit $limit
                offset $offset
        ");
        echo "<br><div align='center'>";
            echo "<h2>Pizzaria</h2>";
            echo "<div id='div_table'>";             
                echo "<div id='div_select'>";
                    echo "<select>";
                        echo "<option value=numero>Numero</option>";
                        echo "<option value=data>Data</option>";
                        echo "<option value=mesa>Mesa</option>";
                        echo "<option value=pizzas>Pizzas</option>";
                        echo "<option value=preco>Valor</option>";
                        echo "<option value=pago>Pago</option>";
                    echo "</select>   ";
                    echo "<input id=filter_txt name='filter_txt' type='text' placeholder='Selecione o campo e pesquise'>  <a id=pesquisar onclick=pesquisar()>🔎</a>";
                echo "</div><br>";                      
                echo "<table>";
                    echo "<tr>\n";
                    echo "<td><a href=\"add_comanda.php\">➕</a></td>";
                    echo "<td><b>Número</b> <a href=\"".url("orderby", "numero+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "numero+desc")."\">&#x25B4;</a></td>\n";
                    echo "<td><b>Data</b> <a href=\"".url("orderby", "comanda.data+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "comanda.data+desc")."\">&#x25B4;</a></td>\n";
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
                            echo $row["pizzas"]!= 0 ? "<td>".$row["pizzas"]."<a href=\"list_pizzas.php?comanda=$comanda\">📖</a>"."</td>":"<td>$row[pizzas]</td>";
                            echo "<td>R$ ".$row["preco"]."</td>";
                            echo  $row["pago"] == "NAO" && $row["pizzas"] != 0 ? "<td>".$row["pago"]."<a href=\"update.php?comanda=$comanda\">💸</a><a href=\"update.php?comanda=$comanda\">💳</a></td>":"<td>".$row["pago"]."</td>";
                            echo  $row["pizzas"]== 0 ?"<td><a href=delete_comanda.php?comanda=$comanda onclick=\"return(confirm('Excluir a comanda ".$row["numero"]."?'));\">❌</a></td>":"<td></td>";
                        echo "</tr>";
                    }
                
                    echo "</table>";
                    
                    $page = isset($_GET["page"]) ? strtr($_GET["page"], " ", "%") : 0;
                    $links = 4;
                    echo "<a href=\"".url("offset",0*$limit).pages("page", 0)."\">primeira </a>";
                    for($pag_inf = $page - $links ;$pag_inf <= $page - 1;$pag_inf++){
                        if($pag_inf >= 1 ){
                            echo "<a href=\"".url("offset",($pag_inf-1)*$limit).pages("page", $pag_inf)."\"> ".($pag_inf)." </a>";
                        }
                    };
                    if($page != 0 ){
                        echo "<a style=color:yellow;>$page</a>";
                    };
                    for($pag_sub = $page + 1;$pag_sub <= $page + $links;$pag_sub++){
                        if($pag_sub <= ceil($total/$limit)){
                            echo "<a href=\"".url("offset",($pag_sub-1)*$limit).pages("page", $pag_sub)."\"> ".($pag_sub)." </a>";
                        }
                    }
                    echo "<a href=\"".url("offset",ceil($total/$limit)*$limit).pages("page", ceil($total/$limit))."\"> ultima</a>";
            echo "</div>";
        echo "</div>";
    ?>
    <script>
        function verifydate(day,month,year){
            let day_qt //31,30,29,28
            let bissexto = false;
            if ((year % 4 == 0 && year % 100 !== 0) || (year % 400 == 0)) bissexto = true;//
            switch (month) {
            case 1:
                day_qt = 31
                break
            case 2:
                if (bissexto) day_qt = 29
                else day_qt = 28
                break
            case 3:
                day_qt = 31
                break
            case 4:
                day_qt = 30
                break
            case 5:
                day_qt = 31
                break
            case 6:
                day_qt = 30
                break
            case 7:
                day_qt = 31
                break
            case 8:
                day_qt = 31
                break
            case 9:
                day_qt = 30
                break
            case 10:
                day_qt = 31
                break
            case 11:
                day_qt = 30
                break
            case 12:
                day_qt = 31
                break
            }
            if (day <= day_qt) return true
            else return false
        }
        function erro(){
            let input=document.getElementById("filter_txt");
            input.value='';
            input.focus();
        }
        function verificar(){
            let type=document.querySelector("#div_select>select").value
            let input=document.getElementById("filter_txt");
            let val=document.getElementById("filter_txt").value;
            let passed=false;
            let regex="";
            switch(type){
                case "numero":
                    regex=new RegExp("^[1-9][0-9]*$");
                    regex.test(val) ? passed=true:erro()
                    break;
                case "data":   
                    val2=input.value.split("/").join("-");            
                    regex=new RegExp("^(0[1-9]|1[0-9]|2[0-9]|3[0-1])\-(0[1-9]|1[0-2])\-[0-9]*$");
                    if(regex.test(val2)){ 
                        document.getElementById("filter_txt").value=val2;
                        let day=parseInt(input.value.slice(0,2));
                        let mounth=parseInt(input.value.slice(3,5));
                        let year=parseInt(input.value.slice(6)); 
                        passed=verifydate(day,mounth,year);
                    }
                    else erro()

                    break;
                case "mesa":
                    val2=document.getElementById("filter_txt").value
                    val2=val2.trim()
                    val2=val2.toUpperCase();
                    regex=new RegExp("[A-Z-0-9]");
                    regex.test(val2)&&val2!='' ? passed=true:erro()
                    break;
                case "pizzas":
                    regex=new RegExp("^(^0$)|[1-9][0-9]*$");
                    regex.test(val) ? passed=true:erro()
                    break;
                case "preco":
                    val2=val;
                    val2.split(",").join(".");
                    document.getElementById("filter_txt").value=val2;
                    regex=new RegExp("(^0$)|(^[1-9][0-9]*.[0-9]{1})$|^[1-9]*$");
                    regex.test(val2) ? passed=true:erro()
                    break;
                case "pago":
                    val2=document.getElementById("filter_txt").value
                    val2=val2.trim()
                    val2=val2.toUpperCase();
                    regex=new RegExp("^SIM$|^NAO$");
                    regex.test(val2) ? passed=true:erro()
                    break;
            }
            return passed;
        };
        function pesquisar(){
            
            if(verificar()){
                input_value=document.getElementById("filter_txt").value;
                value=document.querySelector("select").options[document.querySelector("select").selectedIndex].value;
                document.getElementById("pesquisar").href=`comandas_index.php?${value}=${input_value}`;
            }
        }
    </script>
</body>
</html>
