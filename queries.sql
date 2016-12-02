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
SELECT morada, codigo_espaco, pago
FROM
(SELECT morada, codigo_espaco, sum((datediff(data_fim, data_inicio))*tarifa) as pago
FROM oferta NATURAL JOIN aluga NATURAL JOIN paga NATURAL JOIN posto
WHERE (data between '2016-01-01 00:00:01' and '2016-12-31 23:59:59')
GROUP BY codigo_espaco, morada) as temp
UNION
(SELECT morada, codigo as codigo_espaco, sum((datediff(data_fim, data_inicio))*tarifa) as pago
FROM oferta NATURAL JOIN aluga NATURAL JOIN paga NATURAL JOIN espaco
WHERE (data between '2016-01-01 00:00:01' and '2016-12-31 23:59:59')
GROUP BY codigo_espaco, morada);

-- e)
SELECT morada, codigo_espaco
FROM (SELECT morada, codigo_espaco, COUNT(codigo) as count
	FROM posto
	GROUP BY morada, codigo_espaco) as temp
	NATURAL JOIN
	(SELECT aceite.morada as morada, aceite.codigo_espaco as codigo_espaco, count(aceite.codigo) as count
	FROM (SELECT DISTINCT morada, codigo_espaco, codigo
		FROM posto NATURAL JOIN aluga NATURAL JOIN estado
		WHERE estado = 'aceite') AS aceite
GROUP BY morada, codigo_espaco) as total_aceite;

