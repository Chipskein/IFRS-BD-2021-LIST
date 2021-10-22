<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Sabor</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div align="center">
        <h1>Alterando...</h1>
    </div>
<?php
   if(isset($_POST["codigo"])&&isset($_POST["name_sabor"])&&isset($_POST["tipo"])){
        $codigo=$_POST["codigo"];
        $nome=$_POST["name_sabor"];
        $tipo=$_POST["tipo"];
        $ingredientes=[];
        foreach($_POST as $key => $value){
            if(preg_match("/input_ingrediente/",$key)) array_push($ingredientes,$value);
        };
        $db=new SQLite3('../pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $update_query=$db->query("update sabor set nome=\"$nome\",tipo=$tipo where codigo=$codigo");
        $query_ingredientes=$db->query("delete from saboringrediente where saboringrediente.sabor=$codigo");
        foreach($ingredientes as $index => $ingrediente){
            $db->query("insert into saboringrediente(sabor,ingrediente) values($codigo,$ingrediente)");
        };
        header( "refresh:1;url=sabor_index.php" );
        die();
        $db->close();
    }
   else{
        echo "DADOS INVÁLIDOS"; 
    }
?>
</body>
</html>




















