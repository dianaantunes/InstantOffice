<?php
	$host="db.ist.utl.pt";	// o MySQL esta disponivel nesta maquina
	$user="ist182448";	// -> substituir pelo nome de utilizador
	$password="edurocks";	// -> substituir pela password (dada pelo mysql_reset, ou atualizada pelo utilizador)
	$dbname = $user;	// a BD tem nome identico ao utilizador
	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password);
	$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	function removeEdificio($morada) {
		echo("<p> In removeEdificio </p>");   		
		global $connection; 
   		removeAlugavel($morada, NULL); 
   		$sql = "DELETE FROM edificio WHERE morada = :morada;";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->execute();
		echo("<p> In removeEdificio FIM </p>");
	}

	function removeAlugavel($morada, $codigo) { 
		//Se receber um espaco, remove este e este remove todos os postos nele contidos
		//Se receber um posto, remove apenas o posto, 
		// dado que os codigos sao diferentes entre espaco e posto
		// Se receber codigo a NULL, remove todos com $morada
		echo("<p> In removeAlugavel morada = '$morada', codigo = '$codigo' </p>");
		global $connection; 
		removePosto($morada, $codigo, NULL);
   		removeEspaco($morada, $codigo);
   		removeArrenda($morada, $codigo);
   		removeOferta($morada, $codigo, NULL);
   		$sql = "DELETE FROM alugavel WHERE morada = :morada AND (:codigo IS NULL OR codigo = :codigo);";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);
		$stmt->bindParam(':codigo', $codigo);  
		$stmt->execute();
		echo("<p> In removeAlugavel FIM </p>");
	}

	function removeArrenda($morada, $codigo) {
		echo("<p> In removeArrenda </p>");

		global $connection; 
   		removeFiscaliza($morada, $codigo);
   		$sql = "DELETE FROM arrenda WHERE morada = :morada AND (:codigo IS NULL OR codigo = :codigo);";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);
		$stmt->bindParam(':codigo', $codigo);   
		$stmt->execute();
		echo("<p> In removeArrenda FIM </p>");
	}

	function removeFiscaliza($morada, $codigo) {
		// Se receber codigo NULL, remove todos os fiscaliza com $morada
		echo("<p> In removeFiscaliza </p>");
		global $connection; 
   		$sql = "DELETE FROM fiscaliza WHERE morada = :morada AND (:codigo IS NULL OR codigo = :codigo);";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada); 
		$stmt->bindParam(':codigo', $codigo); 
		$stmt->execute();
		echo("<p> In removeFiscaliza FIM </p>");
	}

	function removeEspaco($morada, $codigo) {
		echo("<p> In removeEspaco </p>");
		// Se receber codigo NULL, remove todos os espaco com $morada
		global $connection; 
		removePosto($morada, NULL, $codigo); //remove todos os postos nele contidos
   		$sql = "DELETE FROM espaco WHERE morada = :morada AND (:codigo IS NULL OR codigo = :codigo);";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo);  
		$stmt->execute();
		echo("<p> In removeEspaco FIM </p>");
	}

	function removePosto($morada, $codigo, $codigo_espaco) {
		echo("<p> In removePosto </p>");
		// Se receber codigo NULL, remove todos os postos do espaco com $codigo_espaco
		// Se receber codigo_espaco NULL, remove o posto com $codigo
		// Se receber os dois a NULL, remove todos os postos com a $morada
		global $connection; 
   		$sql = "DELETE FROM posto WHERE morada = :morada 
   		AND (:codigo IS NULL OR codigo = :codigo) 
   		AND (:codigo_espaco IS NULL OR codigo_espaco = :codigo_espaco);";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada); 
		$stmt->bindParam(':codigo', $codigo); 
		$stmt->bindParam(':codigo_espaco', $codigo_espaco);     
		$stmt->execute();
		
		echo("<p> In removePosto FIM </p>");
	}

	function removeOferta($morada, $codigo, $data_inicio) {
		echo("<p> In removeOferta morada = '$morada', codigo = '$codigo', data_inicio='$data_inicio' </p>");
		// se data_inicio e $codigo null, remove todas as ofertas com $morada
		// se data_inicio null, remove todas as ofertas com $morada e $codigo
		global $connection; 
   		removeAluga($morada, $codigo, $data_inicio);
   		$sql = "DELETE FROM oferta WHERE (morada = :morada 
   		AND (:codigo IS NULL OR codigo = :codigo) 
   		AND (:data_inicio IS NULL OR data_inicio = :data_inicio));";
   		echo("<p> In removeOferta MIDDLE morada = '$morada', codigo = '$codigo', data_inicio='$data_inicio' </p>");
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);
		$stmt->bindParam(':codigo', $codigo);
		$stmt->bindParam(':data_inicio', $data_inicio);  
		$stmt->execute();
		echo("<p> In removeOferta FIM </p>");
	}

	function removeAluga($morada, $codigo, $data_inicio) {
		echo("<p> In removeAluga morada = '$morada', codigo = '$codigo', data_inicio='$data_inicio'</p>");
		global $connection; 
   		$sql = "DELETE FROM aluga WHERE (morada = :morada 
   		AND (:codigo IS NULL OR codigo = :codigo) 
   		AND (:data_inicio IS NULL OR data_inicio = :data_inicio));";
   		
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo);
		$stmt->bindParam(':data_inicio', $data_inicio);  
		$stmt->execute();
		echo("<p> In removeAluga FIM </p>");
	}

	function insereEdificio($morada) {
		echo("<p> In insereEdificio </p>");
		global $connection; 
   		$sql = "INSERT INTO edificio (morada) VALUES(:morada)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->execute();
		echo("<p> In insereEdificio FIM </p>");
	}

	function insereAlugavel($morada, $codigo, $foto) {
		echo("<p> In insereAlugavel </p>");
		global $connection; 
   		$sql = "INSERT INTO alugavel (morada, codigo, foto) VALUES(:morada, :codigo, :foto)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo);
		$stmt->bindParam(':foto', $foto); 
		$stmt->execute();
		echo("<p> In insereAlugavel FIM </p>");
	}

	function insereEspaco($morada, $codigo, $foto) {
		echo("<p> In insereEspaco </p>");
		global $connection; 
		insereAlugavel($morada, $codigo, $foto);
   		$sql = "INSERT INTO espaco (morada, codigo) VALUES(:morada, :codigo)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo); 
		$stmt->execute();
		echo("<p> In insereEspaco FIM </p>");
	}

	function inserePosto($morada, $codigo, $codigo_espaco, $foto) {
		echo("<p> In inserePosto </p>");
		global $connection; 
		insereAlugavel($morada, $codigo, $foto);
   		$sql = "INSERT INTO posto (morada, codigo, codigo_espaco) 
   		VALUES(:morada, :codigo, :codigo_espaco)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo); 
		$stmt->bindParam(':codigo_espaco', $codigo_espaco); 
		$stmt->execute();
		echo("<p> In inserePosto FIM </p>");
	}

	function insereOferta($morada, $codigo, $data_inicio, $data_fim, $tarifa) {
		echo("<p> In insereOferta </p>");
		global $connection; 
   		$sql = "INSERT INTO oferta (morada, codigo, data_inicio, data_fim, tarifa) 
   		VALUES(:morada, :codigo, :data_inicio, :data_fim, :tarifa)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':morada', $morada);  
		$stmt->bindParam(':codigo', $codigo); 
		$stmt->bindParam(':data_inicio', $data_inicio); 
		$stmt->bindParam(':data_fim', $data_fim); 
		$stmt->bindParam(':tarifa', $tarifa); 
		$stmt->execute();
		echo("<p> In insereOferta FIM </p>");
	}

	function insereReserva($morada, $codigo, $data_inicio, $nif, $numero) {
		echo("<p> In insereReserva </p>");
		global $connection; 
		$sql = "INSERT INTO reserva (numero) VALUES(:numero)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':numero', $numero); 
		$stmt->execute();

   		$sql2 = "INSERT INTO aluga (morada, codigo, data_inicio, nif, numero) 
   		VALUES(:morada, :codigo, :data_inicio, :nif, :numero)";
   		$stmt2 = $connection->prepare($sql2); 
		$stmt2->bindParam(':morada', $morada);  
		$stmt2->bindParam(':codigo', $codigo); 
		$stmt2->bindParam(':data_inicio', $data_inicio); 
		$stmt2->bindParam(':nif', $nif); 
		$stmt2->bindParam(':numero', $numero); 
		$stmt2->execute();

   		$time_stamp = date("Y-m-d h:i:s");
   		echo('$time_stamp');
   		$sql3 = "INSERT INTO estado (numero, time_stamp, estado) 
   		VALUES(:numero, :time_stamp, 'Aceite')";
		$stmt3 = $connection->prepare($sql3); 
		$stmt3->bindParam(':numero', $numero);  
		$stmt3->bindParam(':time_stamp', $time_stamp); 
		$stmt3->execute();
		echo("<p> In insereReserva FIM </p>");
	}

	function inserePaga($numero, $metodo) {
		$time_stamp = date("Y-m-d h:i:s");
		echo("<p> In inserePaga numero = '$numero', metodo = '$metodo' time_stamp = '$time_stamp'</p>");
		global $connection; 
		$time_stamp = date("Y-m-d h:i:s");

		$sql = "INSERT INTO paga (numero, data, metodo) 
		VALUES(:numero, :time_stamp, :metodo)";
		$stmt = $connection->prepare($sql); 
		$stmt->bindParam(':numero', $numero); 
		$stmt->bindParam(':time_stamp', $time_stamp); 
		$stmt->bindParam(':metodo', $metodo); 
		$stmt->execute();

   		$sql2 = "INSERT INTO estado (numero, time_stamp, estado) 
   		VALUES(:numero, :time_stamp, 'Paga')";
		$stmt2 = $connection->prepare($sql2); 
		$stmt2->bindParam(':numero', $numero);  
		$stmt2->bindParam(':time_stamp', $time_stamp); 
		$stmt2->execute();
		echo("<p> In insereReserva FIM </p>");
	}
?>