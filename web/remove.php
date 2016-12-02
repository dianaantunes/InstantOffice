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
					include 'functions.php';
					session_start();
					$morada = $_REQUEST['morada'];
					$codigo = $_REQUEST['codigo'];
					$data_inicio = $_REQUEST['data_inicio'];
					$page = $_SESSION['page'];
					// Save in session superglobal to be able to go back
					$_SESSION['morada'] = $morada;
					$_SESSION['codigo'] = $codigo;
					$_SESSION['codigo_espaco'] = $_REQUEST['codigo_espaco'];

    				$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password);
					$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
					
					try
	    			{
	    				$connection->beginTransaction();

	    				if ($page == 'edificio'){
							removeEdificio($morada);
							$connection->commit();
				    		echo("<p> Edifício removido com sucesso.</p>\n");
						}

						elseif ($page == 'espaco' || $page == 'posto'){
							removeAlugavel($morada, $codigo);
							$connection->commit();
				    		echo("<p> Alugavel removido com sucesso.</p>\n");
				    		if ($_SESSION['page'] == 'posto'){
				    			// just to be able to go back
				    			$_SESSION['codigo'] = $_SESSION['codigo_espaco'];
				    		}
						}

						elseif ($page == 'oferta'){
							removeOferta($morada, $codigo, $data_inicio);
							$connection->commit();
							echo("<p> Oferta removida com sucesso.</p>\n");
						}													
					}
				    catch (PDOException $e)
					{
						$connection->rollBack();
						echo("<p>ERROR: {$e->getMessage()}</p>");
					}

					$connection = null;
					
					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/" . $_SESSION['page'] . ".php?morada={$_SESSION['morada']}&codigo={$_SESSION['codigo']}\"style='color:gold; text-decoration: none;'> Go Back </a>");
					echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
				?>
				
			</div>
        </article>
    </section>
</body>
</html>
