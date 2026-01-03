-- SELECT brand, model, color FROM cars
-- WHERE color LIKE '%red%'
-- AND brand != 'Ferrari'
-- AND sold = false;

SELECT brand, model, color FROM cars
WHERE color NOT IN ('red', 'blue', 'white')
AND brand NOT IN ('Aston Martin', 'Bentley', 'Jaguar')
AND sold = false;