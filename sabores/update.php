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
        $pass=false;
        $ingredientes=[];
        if(preg_match("/^[1-9][0-9]*$/",$_POST["codigo"])){
            if(preg_match("/^[A-Z ]*$/",trim($_POST["name_sabor"]))){
                if(preg_match("/^[1-9][0-9]*$/",$_POST["tipo"])){
                    foreach($_POST as $key => $value){
                        if(preg_match("/input_ingrediente/",$key)){
                            if(preg_match("/^[1-9][0-9]*$/",$value)){
                                $pass=true;
                                if(!in_array($value,$ingredientes)) array_push($ingredientes,$value);
                                else {
                                    $pass=false;
                                    break;
                                }
                            }
                            else {
                                $pass=false;
                                break;
                            } 
                        };
                    };

                }
            }
        }
        else $pass=false;
        if($pass){
            $codigo=$_POST["codigo"];
            $nome=trim($_POST["name_sabor"]);
            $tipo=$_POST["tipo"];           
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $pass2=false;
            $codigo_exist=$db->query("select codigo from sabor where codigo=$codigo")->fetchArray()['codigo'];
            if($codigo_exist){
                $name_before=$db->query("select nome from sabor where codigo=$codigo")->fetchArray()['nome'];
                $sabores_name=$db->query("select group_concat(sabor.nome,\",\") as sabores from sabor")->fetchArray()['sabores'];
                $sabores_name=explode(",",$sabores_name);
                $tipos_codigo=$db->query("select group_concat(tipo.codigo,\",\") as tipos from tipo")->fetchArray()['tipos'];
                $tipos_codigo=explode(",",$tipos_codigo);
                $ingredientes_codigo=$db->query("select group_concat(ingrediente.codigo,\",\") as ingrediente from ingrediente")->fetchArray()['ingrediente'];
                $ingredientes_codigo=explode(",",$ingredientes_codigo);
                if(!in_array($nome,$sabores_name)||$nome==$name_before){
                    if(in_array($tipo,$tipos_codigo)){
                        foreach($ingredientes as $key=>$value){
                            if(in_array($value,$ingredientes_codigo))$pass2=true;
                            else {
                                $pass2=false;
                                break;
                            }
                        }
                    }
                }
                if($pass2){
                    $update_query=$db->query("update sabor set nome=\"$nome\",tipo=$tipo where codigo=$codigo");
                    $query_ingredientes=$db->query("delete from saboringrediente where saboringrediente.sabor=$codigo");
                    foreach($ingredientes as $index => $ingrediente){
                        $db->query("insert into saboringrediente(sabor,ingrediente) values($codigo,$ingrediente)");
                    };
                    header( "refresh:1;url=sabor_index.php" );
                    die();
                    $db->close();
                }
                else echo "DADOS INVÁLIDOS";
            }
            else echo "<h2>DADOS INVÁLIDOS</h2>"; 
        }
        else echo "<h2>DADOS INVÁLIDOS</h2>"; 
    }
   else echo "<h2>DADOS INVÁLIDOS</h2>"; 
    
?>
</body>
</html>




















