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
					$codigo_espaco = $_REQUEST['codigo_espaco'];
					
					$data_inicio = $_REQUEST['data_inicio'];
					$data_fim = $_REQUEST['data_fim'];
					$tarifa = $_REQUEST['tarifa'];
					$nif = $_REQUEST['nif'];
					$numero = $_REQUEST['numero'];
					$metodo = $_REQUEST['metodo'];
					$foto = $_REQUEST['foto'];
					$page = $_SESSION['page'];
					
					// Save in session superglobal to be able to go back
					$_SESSION['morada'] = $morada;
					$_SESSION['codigo'] = $codigo;
					$_SESSION['codigo_espaco'] = $codigo_espaco;
					$_SESSION['data_inicio'] = $data_inicio;
					$_SESSION['numero'] = $numero;

    				$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password);
					$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
					try
	    			{
	    				$connection->beginTransaction();

	    				if ($page == 'edificio'){
							insereEdificio($morada);
							$connection->commit();
				    		echo("<p> Edifício inserido com sucesso.</p>\n");
						}

						elseif ($page == 'espaco'){ 
							insereEspaco($morada, $codigo, $foto);
							$connection->commit();
				    		echo("<p> Espaco inserido com sucesso.</p>\n");
						}

						elseif ($page == 'posto'){
							inserePosto($morada, $codigo, $codigo_espaco, $foto);
							$connection->commit();
				    		echo("<p> Posto inserido com sucesso.</p>\n");
				    		// just to be able to go back
				    		$_SESSION['codigo'] = $_SESSION['codigo_espaco'];
				    		}

						elseif ($page == 'oferta'){
							insereOferta($morada, $codigo, $data_inicio, $data_fim, $tarifa);
							$connection->commit();
							echo("<p> Oferta inserida com sucesso.</p>\n");
						}

						elseif ($page == 'reserva'){
							insereReserva($morada, $codigo, $data_inicio, $nif, $numero);
							$connection->commit();
							echo("<p> Reserva inserida com sucesso.</p>\n");
						}		

						elseif ($page == 'pagar'){
							inserePaga($numero, $metodo);
							$connection->commit();
							echo("<p> Reserva paga.</p>\n");
							//Just to be able to go back and dont return to pagar menu
							$_SESSION['page'] = 'reserva';
						}													
					}
				    catch (PDOException $e)
					{
						$connection->rollBack();
						echo("<p>ERROR: {$e->getMessage()}</p>");
					}

					$connection = null;
					
					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/" . $_SESSION['page'] . ".php?morada={$_SESSION['morada']}&codigo={$_SESSION['codigo']}&data_inicio={$_SESSION['data_inicio']}&numero={$_SESSION['numero']}\"style='color:gold; text-decoration: none;'> Go Back </a>");
					echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
				?>
				
			</div>
        </article>
    </section>
</body>
</html>
