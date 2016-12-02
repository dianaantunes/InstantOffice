-- RI-1: Nao podem existir ofertas com datas sobrepostas

DELIMITER //
DROP TRIGGER IF exists overlapping_offers;
CREATE TRIGGER overlapping_offers
BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
	IF exists(SELECT * FROM oferta WHERE codigo = NEW.codigo AND morada = NEW.morada 
                    AND ((new.data_inicio >= data_inicio AND new.data_inicio <= data_fim)
						OR (new.data_fim >= data_inicio AND new.data_fim <= data_fim)
						OR (new.data_inicio <= data_inicio AND new.data_fim >= data_fim)))
                    THEN call erro_overlapping_offers();
        END IF;
END //
DELIMITER ;


-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do ultimo estado dessa reserva

DELIMITER //
DROP TRIGGER IF exists pay_date_check;
CREATE TRIGGER pay_date_check
BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
	IF exists(SELECT * FROM estado WHERE numero = NEW.numero AND NEW.data <= time_stamp)
                    THEN call erro_pay_date_check();
        END IF;
END //
DELIMITER ;