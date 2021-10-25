<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remover Comanda</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div align="center">
        <?php
            if(isset($_GET["comanda"])){
                $comanda=$_GET["comanda"];
                echo "<h2>Remover Comanda</h2>";
                $db=new SQLite3('../pizza.db');
                $db->exec("PRAGMA foreign_keys = ON");
                $verify=$db->query("select count(*) as qt from pizza where comanda=$comanda")->fetchArray()["qt"];
                if($verify==0){

                    $result=$db->query("delete from comanda where numero=$comanda");
                    if($result) echo "<h2>Comanda Removida</h2>";
                    else echo "<h2>Um erro ocorreu</h2>";
                    $db->close();
                    echo "<h2>Retornando...</h2>";
                    header( "refresh:1;url=comandas_index.php" );
                    die();
                }
                else{
                    //possui mais de uma pizza portanto não pode ser apagada
                    $db->close();
                    echo "<h2>Comanda $comanda não pode ser apagada</h2>";
                    echo "<h3>Retornando...</h3>";
                    header( "refresh:1;url=comandas_index.php" );
                    die();
                }
            }
            else{
                echo "<h2>Comanda não enviada</h2>";
                echo "<h2>Retornando...</h2>";
                header( "refresh:1;url=comandas_index.php" );
                die();
            }
        ?>
    </div>
</body>
</html>