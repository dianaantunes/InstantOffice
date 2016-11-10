-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do último estado dessa reserva

DELIMITER //
CREATE TRIGGER pay_date_check
BEFORE UPDATE ON paga
FOR EACH ROW
BEGIN
	-- NESTED LOOP?
	IF NEW.data < ANY (SELECT timestamp FROM
					estado
					WHERE estado.numero = new.numero)
	THEN insert into paga values (new.numero, CURRENT_DATE, new.metodo);
	END IF;
END //
delimiter ;
