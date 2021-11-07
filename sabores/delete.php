<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remover Sabor</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div align="center">
        <h1>Removendo...</h1>
    </div>
    <?php
        if(isset($_GET['codigo_s'])){
            $sabor=$_GET['codigo_s'];
            $db=new SQLite3('../pizza.db');
            $db->query("delete
            from 
            pizza 
            where 
            pizza.codigo in (
            select
            pizza.codigo
            from pizza 
            join pizzasabor on pizzasabor.pizza=pizza.codigo 
            left join sabor on sabor.codigo=pizzasabor.sabor
            where sabor.codigo =$sabor
            )
            ;");
            $result=$db->query("delete from saboringrediente where saboringrediente.sabor=$sabor");
            if($result){ 
                $result2=$db->query("delete from sabor where sabor.codigo=$sabor");
                if($result2) echo "Sabor Removido";
                else echo "Erro retornando";
            }
            else echo "Erro retornando";
        }
        else{
            echo "Erro retornando";
        }
        header( "refresh:1;url=sabor_index.php" );
        die();    
    ?>
</body>
</html>




















