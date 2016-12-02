<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html, charset=utf-8">
    <title>InstantOffice</title>
    <link rel="stylesheet" type="text/css" href="https://static.tecnico.ulisboa.pt/projects/web-hosting/css/style.css">
   
</head>
<body>
    <section id="content-wrap">
        <article>
            <div class="" style="padding: 20px">
				<h1> InstantOffice</h1>
                <h2> Aplicação de Reservas </h2>
                <p> Projecto de Bases de Dados: Parte 3 </p>
				<h4  style="color:aqua; font-size: 2em"> Espacos de Trabalho </h4>
				<?php
					session_start();
					$_SESSION['page'] = 'espaco';
				?>
				<h3 style="color:magenta; font-weight: bold"> 
				Novo Espaco de Trabalho em <?=$_REQUEST['morada']?>: </h3>
				<form action="insert.php" method="post">
					<p><input type="hidden" name="morada" value="<?=$_REQUEST['morada']?>"></p>
           	 		<p> Código: <input type="text" name="codigo"></p>
           	 		<p> URL Foto:<input type="text" name="foto"></p>
            		<p><input type="submit" value="Inserir"></p>
        		</form>

        		<form action="total.php" method="post">
					<p><input type="hidden" name="morada" value="<?=$_REQUEST['morada']?>"></p>
            		<p><input type="submit" value="Listar Total € por Espaco em <?=$_REQUEST['morada']?>"></p>
        		</form>
        		<?php
					$morada = $_REQUEST['morada'];

					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/edificio.php?morada={$morada}\"style='color:gold; text-decoration: none;'> Go Back </a>");

					$host="db.ist.utl.pt";	// o MySQL esta disponivel nesta maquina
					$user="ist182448";	// -> substituir pelo nome de utilizador
					$password="edurocks";	// -> substituir pela password (dada pelo mysql_reset, ou atualizada pelo utilizador)
					$dbname = $user;	// a BD tem nome identico ao utilizador

					$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

					try{
					$sql = "SELECT * FROM espaco WHERE morada = '$morada';";
					$stmt = $connection->prepare($sql); 
					$stmt->bindParam(':morada', $morada); 
					$stmt->execute();
					$result = $stmt->fetchAll();
					$num = count($result);

					echo("<p>$num Espaços de Trabalho em $morada:</p>\n");
					echo("<table border=\"5\">\n");
					echo("<tr><td> Morada </td><td> Codigo </td></tr>\n");
					foreach($result as $row)
					{
						echo("<tr>");
						echo("<td>{$row["morada"]}</td>");
						echo("<td>{$row["codigo"]}</td>");
						echo("<td><a href=\"posto.php?morada={$row['morada']}&codigo={$row['codigo']}\" style='color:aqua; text-decoration: none;'> Ver </a></td>\n");
						echo("<td><a href=\"remove.php?morada={$row['morada']}&codigo={$row['codigo']}\" style='color:aqua; text-decoration: none;'> Remover </a></td>\n");
						echo("</tr>\n");
					}
					echo("</table>\n");
					
					}
				    catch (PDOException $e)
					{
						echo("<p>ERROR: {$e->getMessage()}</p>");
					}	
				    $connection = null;

				    echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
				?>
			</div>
        </article>
    </section>
</body>
</html>
