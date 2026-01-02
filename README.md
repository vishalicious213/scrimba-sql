# Scrimba Intro to SQL

- brand, model, year, price, color, condition, sold

## Commands used per lesson

### SELECT all

- SELECT * FROM cars;

### Selecting columns

- SELECT brand, model, price FROM cars;
- SELECT brand, model, condition, year FROM cars;

### WHERE clause

- SELECT brand, model, color, price FROM cars WHERE color = 'black';

### Numerical filtering

- SELECT brand, model, condition, price FROM cars WHERE condition = 0;
- SELECT brand, model, condition, price FROM cars WHERE price < 50000;
- SELECT brand, model, condition, price FROM cars WHERE condition >= 3;

### Not equal

- SELECT brand, model, year, price FROM cars WHERE year != 1965;
- SELECT brand, model, year, price FROM cars WHERE year <> 1965;
- SELECT brand, model, price, color FROM cars WHERE color != 'yellow';
  - *this will do an exact match for where color does not equal 'yellow'*

### NOT & LIKE

- SELECT brand, model, color, year FROM cars WHERE color LIKE '%green%';
  - *`%` is a global wildcard, so ANY letters/numbers plus specified text are included*
  - *in this case, its used before & after 'green' so light green & green-yellow both work*
- SELECT brand, model, color, year FROM cars WHERE color NOT LIKE '%green%';
  - *NOT negates the LIKE, so its used to exclude results, not include them*
  - *in this case, anything with 'green' isn't included in the results*
- SELECT brand, model, color, year FROM cars WHERE model like 'DB_';
  - *`_` is a wildcard for a single character, so a single letter/number plus specified text is included*

### AND

- SELECT brand, model, color, year FROM cars WHERE color NOT LIKE '%green%' AND model LIKE 'DB_';
- SELECT brand, model, color, year FROM cars WHERE color NOT LIKE '%green%' AND model LIKE 'DB_' AND year > 1964;
- SELECT brand, model, year, condition, price FROM cars WHERE condition >= 3 AND year < 1970;
- SELECT brand, model, year, condition, price FROM cars WHERE condition >= 3 AND year < 1970 AND price < 100000;

### BETWEEN

- SELECT brand, model, year, price FROM cars WHERE year >= 1980 AND year <= 1989;
- SELECT brand, model, year, price FROM cars WHERE year BETWEEN 1980 AND 1989;
- SELECT brand, model, condition, color, price FROM cars WHERE price BETWEEN 20000 AND 60000 AND condition BETWEEN 1 AND 3 AND color LIKE '%red%';

### OR

- SELECT brand, model, condition, price FROM cars WHERE price < 250000 OR brand = 'Porsche';
- SELECT brand, model, condition, price FROM cars WHERE (price < 250000 OR brand = 'Porsche') AND condition > 3;