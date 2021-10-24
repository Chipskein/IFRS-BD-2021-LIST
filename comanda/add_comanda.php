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
        <h2>Inclusão de Comanda</h2>
        <?php
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $numero=$db->query("select max(numero) as last_row from comanda")->fetchArray()["last_row"]+1;
            $mesa_result=$db->query("select * from mesa");
            echo "Numero:$numero<br>";
            $data=date("d/m/Y");
            echo "Data:$data<br>";
            echo "Mesa:<select>";
                while( $row=$mesa_result->fetchArray()){
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">".$row["nome"]."</option>";
                }
            echo "</select><br>";
            echo "<button>Inclui</button>"        

        ?>
    </div>
</body>
</html>