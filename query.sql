-- SELECT * FROM cars;

-- SELECT brand, model, price FROM cars;

-- SELECT brand, model, condition, year FROM cars;

-- SELECT brand, model, color, price FROM cars
-- WHERE color = 'black';

-- SELECT brand, model, condition, price FROM cars
-- WHERE condition = 0;

-- SELECT brand, model, condition, price FROM cars
-- WHERE price < 50000;

-- SELECT brand, model, condition, price FROM cars
-- WHERE condition >= 3;

-- SELECT brand, model, year, price FROM cars
-- WHERE year != 1965;

-- SELECT brand, model, year, price FROM cars
-- WHERE year <> 1965;

-- SELECT brand, model, price, color FROM cars
-- WHERE color != 'yellow';

-- SELECT brand, model, color, year FROM cars
-- WHERE color LIKE '%green%';

-- SELECT brand, model, color, year FROM cars
-- WHERE color NOT LIKE '%green%';

-- SELECT brand, model, color, year FROM cars
-- WHERE model like 'DB_';

-- SELECT brand, model, color, year FROM cars
-- WHERE color NOT LIKE '%green%'
-- AND model LIKE 'DB_';

-- SELECT brand, model, color, year FROM cars
-- WHERE color NOT LIKE '%green%'
-- AND model LIKE 'DB_'
-- AND year > 1964;

-- SELECT brand, model, year, condition, price FROM cars
-- WHERE condition >= 3 AND year < 1970;

-- SELECT brand, model, year, condition, price FROM cars
-- WHERE condition >= 3 AND year < 1970 AND price < 100000;

-- SELECT brand, model, year, price FROM cars
-- WHERE year >= 1980 AND year <= 1989;

-- SELECT brand, model, year, price FROM cars
-- WHERE year BETWEEN 1980 AND 1989;

SELECT brand, model, condition, color, price FROM cars
WHERE price BETWEEN 20000 AND 60000
AND condition BETWEEN 1 AND 3
AND color LIKE '%red%';