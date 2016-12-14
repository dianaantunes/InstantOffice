--
-- Table structure for table `location_dimension`
--
DROP TABLE IF EXISTS location_dimension;
CREATE TABLE location_dimension (
  location_id 	varchar(255) 	NOT NULL,
  morada 		varchar(255) 	NOT NULL,
  codigo_espaco varchar(255) 	NOT NULL,
  codigo_posto 	varchar(255)
);
--
-- Dumping data for table `location_dimension`
--
INSERT INTO location_dimension
	SELECT  CONCAT(espaco.morada, ' ', espaco.codigo) AS location_id,
			espaco.morada AS morada,
			espaco.codigo AS codigo_espaco,
			posto.codigo AS codigo_posto FROM
	espaco LEFT JOIN posto
	ON espaco.codigo = posto.codigo_espaco
;
--
-- Table structure for table `user_dimension`
--
DROP TABLE IF EXISTS user_dimension;
CREATE TABLE user_dimension (
	user_id		varchar(9) 		NOT NULL,
    nome 		varchar(80) 	NOT NULL,
    telefone 	varchar(26) 	NOT NULL
);
--
-- Dumping data for table `user_dimension`
--
INSERT INTO user_dimension
	SELECT nif, nome, telefone FROM user
;
--
-- Table structure for table `date_dimension`
--
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  date_id 	varchar(5) 		NOT NULL,
  mes 		varchar(9) 		NOT NULL,
  dia 		int(11) 		NOT NULL
);
--
-- Dumping data for table `date_dimension`
--
DROP PROCEDURE IF EXISTS createdatedimension;
DELIMITER //
CREATE PROCEDURE createdatedimension()
BEGIN
SET @dia:=0;
dias:	WHILE @dia<31 DO
		SET @mes:=0;
		meses:	WHILE @mes<12 DO
				INSERT INTO date_dimension VALUES (CONCAT(@mes,'-',@dia), @mes, @dia);
				SET @mes:=@mes+1;
		END WHILE meses;
		SET @dia:=@dia+1;
END WHILE dias;
END//
DELIMITER ;
CALL createdatedimension();
--
-- Table structure for table `time_dimension`
--
DROP TABLE IF EXISTS time_dimension;
CREATE TABLE time_dimension (
  time_id 	varchar(5) 	NOT NULL,
  hora 		int(11) 	NOT NULL,
  minuto 	int(11) 	NOT NULL
);
--
-- Dumping data for table `time_dimension`
--
DROP PROCEDURE IF EXISTS createtimedimension;
DELIMITER //
CREATE PROCEDURE createtimedimension()
BEGIN
SET @hora:=0;
WHILE @hora < 24 DO
	SET @minuto:=0;
	WHILE @minuto < 60 DO
		INSERT INTO time_dimension VALUES (CONCAT(@hora,':',@minuto), @hora, @minuto);
		SET @minuto:=@minuto+1;
	END WHILE;
	SET @hora:=@hora+1;
END WHILE;
END//
DELIMITER ;
CALL createtimedimension();
--
-- Table structure for table `reservasolap`
--
DROP TABLE IF EXISTS reservasolap;
CREATE TABLE reservasolap (
  location_id 	varchar(255) 	NOT NULL,
  user_id 		varchar(9) 		NOT NULL,
  date_id 		varchar(7)		NOT NULL,
  time_id 		varchar(5)	 	NOT NULL,
  montante 		varchar(255) 	NOT NULL,
  duracao		varchar(255) 	NOT NULL
);

INSERT INTO reservasolap
	SELECT CONCAT(morada, ' ', codigo) as location_id,
		   	nif AS user_id,
			CONCAT(MONTH(data),'-', DAY(data)) AS date_id,
			CONCAT(HOUR(data),':', MINUTE(data)) AS time_id,
			datediff(data_fim, data_inicio)*tarifa as montante,
			datediff(data_fim, data_inicio) as duracao
	FROM reserva NATURAL JOIN aluga NATURAL JOIN oferta NATURAL JOIN paga
;

