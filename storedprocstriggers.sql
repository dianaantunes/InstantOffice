-- RI-1: Nao podem existir ofertas com datas sobrepostas

DROP TRIGGER if exists overlapping_offers
DELIMITER //
CREATE TRIGGER overlapping_offers
BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
begin 
	DECLARE data_inicio DATE;
    DECLARE data_fim DATE;

	SET data_inicio = (select data_inicio from oferta where morada = new.morada AND codigo = new.codigo);

	SET data_fim = (select data_fim from oferta where morada = new.morada AND codigo = new.codigo);

	IF (new.data_inicio > data_inicio AND new.data_fim < data_fim)
		OR (new.data_inicio<data_inicio AND new.data fim > data_inicio)
		OR (new.data_inicio > data_inicio AND new.data_fim > data_fim )
		THEN
	CALL ERROR;
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