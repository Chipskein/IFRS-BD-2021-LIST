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
            echo "<form action=add_c.php method=POST>";
            echo "<label>";
            echo "Numero:<input class=input_d id=numero name=\"numero\" disabled type=text value=$numero>";
            echo "</label><br>";
            
            echo "<label>";
            $data=date("d/m/Y");
            echo "Data:<input  id=data name=\"data\" disabled type=text value=$data><br>";
            echo "</label>";
            
            echo "Mesa:<select name=mesa>";
                while( $row=$mesa_result->fetchArray()){
                    $codigo=$row["codigo"];
                    echo "<option value=\"$codigo\">".$row["nome"]."</option>";
                }
            echo "</select><br>";

            echo "<input type=button onclick=enviar() value=Inclui>";
            echo "</form>";       
        ?>
    </div>
    <script>
        function enviar(){
            document.getElementById("numero").disabled=false;
            document.getElementById("data").disabled=false;
            document.querySelector("form").submit();
        }
    </script>
</body>
</html>