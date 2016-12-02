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
				<h4  style="color:aqua; font-size: 2em"> Pagar Reserva </h4>
				<?php
					session_start();
					$_SESSION['page'] = 'pagar';
				?>
				<h3 style="color:magenta; font-weight: bold"> Pagar Reserva <?=$_REQUEST['numero']?>?</h3>
				<form action="insert.php" method="post">
					<p><input type="hidden" name="morada" value="<?=$_SESSION['morada']?>"></p>
					<p><input type="hidden" name="codigo" value="<?=$_SESSION['codigo']?>"></p>
					<p><input type="hidden" name="data_inicio" value="<?=$_SESSION['data_inicio']?>"></p>
					<p><input type="hidden" name="numero" value="<?=$_REQUEST['numero']?>"></p>
					<p> Método: <input type="text" name="metodo"></p>
            		<p><input type="submit" value="Confirmar"/></p>
        		</form>
        		<?php


					echo ("<a href=\"http://web.ist.utl.pt/ist182448/BD/reserva.php?morada={$_SESSION['morada']}&codigo={$_SESSION['codigo']}&data_inicio={$_SESSION['data_inicio']}\"style='color:gold; text-decoration: none;'> Cancelar </a>");

				    echo ("<br><a href=\"http://web.ist.utl.pt/ist182448/BD/\"style='color:gold; text-decoration: none;'> Menu Principal </a>");
					
					
					//echo("<p>Connection closed.</p>\n");

					//echo("<p>Test completed successfully.</p>\n");

				?>
			</div>
        </article>
    </section>
</body>
</html>
