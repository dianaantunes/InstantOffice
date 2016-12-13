--
-- Table structure for table `location_dimension`
--
DROP TABLE IF EXISTS location_dimension;
CREATE TABLE location_dimension (
  location_id 	int(11) 		NOT NULL,
  morada 		varchar(255) 	NOT NULL,
  codigo_espaco integer 		NOT NULL,
  codigo_posto 	integer 		NOT NULL,
);
--
-- Dumping data for table `location_dimension`
--
LOCK TABLES location_dimension WRITE;
INSERT INTO location_dimension VALUES (
	SELECT morada, codigo_espaco, codigo FROM
	espaco NATURAL JOIN posto
);
UNLOCK TABLES;
--
-- Table structure for table `user_dimension`
--
DROP TABLE IF EXISTS user_dimension;
CREATE TABLE user_dimension (
	user_id 	int(11) 		NOT NULL,
	nif 		varchar(9) 		NOT NULL,
    nome 		varchar(80) 	NOT NULL,
    telefone 	varchar(26) 	NOT NULL,
);
--
-- Dumping data for table `user_dimension`
--
LOCK TABLES user_dimension WRITE;
INSERT INTO user_dimension VALUES (
	SELECT * FROM user
);
UNLOCK TABLES;
--
-- Table structure for table `date_dimension`
--
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  date_id 	int(11) 		NOT NULL,
  mes 		varchar(9) 		NOT NULL,
  dia 		int(11) 		NOT NULL,
);
--
-- Dumping data for table `date_dimension`
--
LOCK TABLES date_dimension WRITE;
INSERT INTO date_dimension VALUES ();
UNLOCK TABLES;
--
-- Table structure for table `time_dimension`
--
DROP TABLE IF EXISTS time_dimension;
CREATE TABLE time_dimension (
  time_id 	int(11) 	NOT NULL,
  hora 		int(11) 	NOT NULL,
  minuto 	int(11) 	NOT NULL,
);
--
-- Dumping data for table `time_dimension`
--
LOCK TABLES time_dimension WRITE;
INSERT INTO time_dimension VALUES ();
UNLOCK TABLES;