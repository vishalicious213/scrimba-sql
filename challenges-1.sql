SELECT brand, model, color FROM cars
WHERE color LIKE '%red%'
AND brand != 'Ferrari'
AND sold = false;