-- a)
SELECT DISTINCT morada, codigo_espaco FROM posto p
WHERE NOT EXISTS (SELECT morada FROM aluga a WHERE p.codigo = a.codigo);

-- b)
SELECT morada FROM aluga NATURAL JOIN reserva
GROUP BY morada
HAVING COUNT(morada) >= (
	SELECT AVG(temp.count) FROM (
		SELECT COUNT(morada) as count FROM aluga NATURAL JOIN reserva
		GROUP BY morada
		) as temp
);

--c)
SELECT nome
FROM user
NATURAL JOIN(
  SELECT nif FROM aluga NATURAL JOIN fiscaliza
  GROUP BY nif
  HAVING COUNT(DISTINCT id) = 1
) AS temp;

-- d)
SELECT dias * SUM(tarifa) AS 'Total'
FROM alugavel NATURAL JOIN
(SELECT DATEDIFF(data_inicio,data_fim) AS dias, morada, codigo, tarifa FROM oferta WHERE data_inicio < '2016-12-31' AND data_fim > '2016-01-01') as temp
GROUP BY morada, codigo;

-- e)
SELECT DISTINCT morada, codigo_espaco
FROM posto
NATURAL JOIN(
	SELECT numero, estado FROM aluga NATURAL JOIN estado
	GROUP BY numero
	HAVING estado = 'aceite'
) AS temp;

