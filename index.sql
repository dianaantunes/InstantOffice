--
-- Explain commands used to simulate execution with and without indexes
--
-- 1

EXPLAIN
SELECT A.nif FROM
Arrenda A INNER JOIN Fiscaliza F ON A.morada = F.morada AND A.codigo = F.codigo
GROUP BY A.nif
HAVING COUNT(distinct F.id)=1;

EXPLAIN
SELECT A.nif
FROM Arrenda A USE index() INNER JOIN Fiscaliza F ON A.morada = F.morada AND A.codigo = F.codigo
GROUP BY A.nif
HAVING COUNT(distinct F.id)=1;

EXPLAIN
SELECT A.nif FROM
Arrenda A INNER JOIN Fiscaliza F USE index() ON A.morada = F.morada AND A.codigo = F.codigo
GROUP BY A.nif
HAVING COUNT(distinct F.id)=1;

EXPLAIN
SELECT A.nif FROM
Arrenda A USE index() INNER JOIN Fiscaliza F USE index() ON A.morada = F.morada AND A.codigo = F.codigo
GROUP BY A.nif
HAVING COUNT(distinct F.id)=1;

-- 2

EXPLAIN
SELECT distinct P.morada, P.codigo_espaco FROM
posto P WHERE (P.morada, P.codigo_espaco) NOT IN (
	SELECT P.morada, P.codigo_espaco FROM
	posto P NATURAL JOIN aluga A NATURAL JOIN  estado E
	WHERE  E.estado = "Aceite"
);

EXPLAIN
SELECT distinct P.morada, P.codigo_espaco FROM
posto P USE index() WHERE (P.morada, P.codigo_espaco) NOT IN (
	SELECT P.morada, P.codigo_espaco FROM
	posto P NATURAL JOIN aluga A NATURAL JOIN  estado E
	WHERE  E.estado = "Aceite"
);

EXPLAIN
SELECT distinct P.morada, P.codigo_espaco FROM
posto P WHERE (P.morada, P.codigo_espaco) NOT IN (
	SELECT P.morada, P.codigo_espaco FROM
	posto P USE index() NATURAL JOIN aluga A USE index() NATURAL JOIN estado E USE index()
	WHERE  E.estado = "Aceite"
);

EXPLAIN
SELECT distinct P.morada, P.codigo_espaco FROM
posto P USE index() WHERE (P.morada, P.codigo_espaco) NOT IN (
	SELECT P.morada, P.codigo_espaco FROM
	posto P USE index() NATURAL JOIN aluga A USE index() NATURAL JOIN estado E USE index()
	WHERE  E.estado = "Aceite"
);