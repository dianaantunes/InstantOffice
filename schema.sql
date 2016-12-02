-- Projeto 3

drop table if exists estado;
drop table if exists paga;
drop table if exists aluga;
drop table if exists reserva;
drop table if exists oferta;
drop table if exists posto;
drop table if exists espaco;
drop table if exists fiscaliza;
drop table if exists arrenda;
drop table if exists alugavel;
drop table if exists edificio;
drop table if exists fiscal;
drop table if exists user;

create table reserva
	(numero 	integer	not null unique,
	primary key(numero));

create table user
	(nif 		numeric(9,0) not null unique,
	nome 		varchar(255) not null,
 	telefone 	numeric(9,0) not null,
 	primary key(nif));

create table fiscal
	(id		integer	not null unique,
	empresa	varchar(255) not null,
 	primary key(id));

create table edificio
   (morada 	varchar(255) not null unique,
    primary key(morada));

create table alugavel
   (morada 	varchar(255) not null,
    codigo 	integer not null,
    foto 	varchar(255) not null,
    primary key(morada, codigo),
	foreign key(morada) references edificio(morada));

create table arrenda
	(morada	varchar(255) not null,
	codigo	integer not null,
	nif 	numeric(9,0) not null,
	primary key(morada, codigo),
	foreign key(morada, codigo) references alugavel(morada, codigo),
	foreign key(nif) 			references utilizador(nif)
);

create table fiscaliza
	(id		integer not null,
	morada	varchar(255) not null,
	codigo	integer not null,
	primary key(id, morada, codigo),
	foreign key(morada, codigo) references arrenda(morada, codigo),
	foreign key(id) 	 		references fiscal(id));

create table espaco
   (morada 	varchar(255) not null,
    codigo 	integer not null,
    primary key(morada, codigo),
	foreign key(morada, codigo) references alugavel(morada, codigo));

create table posto
   (morada 			varchar(255) not null,
    codigo 			integer not null,
    codigo_espaco 	integer not null,
    primary key(morada, codigo),
	foreign key(morada, codigo) 		references alugavel(morada, codigo),
	foreign key(morada, codigo_espaco) 	references espaco(morada, codigo));

create table oferta
	(morada 	varchar(255) not null,
    codigo 		integer not null,
    data_inicio date not null,
	data_fim 	date not null,
	tarifa 		numeric(12,2) not null,
    primary key(morada, codigo, data_inicio),
 	foreign key(morada, codigo) references alugavel(morada, codigo));
 	constraint datas_diferentes UNIQUE (data_inicio, data_fim);

create table aluga
	(morada 	varchar(255) not null,
	codigo 		integer not null,
	data_inicio date not null,
	nif 		numeric(9,0) not null,
	numero 		integer not null,
	primary key(morada, codigo, data_inicio, nif, numero),
	foreign key(morada, codigo, data_inicio) 	references oferta(morada, codigo, data_inicio),
	foreign key(nif) 							references utilizador(nif),
	foreign key(numero) 						references reserva(numero));

create table paga
	(numero integer not null,
	data 	date not null,
	metodo 	varchar(255) not null,
	primary key(numero),
	foreign key(numero) references reserva(numero));

create table estado
	(numero 	integer not null,
	timestamp 	date not null,
	estado 		varchar(255) not null,
	primary key(numero, timestamp),
	foreign key(numero) references reserva(numero));
