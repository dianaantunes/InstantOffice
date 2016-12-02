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
				
				<?php

					session_start();
					$morada = $_REQUEST['morada'];		

					$host="db.ist.utl.pt";	// o MySQL esta disponivel nesta maquina
					$user="ist182448";	// -> substituir pelo nome de utilizador
					$password="edurocks";	// -> substituir pela password (dada pelo mysql_reset, ou atualizada pelo utilizador)
					$dbname = $user;	// a BD tem nome identico ao utilizador
    				$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password);
					$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
					
					try
	    			{
	    			$sql = "SELECT morada, codigo_espaco, pago FROM 
	    			(SELECT morada, codigo_espaco, sum((datediff(data_fim, data_inicio))*tarifa) as pago
					FROM oferta NATURAL JOIN aluga NATURAL JOIN paga NATURAL JOIN posto
					WHERE (morada = '$morada')
					GROUP BY codigo_espaco, morada) as temp
					UNION
					(SELECT morada, codigo as codigo_espaco, sum((datediff(data_fim, data_inicio))*tarifa) as pago
					FROM oferta NATURAL JOIN aluga NATURAL JOIN paga NATURAL JOIN espaco
					WHERE (morada = '$morada')
					GROUP BY codigo_espaco, morada);";

					$result = $connection->query($sql);
					
					$num = $result->rowCount();

					echo("<p>Espaços de Trabalho em $morada com Reservas Pagas:<br> 
						(Nota: os espaços que não aparecem têm um total de 0€)</p>\n");
					echo("<table border=\"5\">\n");
					echo("<tr><td> Morada </td><td> Codigo </td><td> Total € </td></tr>\n");
					foreach($result as $row)
					{
						echo("<tr>");
						echo("<td>{$row["morada"]}</td>");
						echo("<td>{$row["codigo_espaco"]}</td>");
						echo("<td>{$row["pago"]}</td>");
						echo("</tr>\n");
					}
					echo("</table>\n");
						
				    $connection = null;			
					}
				    catch (PDOException $e)
					{
						echo("<p>ERROR: {$e->getMessage()}</p>");
					}

					$connection = null;
					
					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/espaco.php?morada={$morada}\"style='color:gold; text-decoration: none;'> Go Back </a>");
					echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
				?>
				
			</div>
        </article>
    </section>
</body>
</html>
