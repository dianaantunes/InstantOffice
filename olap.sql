--
-- Table structure for table `location_dimension`
--
DROP TABLE IF EXISTS location_dimension;
CREATE TABLE location_dimension (
  location_id 	int(11) 		NOT NULL,
  morada 		varchar(255) 	NOT NULL,
  codigo_espaco varchar(255) 	NOT NULL,
  codigo_posto 	varchar(255)
);
--
-- Dumping data for table `location_dimension`
--
SET @count:=0;
INSERT INTO location_dimension
	SELECT  @count:=@count+1 AS location_id,
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
	user_id 	int(11) 		NOT NULL,
	nif 		varchar(9) 		NOT NULL,
    nome 		varchar(80) 	NOT NULL,
    telefone 	varchar(26) 	NOT NULL
);
--
-- Dumping data for table `user_dimension`
--
SET @count=0;
INSERT INTO user_dimension
	SELECT @count:=@count+1 AS user_id, nif, nome, telefone FROM user
;
--
-- Table structure for table `date_dimension`
--
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  date_id 	int(11) 		NOT NULL,
  mes 		varchar(9) 		NOT NULL,
  dia 		int(11) 		NOT NULL
);
--
-- Dumping data for table `date_dimension`
--
DELIMITER //
CREATE PROCEDURE createdatedimension()
BEGIN
SET @dia:=0;
SET @count:=0;
dias:	WHILE @dia<31 DO
		SET @mes:=0;
		meses:	WHILE @mes<12 DO
				INSERT INTO date_dimension VALUES (@count, @mes, @dia);
				SET @count:=@count+1;
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
  time_id 	int(11) 	NOT NULL,
  hora 		int(11) 	NOT NULL,
  minuto 	int(11) 	NOT NULL
);
--
-- Dumping data for table `time_dimension`
--
DELIMITER //
CREATE PROCEDURE createtimedimension()
BEGIN
SET @hora:=0;
SET @count:=0;
WHILE @hora < 24 DO
	SET @minuto:=0;
	WHILE @minuto < 60 DO
		INSERT INTO time_dimension VALUES (@count, @hora, @minuto);
		SET @count:=@count+1;
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
  location_id 	int(11) 		NOT NULL,
  user_id 		int(11) 		NOT NULL,
  date_id 		int(11) 		NOT NULL,
  time_id 		int(11) 		NOT NULL,
  montante 		varchar(255) 	NOT NULL,
  duracao		varchar(255) 	NOT NULL
);
