SELECT location_codigo_espaco, location_codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY location_codigo_espaco, location_codigo_posto, date_month_number, date_day WITH ROLLUP
UNION
SELECT location_codigo_espaco, location_codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY location_codigo_posto, date_month_number, date_day, location_codigo_espaco WITH ROLLUP
UNION
SELECT location_codigo_espaco, location_codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY date_month_number, date_day, location_codigo_espaco, location_codigo_posto WITH ROLLUP
UNION
SELECT location_codigo_espaco, location_codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY date_day, location_codigo_espaco, location_codigo_posto, date_month_number WITH ROLLUP;
