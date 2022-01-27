<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style.css">
    <title>Adicionando Pizza</title>
</head>
<body>    
<?php
    echo "<div align=center>";
    if(isset($_POST["numero"])&&isset($_POST["borda"])&&isset($_POST["tipo"])&&isset($_POST["tamanho"])){   
        if(preg_match("/^[1-9][0-9]*$/",$_POST["numero"])&&preg_match("/^(no)$|(^[1-9][0-9]*$)/",$_POST["borda"])&&preg_match("/(^[1-9][0-9]*$)/",$_POST["tipo"])){   
            $numero=$_POST["numero"];
            $_POST["borda"]=="no" ? $borda="null":$borda=$_POST["borda"];
            $tipo=$_POST["tipo"];
            $tamanho=$_POST["tamanho"][0];
            $qtdesabores=substr($_POST["tamanho"],2);
            $sabores=[];
            foreach($_POST as $key => $value){
                if(preg_match("/input_sabor/",$key)) array_push($sabores,$value);
            };
            $db=new SQLite3('../pizza.db');
            $db->exec("PRAGMA foreign_keys = ON");
            $pass=false;
            //verificar se comanda existe e não foi paga
            $comanda_verify=$db->query("select case when pago=0 then \"nao\" when pago=1 then \"sim\" end as pago from comanda where numero=$numero")->fetchArray()["pago"];
            if($comanda_verify==="nao"){
                //verificar se borda existe
                if($borda!="null"){
                    $verify_borda=$db->query("select codigo from borda");
                        while($row=$verify_borda->fetchArray()){
                            if($row["codigo"]==$borda){
                                $pass=true;
                                break;
                            }
                        }
                        if(!$pass){
                            echo "<h2>Borda inválida</h2><br>";
                            $db->close();
                            echo "<h2>Retornando</h2>";
                            header( "refresh:1;url=comandas_index.php" );
                            die(); 
                        }
                }
                //verificar se tipo existe
                $verify_tipo=$db->query("select codigo from tipo");
                    while($row=$verify_tipo->fetchArray()){
                        if($row["codigo"]==$tipo){
                            $pass=true;
                            break;
                        }
                    }
                    if(!$pass){
                        echo "<h2>tipo inválida</h2><br>";
                        $db->close();
                        echo "<h2>Retornando</h2>";
                        header( "refresh:1;url=comandas_index.php" );
                        die(); 
                    }
                //verificar tamanho e qtdesabores se está certa
                $verify_tamanho=$db->query("select codigo,qtdesabores from tamanho");
                    while($row=$verify_tamanho->fetchArray()){
                        if($row["codigo"]==$tamanho&&$row["qtdesabores"]==$qtdesabores){
                            $pass=true;
                            break;
                        }
                    }
                    if(!$pass){
                        echo "<h2>tamanho e(ou) qtdesabores inválida(s)</h2><br>";
                        $db->close();
                        echo "<h2>Retornando</h2>";
                        header( "refresh:1;url=comandas_index.php" );
                        die(); 
                    }
                //verificar se numero de sabores bate com quantidade de sabores
                if(count($sabores)<=$qtdesabores&&count($sabores)>0){
                    $data_sabores=[];
                    $data_sabores_query=$db->query("select codigo from sabor where tipo=$tipo");
                    while($row=$data_sabores_query->fetchArray()){
                        array_push($data_sabores,$row["codigo"]);
                    }
                    foreach($sabores as $sabor){
                        if(in_array($sabor,$data_sabores)) $pass=true;
                        else {
                            $pass=false;
                            break;
                        }
                    };
                    if(!$pass){
                        echo "<h2>Sabores Inválidos</h2><br>";
                        $db->close();
                        echo "<h2>Retornando</h2>";
                        header( "refresh:1;url=comandas_index.php" );
                        die(); 
                    }
                    
                }
                else $pass=false;
            
            
            }
            else $pass=false;
            
            if($pass) {        
                //enviar
                echo "<h1>Inserindo</h1>";
                echo "<h2>...</h2>";
                $insert_pizza=$db->exec("insert into pizza(comanda,tamanho,borda) values ($numero,\"$tamanho\",$borda)");
                $pizza_codigo=$db->changes();
                $pizza_codigo=$db->lastInsertRowID();
                $insert_sabores=false;
                foreach($sabores as $sabor){
                    $insert_sabores=$db->exec("insert into pizzasabor(pizza,sabor) values ($pizza_codigo,$sabor)");
                };
                if($insert_pizza&&$insert_sabores){
                    $db->close();
                    echo "<h2>Pizza Adicionada com sucesso</h2>";
                    header( "refresh:1;url=comandas_index.php" );
                    die();
                }
                else{
                    $db->close();
                    echo "<h2>Pizza não adicionanda um erro ocorreu</h2>";
                    echo "<h3>Tente Novamente</h3>";
                    header( "refresh:1;url=comandas_index.php" );
                    die();
                }
                
                
            }
            else{
                $db->close();
                echo "<h1>Dados inválidos</h1>";
                echo "<h2>Retornando</h2>";
                header( "refresh:1;url=comandas_index.php" );
                die(); 
            }
        }
        else{
            echo "<h1>Dados inválidos</h1>";
            echo "<h2>Retornando</h2>";
            header( "refresh:1;url=comandas_index.php" );
            die();
        }
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