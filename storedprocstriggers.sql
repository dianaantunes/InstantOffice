-- RI-1: Nao podem existir ofertas com datas sobrepostas

DELIMITER //
DROP TRIGGER IF exists overlapping_offers;
CREATE TRIGGER overlapping_offers
BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
	IF exists(SELECT * FROM oferta WHERE codigo = NEW.codigo AND morada = NEW.morada 
                    AND data_inicio > NEW.data_fim AND NEW.data_inicio > data_fim)
                    THEN call erro_overlapping_offers();
        END IF;
END //
DELIMITER ;

-- DROP TRIGGER if exists overlapping_offers
-- DELIMITER //
-- CREATE TRIGGER overlapping_offers
-- BEFORE INSERT ON oferta
-- FOR EACH ROW
-- BEGIN
-- begin 
-- 	DECLARE data_inicio DATE;
--     DECLARE data_fim DATE;

-- 	SET data_inicio = (select data_inicio from oferta where morada = new.morada AND codigo = new.codigo);

-- 	SET data_fim = (select data_fim from oferta where morada = new.morada AND codigo = new.codigo);

-- 	IF (new.data_inicio > data_inicio AND new.data_fim < data_fim)
-- 		OR (new.data_inicio<data_inicio AND new.data fim > data_inicio)
-- 		OR (new.data_inicio > data_inicio AND new.data_fim > data_fim )
-- 		THEN
-- 	CALL ERROR;
-- 	END IF;
-- END //
-- delimiter ;


-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do ultimo estado dessa reserva

DELIMITER //
DROP TRIGGER IF exists pay_date_check;
CREATE TRIGGER pay_date_check
BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
	IF exists(SELECT * FROM estado WHERE numero = NEW.numero AND time_stamp >= NEW.data)
                    THEN call erro_pay_date_check();
        END IF;
END //
DELIMITER ;