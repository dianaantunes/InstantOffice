SELECT codigo_espaco, codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY codigo_espaco, codigo_posto, date_month_number, date_day WITH ROLLUP
   UNION
   SELECT codigo_espaco, codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY codigo_posto, date_month_number, date_day, codigo_espaco WITH ROLLUP
   UNION
   SELECT codigo_espaco, codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY date_month_number, date_day, codigo_espaco, codigo_posto WITH ROLLUP
   UNION
   SELECT codigo_espaco, codigo_posto, date_month_number, date_day, AVG(montante) as average
   FROM reservasolap NATURAL JOIN location_dimension NATURAL JOIN date_dimension
   GROUP BY date_day, codigo_espaco, codigo_posto, date_month_number WITH ROLLUP;
