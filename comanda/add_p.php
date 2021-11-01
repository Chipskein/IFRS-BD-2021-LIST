<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style.css">
    <title>add pizza</title>
</head>
<body>    
<?php
    echo "<div align=center>";
    if(isset($_POST["numero"])&&isset($_POST["data"])&&isset($_POST["borda"])&&isset($_POST["tipo"])&&isset($_POST["tamanho"])){
        $numero=$_POST["numero"];
        $data=$_POST["data"];
        $borda=$_POST["borda"];
        $tipo=$_POST["tipo"];
        $tamanho=$_POST["tamanho"];
        $sabores=[];
        foreach($_POST as $key => $value){
            if(preg_match("/input_sabor/",$key)) array_push($sabores,$value);
        };
    }
    else{
        echo "<h1>Dados inválidos</h1>";
        echo "<h2>Retornando</h2>";
        header( "refresh:1;url=comandas_index.php" );
        die();
    }
    echo "</div>";
?>
</body>
</html>