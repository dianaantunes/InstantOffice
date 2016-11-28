/* populate relations */
insert into reserva values (1);
insert into reserva values (2);
insert into reserva values (3);
insert into reserva values (4);
insert into reserva values (5);
insert into reserva values (6);
insert into reserva values (7);
insert into reserva values (8);
insert into reserva values (9);
insert into reserva values (10);
insert into reserva values (11);
insert into reserva values (12);
insert into reserva values (13);
insert into reserva values (14);
insert into reserva values (15);
insert into reserva values (16);
insert into reserva values (17);
insert into reserva values (18);
insert into reserva values (19);
insert into reserva values (20);

insert into utilizador		values (242597877, 'Eduardo Janicas', 966288240);
insert into utilizador		values (242597878, 'Diana Antunes', 911765387);
insert into utilizador		values (242597879, 'Nuno Fernandes', 922988654);

insert into fiscal 		values (502787015, 'QSO Consultores');
insert into fiscal 		values (502787016, 'Unbabel');

insert into edificio	values ('Av. da Liberdade');
insert into edificio	values ('Av. Egas Moniz');
insert into edificio	values ('Rua Dr. Alberto');
insert into edificio	values ('Rua Alves Redol');
insert into edificio	values ('Av. da Republica');
insert into edificio	values ('Alameda D. Afonso');
insert into edificio	values ('Bairro da Atalaia');

insert into alugavel	values ('Av. da Liberdade',	001, 'Foto do alugavel1');
insert into alugavel	values ('Av. da Liberdade',	002, 'Foto do alugavel2');
insert into alugavel	values ('Av. da Liberdade',	003, 'Foto do alugavel3');
insert into alugavel	values ('Av. Egas Moniz',	004, 'Foto do alugavel4');
insert into alugavel	values ('Av. Egas Moniz',	005, 'Foto do alugavel5');
insert into alugavel	values ('Rua Dr. Alberto',	006, 'Foto do alugavel6');
insert into alugavel	values ('Rua Alves Redol',	007, 'Foto do alugavel7');
insert into alugavel	values ('Av. da Republica',	008, 'Foto do alugavel8');
insert into alugavel	values ('Alameda D. Afonso',009, 'Foto do alugavel9');

insert into arrenda 	values ('Av. Egas Moniz', 004, 242597877);
insert into arrenda 	values ('Rua Alves Redol', 007, 242597879);

insert into fiscaliza 	values (502787015, 'Av. Egas Moniz', 004);
insert into fiscaliza 	values (502787016, 'Rua Alves Redol', 007);

insert into espaco	values ('Av. da Liberdade',		001);
insert into espaco	values ('Av. Egas Moniz',		004);
insert into espaco	values ('Rua Dr. Alberto',		006);
insert into espaco	values ('Rua Alves Redol',		007);
insert into espaco	values ('Av. da Republica',		008);
insert into espaco	values ('Alameda D. Afonso',	009);

insert into posto	values ('Av. da Liberdade',		002, 001);
insert into posto	values ('Av. da Liberdade',		003, 001);
insert into posto	values ('Av. Egas Moniz',		005, 004);

insert into oferta	values ('Av. da Liberdade',		002, '2010-01-01', '2015-01-01', 200);
insert into oferta	values ('Av. da Liberdade',		002, '2015-01-01', '2020-01-01', 200);
insert into oferta	values ('Av. da Liberdade',		003, '2010-01-01', '2015-01-01', 400);
insert into oferta	values ('Rua Dr. Alberto',		006, '2011-01-01', '2016-01-01', 300);
insert into oferta	values ('Rua Alves Redol',		007, '2011-06-01', '2016-06-01', 300);
insert into oferta	values ('Av. da Republica',		008, '2015-07-01', '2020-07-01', 500);
insert into oferta	values ('Alameda D. Afonso',	009, '2016-01-01', '2021-01-01', 600);

insert into aluga values ('Rua Alves Redol', 007, '2011-06-01', 242597878, 1);
insert into aluga values ('Av. da Liberdade', 002, '2010-01-01', 242597878, 2);
insert into aluga values ('Av. da Liberdade', 002, '2015-01-01', 242597878, 3);

insert into paga values (1, '2011-06-01', 'VISA');

insert into estado values (1, '2011-06-01', 'paga');
insert into estado values (2, '2011-01-01', 'pendente');
