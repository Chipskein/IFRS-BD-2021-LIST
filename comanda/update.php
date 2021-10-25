
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
        <h1>Alterando...</h1>
    </div>
    <?php
        if(isset($_GET["comanda"])){
            $comanda=$_GET["comanda"];
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $comanda_result=$db->query("select numero from comanda where numero=$comanda")->fetchArray()['numero'];
            $update=$db->query("update comanda set pago=\"1\" where numero=$comanda_result");
            header( "refresh:1;url=comandas_index.php" );
            die();
            $db->close();
        }
        else{
            echo "<h2>Erro</h2>";
            echo "<h2>Dados não foram enviados</h2>";
        }
    ?>
    </div>
    
</body>
</html>
