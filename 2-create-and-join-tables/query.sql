-- SELECT id, brand, model FROM cars ORDER BY id;
-- SELECT * FROM dealerships;
-- SELECT * FROM staff
-- SELECT id, dealership_id, brand, model FROM cars;

SELECT brand, model, price, sold, sold_price 
  FROM sold_cars SC
  LEFT JOIN cars C ON SC.cars_id = C.id;