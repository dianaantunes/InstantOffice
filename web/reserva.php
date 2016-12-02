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
				<h4  style="color:aqua; font-size: 2em"> Reservas </h4>
				<?php
					session_start();
					$_SESSION['page'] = 'reserva';
				?>
				<h3 style="color:magenta; font-weight: bold"> Nova Reserva em <?=$_REQUEST['morada']?>, 
				<?=$_REQUEST['codigo']?>, <?=$_REQUEST['data_inicio']?>: </h3>
				<form action="insert.php" method="post">
					<p><input type="hidden" name="morada" value="<?=$_REQUEST['morada']?>"></p>
					<p><input type="hidden" name="codigo" value="<?=$_REQUEST['codigo']?>"></p>
					<p><input type="hidden" name="data_inicio" value="<?=$_REQUEST['data_inicio']?>"></p>
           	 		<p> NIF do Utilizador: <input type="text" name="nif"></p>
           	 		<p> Numero da Reserva: <input type="text" name="numero"></p>
            		<p><input type="submit" value="Inserir"/></p>
        		</form>
        		<?php
					$morada = $_REQUEST['morada'];
					$codigo = $_REQUEST['codigo'];
					$data_inicio = $_REQUEST['data_inicio'];

					$_SESSION['morada'] = $morada;
					$_SESSION['codigo'] = $codigo;
					$_SESSION['data_inicio'] = $data_inicio;

					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/oferta.php\"style='color:gold; text-decoration: none;'> Go Back </a>");

					$host="db.ist.utl.pt";	// o MySQL esta disponivel nesta maquina
					$user="ist182448";	// -> substituir pelo nome de utilizador
					$password="edurocks";	// -> substituir pela password (dada pelo mysql_reset, ou atualizada pelo utilizador)
					$dbname = $user;	// a BD tem nome identico ao utilizador

					$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

					//echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");
					try{

					$sql = "SELECT R.* FROM reserva R, aluga A
					WHERE A.morada = :morada AND A.codigo = :codigo 
					AND A.data_inicio = :data_inicio AND R.numero = A.numero";
					$stmt = $connection->prepare($sql); 
					$stmt->bindParam(':morada', $morada);  
					$stmt->bindParam(':codigo', $codigo); 
					$stmt->bindParam(':data_inicio', $data_inicio); 
					$stmt->execute();

					//echo("<p>Query: " . $sql . "</p>\n");

					$result = $stmt->fetchAll();
					
					$num = count($result);
					echo("<p>$num Reservas em Oferta $morada, $codigo, $data_inicio:</p>\n");
					echo("<table border=\"5\">\n");
					echo("<tr><td> Numero </td></tr>\n");
					foreach($result as $row)
					{
						echo("<tr>");
						echo("<td>{$row["numero"]}</td>");
						echo("<td><a href=\"pagar.php?numero={$row['numero']}\" style='color:aqua; text-decoration: none;'> Pagar </a></td>\n");
						echo("</tr>\n");
					}
					echo("</table>\n");
						
				    $connection = null;

				    echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
					}
					catch (PDOException $e)
					{
						echo("<p>ERROR: {$e->getMessage()}</p>");
					}
					
					//echo("<p>Connection closed.</p>\n");

					//echo("<p>Test completed successfully.</p>\n");

				?>
			</div>
        </article>
    </section>
</body>
</html>
