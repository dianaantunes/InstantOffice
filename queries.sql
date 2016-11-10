-- b)
SELECT morada FROM aluga NATURAL JOIN reserva
GROUP BY morada
HAVING COUNT(morada) >= (
	SELECT AVG(temp.count) FROM (
		SELECT COUNT(morada) as count FROM aluga NATURAL JOIN reserva
		GROUP BY morada
		) as temp
);

-- d)
SELECT 365 * SUM(tarifa) FROM alugavel NATURAL JOIN
	(SELECT * FROM oferta
	WHERE data_inicio LIKE '2016%') as temp;
