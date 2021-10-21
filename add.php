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
<?php
   echo "<main align='center'>";
   echo "<h2>Pizzaria</h2>";
   if(isset($_GET['codigo_s'])){
       $sabor=$_GET['codigo_s'];
       $db=new SQLite3('pizza.db');
       $db->exec("PRAGMA foreign_keys = ON");
       $types=$db->query("select * from tipo");
       $ingredientes=$db->query("select * from ingrediente");
       $results=$db->query("
           select 
               sabor.codigo as codigo,
               sabor.nome as sabor,
               tipo.nome as tipo,
               group_concat(ingrediente.nome,',') as ingredientes
           from 
               sabor
               join saboringrediente on sabor.codigo=saboringrediente.sabor
               join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
               join tipo on sabor.tipo=tipo.codigo
           where sabor.codigo=$sabor")->fetchArray();

       if($results['codigo']&&$results['sabor']&&$results['tipo']&&$results['ingredientes']){
           $name_sabor=$results["sabor"];
           $tipo_name=$results['tipo'];
           $sabor_codigo=$results['codigo'];
           $ingredientes_sabor=explode(',',$results['ingredientes']);
           echo "<form method=POST action=update.php>";
           echo "<input name=codigo type='hidden' value=\"$sabor_codigo\">";
           echo "<label>Nome do Sabor<br>";               
               echo "<input name=\"name_sabor\" type='text'"."value=\"$name_sabor\"".">";
           echo "</label>"; 
           echo "<br>";           
           echo "Tipo<br>";
               echo "<select name=tipo>";
                   while($row=$types->fetchArray()){
                       $nome=$row['nome'];
                       $codigo=$row['codigo'];
                       if(strtolower($nome)==strtolower($tipo_name)) echo "<option "."value=\"$codigo\""." selected=\"selected\">".$row['nome']."</option><br>";
                       else echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
                   }
               echo "</select>";
           echo "<br>";
           echo "Ingrediente<br>";
               echo "<select id=\"select_add\">";
                   while($row=$ingredientes->fetchArray()){
                       $nome=$row['nome'];
                       $codigo=$row['codigo'];
                       echo "<option "."value=\"$codigo\"".">".$row['nome']."</option><br>";                        
                   }
               echo "</select><input id=\"add\" type='button' value=\"➕\"><br>";
           echo "Ingredientes:";
           echo "<div align='center'>";
               echo "<table>";
               foreach($ingredientes_sabor as $val){
                   echo "<tr>";
                       echo "<input type='hidden' value=\"\">";
                       echo "<td>$val</td>";
                       echo "<td><input type='button' value=\"❌\"></td>";
                   echo "</tr>";
               }
               echo "</table>";
           echo "<div>";
           echo "<br><input id=\"send\" type='button' value=\"Alterar\" >";
           echo "</form>";
       }
       
       $db->close();
   }
echo "</main>";
?>    
</body>
</html>
