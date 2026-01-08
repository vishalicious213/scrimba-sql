# Scrimba Intro to SQL

[__SELECTING COLUMNS__](#selecting-columns)

- SELECT all
- Selecting specific columns

[__FILTERING RESULTS__](#filtering-results)

- WHERE clause
- Numerical filtering
- Not equal
- NOT & LIKE
- AND
- BETWEEN
- OR
- IN

[__ORDERING, SORTING & LIMITING RESULTS__](#ordering-sorting--limiting-results)

- ORDER BY, DESC
- LIMIT

[__AGGREGATING RESULTS__](#aggregating-results)

- COUNT & SUM
- MAX, MIN & AVG
- FLOOR & CEILING
- GROUP BY
- HAVING

[__MANIPULATING DATA__](#manipulating-data)

- INSERT INTO
- UPDATE
- DELETE

## Selecting columns

### SELECT all

```sql
SELECT * FROM cars;
```

### Selecting specific columns

```sql
SELECT brand, model, price FROM cars;

SELECT brand, model, condition, year FROM cars;
```

## Filtering results

### WHERE clause
*like equals in other languages*

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
*use LIKE to find a match, % to include __any__ text & _ to include 1 character*

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

SELECT brand, model, color FROM cars
WHERE color LIKE '%red%'
AND brand != 'Ferrari'
AND sold = false;

SELECT brand, model, color FROM cars
WHERE color NOT IN ('red', 'blue', 'white')
AND brand NOT IN ('Aston Martin', 'Bentley', 'Jaguar')
AND sold = false;
```

### BETWEEN
*use to specify a range, separate with AND*

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
WHERE (price < 250000 OR brand = 'Porsche') 
AND condition > 3;

SELECT brand, model, color, year, price FROM cars 
WHERE color LIKE '%red%' OR year BETWEEN 1960 AND 1969;

SELECT brand, model, color, year, price, sold FROM cars 
WHERE (color LIKE '%red%' OR year BETWEEN 1960 AND 1969) 
AND sold = false;

SELECT brand, model, year, sold FROM cars
WHERE ((brand = 'Dodge' AND year BETWEEN 1960 AND 1969)
OR (brand = 'Ford' AND year BETWEEN 1970 AND 1979)
OR (brand = 'Triumph' AND year BETWEEN 1970 AND 1979))
AND sold = false;
```

### IN
*Use like an array to only include/exclude those values*

```sql
SELECT brand, model, price, sold FROM cars 
WHERE brand IN ('Ford', 'Chevrolet', 'Ferrari') 
AND sold = false;

SELECT brand, model, condition, year FROM cars 
WHERE year in (1961, 1963, 1965, 1967, 1969) 
AND condition >= 3 
AND sold = false;

SELECT brand, model, price, sold FROM cars
WHERE sold = false
AND (brand NOT IN ('Ford', 'Triumph', 'Chevrolet', 'Dodge') OR price < 50000);

SELECT brand, model, year, sold FROM cars
WHERE ((brand = 'Dodge' AND year BETWEEN 1960 AND 1969)
OR (brand IN ('Ford', 'Triumph') AND year BETWEEN 1970 AND 1979))
AND sold = false;
```

## Ordering, Sorting & Limiting results

### ORDER BY, DESC
*DESC is descending (biggest to smallest), ASC is default/ascending*

```sql
SELECT brand, model, year FROM cars
ORDER BY brand;

SELECT brand, model, year FROM cars
ORDER BY brand DESC;

SELECT brand, model, year FROM cars
ORDER BY brand DESC, year;

SELECT brand, model, condition, price FROM cars
ORDER BY condition DESC, price;

SELECT brand, model, condition, price FROM cars
WHERE sold = false -- note we didn't select this column
ORDER BY condition DESC, price;

SELECT brand, model, condition, price FROM cars
WHERE sold IS FALSE
AND condition != 5
ORDER BY condition DESC, price;
```

### LIMIT
*limits the number of rows returned from a query*

```sql
SELECT brand, model, color, price FROM cars
WHERE color LIKE '%red%'
AND sold = false
ORDER BY price
LIMIT 5;
```

## Aggregating results

### COUNT & SUM
*returns the count of a column or the sum of a column's values*

```sql
SELECT COUNT(*) FROM cars -- COUNT returns a single value from our query
WHERE sold = TRUE;

SELECT COUNT(*) AS totel_sold FROM cars -- AS lets us rename a column in our output
WHERE sold = TRUE;

SELECT SUM(price) AS total_earnings FROM cars -- adds the values in the named column
WHERE sold = TRUE;
```

### MAX, MIN & AVG
- *finds the maximum, minimum & average value of a column*
- *looks like selecting a single value, but its selecting a column & reducing to 1 value*

```sql
SELECT MAX(price) AS most_expensive FROM cars
WHERE sold = TRUE;

SELECT AVG(price) FROM cars
WHERE brand = 'Bentley';
```

### FLOOR & CEILING
- *use these to round down/up results for readability (remove long decimals)*
- *CEIL & CEILING are interchangeable, CEILING is universal, CEIL is supported in most SQL implementations*

```SQL
SELECT FLOOR(AVG(price)) FROM cars
WHERE brand = 'Bentley';

SELECT CEILING(AVG(price)) FROM cars
WHERE brand = 'Bentley';

SELECT FLOOR(AVG(price)) AS average FROM cars
WHERE brand = 'Bentley';

SELECT CEILING(AVG(price)) AS avg, MIN(price), MAX(price) FROM cars
WHERE sold = true;
```

### GROUP BY
*group results into sets*

```sql
SELECT brand, COUNT(brand) AS brand_count FROM cars -- select by brand & get each one's count
GROUP BY brand; -- return the count for each specific brand, not total overall count

SELECT condition, COUNT(condition) FROM cars
GROUP BY condition;

SELECT brand, COUNT(brand), FLOOR(AVG(price)) as AVG FROM cars
WHERE sold = false -- added a WHERE clause
GROUP BY brand;
```

### HAVING
- *used to write conditions with aggregations using an aggregrate column*
- *follow this order: WHERE, GROUP BY, HAVING, ORDER BY*

```sql
SELECT brand, COUNT(brand), FLOOR(AVG(price)) as AVG FROM cars
WHERE sold = false
GROUP BY brand
HAVING COUNT(brand) > 1; -- like a WHERE clause, brands with only 1 car aren't counted

SELECT year, COUNT(year) AS car_count, MAX(price), MIN(price) FROM cars
WHERE sold = true
GROUP BY year
HAVING count(year) > 1
ORDER BY car_count;

SELECT color, COUNT(color) FROM cars
WHERE sold = FALSE 
GROUP BY color
HAVING COUNT(color) > 2
ORDER BY COUNT(color) DESC;
```

## Manipulating Data

### INSERT INTO
- *the C in CRUD, `CREATE`, adds data to the db*
- *select the table & the columns that will have data inserted (brand, model, year...)*
- *insert the data in the same order as the specified columns using the VALUES keyword*
- *separate rows of data with a comma (the Ford, the Aston Martin, etc.)*

```sql
INSERT INTO cars (
    brand, model, year, price, color, condition, sold
) VALUES (
    'Ford', 'Escord RS2000', 1978, 39000, 'blue', 4, FALSE
), (
    'Aston Martin', 'V8 Vantage', 1977, 145000, 'dark green', 5, FALSE
);

INSERT INTO cars (
	brand, model, year, price, color, condition, sold
) VALUES (
	'Chevrolet', 'Bel Air', 1955, 50000, 'purple', 5, FALSE
), (
	'Porsche', '944 Turbo', 1986, 48000, 'white', 4, FALSE
);
```

### UPDATE
- *the U in CRUD, `UPDATE`, overwrites data to the db*
- *select the table that will have data inserted*
- *specify each column & new value, separate columns with commas*
- *add a filtering value if needed, like the WHERE clause with an ID to find the right row*

```sql
UPDATE cars SET
sold = TRUE
WHERE brand = 'Ford'
AND model = 'Escort RS2000'; -- there was only one Ford Escord RS2000

UPDATE cars SET
condition = 5, 
price = 465000
WHERE id = 14; -- there were 2 Aston Martin DB4's so we used the ID to be specific

UPDATE cars SET
condition = 1,
price = 10000
WHERE brand = 'Porsche' AND sold = FALSE; -- updates all Porsches
```