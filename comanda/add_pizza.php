
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
                while($row=$comanda_result->fetchArray()){
                    $numero=$row["numero"];
                    $data=$row["data"];
                    echo "Numero: $numero<br>";
                    echo "data: $data<br>";
                }
                $tamanho=$db->query("select codigo,nome from tamanho");
                echo "Tamanho:<select>";
                while($row=$tamanho->fetchArray()){
                    $nome=$row["nome"];
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">$nome</option>";
                }
                echo "</select><br>";
                $tipo=$db->query("select codigo,nome from tipo");
                echo "Sabores:<select>";
                while($row=$tipo->fetchArray()){
                    $nome=$row["nome"];
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">$nome</option>";
                }
                echo "</select><input id=input_add type=button value='➕'>";
                echo "<br>";
                echo "<table></table>";
                echo "<input id=input_add type=button value='Incluir'>";
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
