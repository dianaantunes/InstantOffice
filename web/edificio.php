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
				<h4  style="color:aqua; font-size: 2em"> Edifícios </h4>
				<?php
					session_start();
					$_SESSION['page'] = 'edificio';
				?>
				<h3 style="color:magenta; font-weight: bold"> Novo Edificio: </h3>
				<form action="insert.php" method="post">
           	 		<p>Morada:<input type="text" name="morada"></p>
            		<p><input type="submit" value="Inserir"></p>
        		</form>
				
				<?php
					$host="db.ist.utl.pt";	// o MySQL esta disponivel nesta maquina
					$user="ist182448";	// -> substituir pelo nome de utilizador
					$password="edurocks";	// -> substituir pela password (dada pelo mysql_reset, ou atualizada pelo utilizador)
					$dbname = $user;	// a BD tem nome identico ao utilizador

					$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

					//echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");

					$sql = "SELECT * FROM edificio;";

					//echo("<p>Query: " . $sql . "</p>\n");

					$result = $connection->query($sql);
					
					$num = $result->rowCount();

					echo("<p>$num Edifícios:</p>\n");

					echo("<table border=\"5\">\n");
					echo("<tr><td> Morada</td></tr>\n");
					foreach($result as $row)
					{
						echo("<tr>");
						echo("<td>{$row["morada"]}</td>");
						echo("<td><a href=\"espaco.php?morada={$row['morada']}\" style='color:aqua; text-decoration: none;'> Ver </a></td>\n");
						echo("<td><a href=\"remove.php?morada={$row['morada']}\" style='color:aqua; text-decoration: none;'> Remover </a></td>\n");
						echo("</tr>\n");
					}
					echo("</table>\n");
						
				    $connection = null;

				    echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
					
					//echo("<p>Connection closed.</p>\n");

					//echo("<p>Test completed successfully.</p>\n");

				?>
			</div>
        </article>
    </section>
</body>
</html>
