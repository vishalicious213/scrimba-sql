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

SELECT brand, model, price, color FROM cars
WHERE color != 'yellow';