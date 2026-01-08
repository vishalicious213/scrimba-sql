-- INSERT INTO cars (
--     brand, model, year, price, color, condition, sold
-- ) VALUES (
--     'Ford', 'Escord RS2000', 1978, 39000, 'blue', 4, FALSE
-- ), (
--     'Aston Martin', 'V8 Vantage', 1977, 145000, 'dark green', 5, FALSE
-- );

-- INSERT INTO cars (
-- 	brand, model, year, price, color, condition, sold
-- ) VALUES (
-- 	'Chevrolet', 'Bel Air', 1955, 50000, 'purple', 5, FALSE
-- ), (
-- 	'Porsche', '944 Turbo', 1986, 48000, 'white', 4, FALSE
-- );

-- UPDATE cars SET
-- sold = TRUE
-- WHERE brand = 'Ford'
-- AND model = 'Escort RS2000';

UPDATE cars SET
condition = 5, 
price = 465000
WHERE id = 14;