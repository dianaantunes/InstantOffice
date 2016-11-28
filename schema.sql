-- Projeto 3

drop table estado cascade;
drop table paga cascade;
drop table aluga cascade;
drop table oferta cascade;
drop table posto cascade;
drop table espaco cascade;
drop table fiscaliza cascade;
drop table arrenda cascade;
drop table alugavel cascade;
drop table edificio cascade;
drop table fiscal cascade;
drop table utilizador cascade;
drop table reserva cascade;

create table reserva
	(numero 	integer		unique,
	primary key(numero));

create table utilizador
	(nif 		numeric(9,0)	unique,
	nome 		varchar(255),
 	telefone 	numeric(9,0),
 	primary key(nif));

create table fiscal
	(id		integer		unique,
	empresa	varchar(255),
 	primary key(id));

create table edificio
   (morada 	varchar(255)	unique,
    primary key(morada));

create table alugavel
   (morada 	varchar(255),
    codigo 	integer,
    foto 	varchar(255),
    primary key(morada, codigo),
	foreign key(morada) references edificio(morada));

create table arrenda
	(morada	varchar(255),
	codigo	integer,
	nif 	numeric(9,0),
	primary key(morada, codigo),
	foreign key(morada, codigo) references alugavel(morada, codigo),
	foreign key(nif) 			references utilizador(nif)
);

create table fiscaliza
	(id		integer,
	morada	varchar(255),
	codigo	integer,
	primary key(id, morada, codigo),
	foreign key(morada, codigo) references arrenda(morada, codigo),
	foreign key(id) 	 		references fiscal(id));

create table espaco
   (morada 	varchar(255),
    codigo 	integer,
    primary key(morada, codigo),
	foreign key(morada, codigo) references alugavel(morada, codigo));

create table posto
   (morada 			varchar(255),
    codigo 			integer,
    codigo_espaco 	integer,
    primary key(morada, codigo),
	foreign key(morada, codigo) 		references alugavel(morada, codigo),
	foreign key(morada, codigo_espaco) 	references espaco(morada, codigo));

create table oferta
	(morada 	varchar(255),
    codigo 		integer,
    data_inicio date,
	data_fim 	date,
	tarifa 		numeric(12,2),
    primary key(morada, codigo, data_inicio),
 	foreign key(morada, codigo) references alugavel(morada, codigo));

create table aluga
	(morada 	varchar(255),
	codigo 		integer,
	data_inicio date,
	nif 		numeric(9,0),
	numero 		integer,
	primary key(morada, codigo, data_inicio, nif, numero),
	foreign key(morada, codigo, data_inicio) 	references oferta(morada, codigo, data_inicio),
	foreign key(nif) 							references utilizador(nif),
	foreign key(numero) 						references reserva(numero));

create table paga
	(numero integer,
	data 	date,
	metodo 	varchar(255),
	primary key(numero),
	foreign key(numero) references reserva(numero));

create table estado
	(numero 	integer,
	timestamp 	date,
	estado 		varchar(255),
	primary key(numero, timestamp),
	foreign key(numero) references reserva(numero));
