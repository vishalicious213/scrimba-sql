-- SELECT brand, model, year FROM cars
-- WHERE sold = FALSE
-- ORDER BY year
-- LIMIT 5;

SELECT color, COUNT(color) FROM cars
WHERE sold = FALSE 
GROUP BY color
HAVING COUNT(color) > 2
ORDER BY COUNT(color) DESC;