-- a)
SELECT morada, codigo FROM posto p
WHERE NOT EXISTS (SELECT a.morada FROM aluga a WHERE p.codigo = a.codigo);

-- b)
SELECT morada AS 'Numero de reservas superior a media' FROM aluga NATURAL JOIN reserva
GROUP BY morada
HAVING COUNT(morada) >= (
	SELECT AVG(temp.count) FROM (
		SELECT COUNT(morada) as count FROM aluga NATURAL JOIN reserva
		GROUP BY morada
		) as temp
);

--c)
SELECT nome
FROM utilizador NATURAL JOIN aluga NATURAL JOIN alugavel NATURAL JOIN fiscaliza
NATURAL JOIN fiscal
GROUP BY nome
HAVING COUNT(fiscal.id) < ALL (
	SELECT COUNT(fiscal.id) FROM fiscal
	GROUP BY nome
);

-- d)
SELECT 365 * SUM(tarifa) AS 'Montante total realizado'
FROM alugavel NATURAL JOIN
(SELECT * FROM oferta WHERE data_inicio < '2016-12-31' AND data_fim > '2016-01-01') as temp
GROUP BY morada, codigo;

-- e)
SELECT morada, codigo
FROM posto NATURAL JOIN aluga
GROUP BY morada
HAVING COUNT(morada) < ALL (
	SELECT codigo FROM posto AS p NATURAL JOIN aluga AS a
	WHERE p.codigo = a.codigo
	GROUP BY morada
);
