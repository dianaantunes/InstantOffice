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

-- d)
SELECT 365 * SUM(tarifa) AS 'Montante total realizado' FROM alugavel NATURAL JOIN
	(SELECT * FROM oferta
	WHERE data_inicio LIKE '2016%') as temp;
