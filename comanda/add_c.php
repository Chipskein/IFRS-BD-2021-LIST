<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Comanda</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div align="center">
        <?php
            if(isset($_POST["numero"])&&isset($_POST["mesa"])){
                //verica se a mesa existe verifica se o numero esta disponivel
                if(preg_match("/^[1-9][0-9]*$/",$_POST["numero"])&&preg_match("/[A-Z-0-9]/",$_POST["mesa"])){
                    $mesa=$_POST["mesa"];
                    $numero=$_POST["numero"];
                    $db=new SQLite3('../pizza.db');
                    $db->exec("PRAGMA foreign_keys = ON");
                    $verify_mesa=$db->query("select codigo from mesa where codigo=$mesa")->fetchArray();
                    $verify_numero=$db->query("select numero,pago from comanda where numero=$numero")->fetchArray();
                    if($verify_mesa&&$verify_numero){
                        if($verify_numero['pago']==0){
                            $db->query("update comanda set mesa=$mesa where numero=$numero");
                            $db->close();
                            echo "<h1>Comanda adicionada</h1>";
                            header( "refresh:1;url=comandas_index.php" );
                        }
                        else{
                            $db->close();
                            echo "<h1>Comanda Paga</h1>";
                            echo "<h2>Retornando...</h2>";
                            header( "refresh:1;url=add_comanda.php" );
                            die();
                        }
                    }
                    else{
                        $db->close();
                        echo "<h1>Um erro ocorreu tente novamente</h1>";
                        echo "<h2>Retornando...</h2>";
                        header( "refresh:1;url=add_comanda.php" );
                        die();
                    }
                }
                else{
                    echo "<h1>Dados Inválidos</h1>";
                    echo "<h2>Retornando...</h2>";
                    header( "refresh:1;url=comandas_index.php" );
                    die();
                }
            }
            else{
                echo "<h1>Dados Inválidos</h1>";
                echo "<h2>Retornando...</h2>";
                header( "refresh:1;url=comandas_index.php" );
                die();
            }
        ?>
    </div>
</body>
</html>