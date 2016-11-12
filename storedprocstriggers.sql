-- RI-2: A data de pagamento de uma reserva paga tem de ser superior ao timestamp do último estado dessa reserva

DELIMITER //
CREATE TRIGGER pay_date_check
BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
	IF NEW.data < ANY (SELECT timestamp FROM
					estado
					WHERE estado.numero = new.numero)
	THEN SET NEW.data = CURRENT_DATE; -- Caso contrario coloca a data atual
	END IF;
END //
delimiter ;