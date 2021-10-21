<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Sabor</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div align="center">
        <h1>Adicionando...</h1>
    </div>
<?php
    if(isset($_POST["name_sabor"])&&isset($_POST["tipo"])){
        $nome=$_POST["name_sabor"];
        $tipo=$_POST["tipo"];
        $ingredientes=[];
        foreach($_POST as $key => $value){
            if(preg_match("/input_ingrediente/",$key)) array_push($ingredientes,$value);
        };
        $db=new SQLite3('pizza.db');
        $db->exec("PRAGMA foreign_keys = ON");
        $codigo=$db->query("insert into sabor(nome,tipo) values(\"$nome\",$tipo) returning codigo")->fetchArray()["codigo"];
        foreach($ingredientes as $index=>$value){
            $db->query("insert into saboringrediente(sabor,ingrediente) values($codigo,$value)");
        };
        $db->close();
        header( "refresh:1;url=sabor_index.php" );
        die();
    }
   else{
        echo "DADOS INVÁLIDOS"; 
    }
?>
</body>
</html>
