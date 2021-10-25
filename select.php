<html>
<body>
<?php
function url($campo, $valor) {
	$result = array();
	if (isset($_GET["codigo"])) $result["codigo"] = "codigo=".$_GET["codigo"];
	if (isset($_GET["nome"])) $result["nome"] = "nome=".$_GET["nome"];
	if (isset($_GET["genero"])) $result["genero"] = "genero=".$_GET["genero"];
	if (isset($_GET["nascimento"])) $result["nascimento"] = "nascimento=".$_GET["nascimento"];
	if (isset($_GET["orderby"])) $result["orderby"] = "orderby=".$_GET["orderby"];
	if (isset($_GET["offset"])) $result["offset"] = "offset=".$_GET["offset"];
	$result[$campo] = $campo."=".$valor;
	return("select.php?".strtr(implode("&", $result), " ", "+"));
}

$db = new SQLite3("pessoa.db");
$db->exec("PRAGMA foreign_keys = ON");

$limit = 5;

echo "<h1>Cadastro de pessoas</h1>\n";

echo "<select id=\"campo\" name=\"campo\">\n";
echo "<option value=\"codigo\"".((isset($_GET["codigo"])) ? " selected" : "").">Código</option>\n";
echo "<option value=\"nome\"".((isset($_GET["nome"])) ? " selected" : "").">Nome</option>\n";
echo "<option value=\"genero\"".((isset($_GET["genero"])) ? " selected" : "").">Gênero</option>\n";
echo "<option value=\"nascimento\"".((isset($_GET["nascimento"])) ? " selected" : "").">Nascimento</option>\n";
echo "</select>\n"; 

$value = "";
if (isset($_GET["codigo"])) $value = $_GET["codigo"];
if (isset($_GET["nome"])) $value = $_GET["nome"];
if (isset($_GET["genero"])) $value = $_GET["genero"];
if (isset($_GET["nascimento"])) $value = $_GET["nascimento"];
echo "<input type=\"text\" id=\"valor\" name=\"valor\" value=\"".$value."\" size=\"20\"> \n";

$parameters = array();
if (isset($_GET["orderby"])) $parameters[] = "orderby=".$_GET["orderby"];
if (isset($_GET["offset"])) $parameters[] = "offset=".$_GET["offset"];
echo "<a href=\"\" onclick=\"value = document.getElementById('valor').value.trim().replace(/ +/g, '+'); result = '".strtr(implode("&", $parameters), " ", "+")."'; result = ((value != '') ? document.getElementById('campo').value+'='+value+((result != '') ? '&' : '') : '')+result; this.href ='select.php'+((result != '') ? '?' : '')+result;\">&#x1F50E;</a><br>\n";
echo "<br>\n";

echo "<table border=\"1\">\n";
echo "<tr>\n";
echo "<td><a href=\"insert.php\">&#x1F4C4;</a></td>\n";
echo "<td><b>Código</b> <a href=\"".url("orderby", "codigo+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "codigo+desc")."\">&#x25B4;</a></td>\n";
echo "<td><b>Nome</b> <a href=\"".url("orderby", "nome+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "nome+desc")."\">&#x25B4;</a></td>\n";
echo "<td><b>Gênero</b> <a href=\"".url("orderby", "genero+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "genero+desc")."\">&#x25B4;</a></td>\n";
echo "<td><b>Nascimento</b> <a href=\"".url("orderby", "nascimento+asc")."\">&#x25BE;</a> <a href=\"".url("orderby", "nascimento+desc")."\">&#x25B4;</a></td>\n";
echo "<td></td>\n";
echo "</tr>\n";

$where = array();
if (isset($_GET["codigo"])) $where[] = "codigo = ".$_GET["codigo"];
if (isset($_GET["nome"])) $where[] = "nome like '%".strtr($_GET["nome"], " ", "%")."%'";
if (isset($_GET["genero"])) $where[] = "genero = '".$_GET["genero"]."'";
if (isset($_GET["nascimento"])) $where[] = "date(nascimento) = date('".$_GET["nascimento"]."')";
$where = (count($where) > 0) ? "where ".implode(" and ", $where) : "";

$total = $db->query("select count(*) as total from pessoa ".$where)->fetchArray()["total"];

$orderby = (isset($_GET["orderby"])) ? $_GET["orderby"] : "codigo asc";

$offset = (isset($_GET["offset"])) ? max(0, min($_GET["offset"], $total-1)) : 0;
$offset = $offset-($offset%$limit);

$results = $db->query("select * from pessoa ".$where." order by ".$orderby." limit ".$limit." offset ".$offset);
while ($row = $results->fetchArray()) {
	echo "<tr>\n";
	echo "<td><a href=\"update.php?codigo=".$row["codigo"]."\">&#x1F4DD;</a></td>\n";
	echo "<td>".$row["codigo"]."</td>\n";
	echo "<td>".$row["nome"]."</td>\n";
	echo "<td>".$row["genero"]."</td>\n";
	echo "<td>".$row["nascimento"]."</td>\n";
	echo "<td><a href=\"delete.php?codigo=".$row["codigo"]."\" onclick=\"return(confirm('Excluir ".$row["nome"]."?'));\">&#x1F5D1;</a></td>\n";
	echo "</tr>\n";
}

echo "</table>\n";
echo "<br>\n";

for ($page = 0; $page < ceil($total/$limit); $page++) {
	echo (($offset == $page*$limit) ? ($page+1) : "<a href=\"".url("offset", $page*$limit)."\">".($page+1)."</a>")." \n";
}

$db->close();
?>
</body>
</html>

