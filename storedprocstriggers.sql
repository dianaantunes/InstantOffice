-- RI-1: Nao podem existir ofertas com datas sobrepostas

DROP TRIGGER if exists overlapping_offers
DELIMITER //
CREATE TRIGGER overlapping_offers
BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
     set @data_inicio = (SELECT new.data_inicio);
     set @data_fim = (SELECT new.data_fom);
     set @mensagem = concat('A reserva com data de inicio ', @data_inicio, 'e com a data fim ', @data_fim, 'ja existe.');

IF NEW.codigo == (SELECT codigo FROM oferta ) then 
IF NEW.data_inicio < (SELECT data_fim FROM oferta) AND
NEW.data_fim > (SELECT data_inicio FROM oferta) then
call error;
END IF;
END //
delimiter ;


-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do último estado dessa reserva

DELIMITER //
CREATE TRIGGER pay_date_check
BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
	IF NEW.data < ANY (SELECT timestamp FROM
					estado
					WHERE estado.numero = new.numero)
	THEN signal sqlstate '45000' set message_text = 'A data de pagamento de uma reserva paga tem de ser superior ao timestamp do ultimo estado dessa reserva';
	END IF;
END //
delimiter ;