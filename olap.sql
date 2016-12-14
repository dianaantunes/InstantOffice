--
-- Table structure for table `location_dimension`
--
DROP TABLE IF EXISTS location_dimension;
CREATE TABLE location_dimension (
  location_id 	int(11) 	NOT NULL,
  morada 		varchar(255) 	NOT NULL,
  codigo_espaco varchar(255) 	NOT NULL,
  codigo_posto 	varchar(255)
);
--
-- Dumping data for table `location_dimension`
--
SET @count = 0;
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
	user_id		varchar(9) 		NOT NULL,
  nif		varchar(9) 		NOT NULL,
  nome 		varchar(80) 	NOT NULL,
  telefone 	varchar(26) 	NOT NULL
);
--
-- Dumping data for table `user_dimension`
--
SET @count = 0;
INSERT INTO user_dimension
	SELECT @count:=@count+1 AS user_id, nif, nome, telefone FROM user
;
--
-- Table structure for table `date_dimension`
--
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  date_id 	           int(11) 		NOT NULL,
  date_year      	 int(11) 		NOT NULL,
  date_semester      	 int(11) 		NOT NULL,
  date_month_number 	 int(11) 		NOT NULL,
  date_week 	         int(11) 		NOT NULL,
  date_day 		         int(11) 		NOT NULL
);
--
-- Dumping data for table `date_dimension`
--
DELIMITER //
DROP PROCEDURE IF EXISTS createdatedimension;
CREATE PROCEDURE createdatedimension()
BEGIN
   DECLARE v_full_date DATETIME;
   SET v_full_date = '2016-01-01 00:00:00';
   WHILE v_full_date < '2018-01-01 00:00:00' DO
       INSERT INTO date_dimension(
          date_id,
          date_year,
          date_semester,
          date_month_number,
          date_week,
          date_day
       ) VALUES (
           YEAR(v_full_date) * 10000 + MONTH(v_full_date)*100 + DAY(v_full_date),
           YEAR(v_full_date),
           CEIL(QUARTER(v_full_date) / 2),
           MONTH(v_full_date),
           WEEKOFYEAR(v_full_date),
           DAY(v_full_date)
       );
       SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 DAY);
   END WHILE;
END;
//
DELIMITER ;
CALL createdatedimension();
--
-- Table structure for table `time_dimension`
--
DROP TABLE IF EXISTS time_dimension;
CREATE TABLE time_dimension (
  time_id 	    int(11) 	NOT NULL,
  time_hour 		int(11) 	NOT NULL,
  time_minute 	int(11) 	NOT NULL
);
--
-- Dumping data for table `time_dimension`
--
DROP PROCEDURE IF EXISTS createtimedimension;
DELIMITER //
CREATE PROCEDURE createtimedimension()
BEGIN
   DECLARE v_full_date DATETIME;
   SET v_full_date = '2016-01-01 00:00:00';
   WHILE v_full_date <= '2016-01-01 23:59:59' DO
       INSERT INTO time_dimension(
          time_id,
          time_hour,
          time_minute
       ) VALUES (
           HOUR(v_full_date)*100 + MINUTE(v_full_date),
           HOUR(v_full_date),
           MINUTE(v_full_date)
       );
       SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 MINUTE);
   END WHILE;
END;
//
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
	SELECT location_id,
		  user_id,
			YEAR(data) * 10000 + MONTH(data)*100 + DAY(data) AS date_id,
			HOUR(data)*100 + MINUTE(data) AS time_id,
			datediff(data_fim, data_inicio)*tarifa as montante,
			datediff(data_fim, data_inicio) as duracao
	FROM reserva NATURAL JOIN aluga NATURAL JOIN oferta NATURAL JOIN paga
      INNER JOIN location_dimension ON
      aluga.morada = location_dimension.morada AND
      (aluga.codigo = location_dimension.codigo_posto OR
      aluga.codigo = location_dimension.codigo_espaco)
      INNER JOIN user_dimension ON
      aluga.nif = user_dimension.nif
;
