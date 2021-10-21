<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Sabor</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<?php
   if(isset($_POST["codigo"])&&isset($_POST["name_sabor"])&&isset($_POST["tipo"])){
        $codigo=$_POST["codigo"];
        $nome=$_POST["name_sabor"];
        $tipo=$_POST["tipo"];
        $ingredientes=[];
        foreach($_POST as $key => $value){
            if(preg_match("/input_ingrediente/",$key)) array_push($ingredientes,$value);
        };
        //update sabor set nome=$nome,tipo=$tipo where codigo=$codigo;
        $db=new SQLite3('pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $update_query=$db->query("update sabor set nome=\"$nome\",tipo=$tipo where codigo=$codigo");
        echo "Nome e Tipo alterados<br>";
        $query_ingredientes=$db->query("select ingrediente from saboringrediente where saboringrediente.sabor=$codigo");
        $ingredientes=[];
        while ($row = $query_ingredientes->fetchArray()) {
            array_push($ingredientes,$row["ingrediente"]);
        }
        //header( "refresh:1;url=index.php" );
        //die();
        $db->close();
    }
   else{
        echo "DADOS INVÁLIDOS"; 
    }
?>
</body>
</html>




















