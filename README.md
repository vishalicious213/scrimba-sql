# Scrimba Intro to SQL

- brand, model, year, price, color, condition, sold

## Commands used per lesson

### SELECT all

```sql
SELECT * FROM cars;
```

### Selecting columns

```sql
SELECT brand, model, price FROM cars;

SELECT brand, model, condition, year FROM cars;
```

### WHERE clause

```sql
SELECT brand, model, color, price FROM cars WHERE color = 'black';
```

### Numerical filtering

```sql
SELECT brand, model, condition, price FROM cars WHERE condition = 0;

SELECT brand, model, condition, price FROM cars WHERE price < 50000;

SELECT brand, model, condition, price FROM cars WHERE condition >= 3;
```

### Not equal

```sql
SELECT brand, model, year, price FROM cars WHERE year != 1965;

SELECT brand, model, year, price FROM cars WHERE year <> 1965;

SELECT brand, model, price, color FROM cars WHERE color != 'yellow';
-- *this will do an exact match for where color does not equal 'yellow'*
```

### NOT & LIKE

```sql
SELECT brand, model, color, year FROM cars WHERE color LIKE '%green%';
-- `%` is a global wildcard, so ANY letters/numbers plus specified text are included
-- in this case, its used before & after 'green' so light green & green-yellow both work

SELECT brand, model, color, year FROM cars WHERE color NOT LIKE '%green%';
-- NOT negates the LIKE, so its used to exclude results, not include them
-- in this case, anything with 'green' isn't included in the results

SELECT brand, model, color, year FROM cars WHERE model like 'DB_';
-- `_` is a wildcard for a single character, so a single letter/number plus specified text is included
```

### AND

```sql
SELECT brand, model, color, year FROM cars 
WHERE color NOT LIKE '%green%' 
AND model LIKE 'DB_';

SELECT brand, model, color, year FROM cars 
WHERE color NOT LIKE '%green%' 
AND model LIKE 'DB_' 
AND year > 1964;

SELECT brand, model, year, condition, price FROM cars 
WHERE condition >= 3 
AND year < 1970;

SELECT brand, model, year, condition, price FROM cars 
WHERE condition >= 3 
AND year < 1970 
AND price < 100000;
```

### BETWEEN

```sql
SELECT brand, model, year, price FROM cars 
WHERE year >= 1980 AND year <= 1989;

SELECT brand, model, year, price FROM cars 
WHERE year BETWEEN 1980 AND 1989;

SELECT brand, model, condition, color, price FROM cars 
WHERE price BETWEEN 20000 AND 60000 
AND condition BETWEEN 1 AND 3 
AND color LIKE '%red%';
```

### OR

```sql
SELECT brand, model, condition, price FROM cars 
WHERE price < 250000 OR brand = 'Porsche';

SELECT brand, model, condition, price FROM cars 
WHERE (price < 250000 OR brand = 'Porsche') AND condition > 3;

SELECT brand, model, color, year, price FROM cars 
WHERE color LIKE '%red%' OR year BETWEEN 1960 AND 1969;

SELECT brand, model, color, year, price, sold FROM cars 
WHERE (color LIKE '%red%' OR year BETWEEN 1960 AND 1969) 
AND sold = false;
```

### IN

```sql
SELECT brand, model, price, sold FROM cars 
WHERE brand IN ('Ford', 'Chevrolet', 'Ferrari') 
AND sold = false;

SELECT brand, model, condition, year FROM cars 
WHERE year in (1961, 1963, 1965, 1967, 1969) 
AND condition >= 3 
AND sold = false;
```