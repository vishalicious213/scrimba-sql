-- SELECT brand, model, color FROM cars
-- WHERE color LIKE '%red%'
-- AND brand != 'Ferrari'
-- AND sold = false;

-- SELECT brand, model, color FROM cars
-- WHERE color NOT IN ('red', 'blue', 'white')
-- AND brand NOT IN ('Aston Martin', 'Bentley', 'Jaguar')
-- AND sold = false;

-- SELECT brand, model, year, sold FROM cars
-- WHERE ((brand = 'Dodge' AND year BETWEEN 1960 AND 1969)
-- OR (brand = 'Ford' AND year BETWEEN 1970 AND 1979)
-- OR (brand = 'Triumph' AND year BETWEEN 1970 AND 1979))
-- AND sold = false;

-- this is a better version of the one above, using IN for Fort & Triumph
SELECT brand, model, year, sold FROM cars
WHERE ((brand = 'Dodge' AND year BETWEEN 1960 AND 1969)
OR (brand IN ('Ford', 'Triumph') AND year BETWEEN 1970 AND 1979))
AND sold = false;