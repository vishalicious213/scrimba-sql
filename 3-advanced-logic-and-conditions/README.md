# Advanced Logic and Conditions

[ANY](#any)

[ALL](#all)

[EXISTS](#exists)

- DISTINCT
- NOT

[CASE IN SELECT](#case-in-select)

[CASE IN WHERE](#case-in-where)

[CASE IN UPDATE](#case-in-update)

## ANY
- *find a single match within a subquery*
- *if there's even a single match, return true*

```sql
SELECT brand, model, price FROM cars
  WHERE price > ANY ( -- find a single match
    SELECT SC.sold_price FROM sold_cars SC -- within this subquery
      JOIN staff S ON SC.seller = S.id
      WHERE S.name = 'Frankie Fender'
  ) AND sold IS FALSE; -- and with this condition

-- we often run the subquery alone to confirm what we're searching from
SELECT SC.sold_price FROM sold_cars SC
    JOIN staff S ON SC.seller = S.id
    WHERE S.name = 'Frankie Fender'
```

```sql
SELECT brand, model, price FROM cars
WHERE price < ANY (
  SELECT price FROM cars
  WHERE brand = 'Ford'
) AND brand = 'Volkswagen'
AND sold = FALSE;
```

```sql
SELECT S.name, SC.sold_price
  FROM staff S
  JOIN sold_cars SC ON S.id = SC.seller
WHERE SC.sold_price > ANY (
SELECT SUM(sold_price) FROM sold_cars
  GROUP BY seller
);
```

```sql
SELECT brand, model, price FROM cars 
  WHERE price > ANY (
    SELECT SUM(sold_price) FROM sold_cars
    JOIN staff ON staff.id = sold_cars.seller
      GROUP BY staff.dealership_id
  );
  ```

## ALL
*attach to subquery to find records where all in subquery match*

```sql
SELECT brand, model, condition, price
  FROM cars
WHERE price < ALL (
  SELECT price FROM cars
    WHERE condition = 3
);
```

```sql
SELECT brand, model, year FROM cars
WHERE year < ALL (
  SELECT year FROM cars
  WHERE brand = 'Ford'
)
ORDER BY year;
```

```sql
SELECT brand, model, city, price FROM cars
  JOIN dealerships ON dealership_id = dealerships.id
  WHERE price > ALL (
      SELECT sold_price FROM sold_cars
  )
ORDER BY city;
```

## EXISTS
- *look for single existing record within subquery*
- *returns true if subquery returns at least one row from db*

```sql
SELECT color FROM cars
  WHERE EXISTS (
    SELECT 1 FROM sold_cars WHERE cars_id = cars.id
  );
-- don't need to select a specific column, so long as SOMETHING
-- returns we know a record matches the condition
```

```sql
SELECT city, state, TO_CHAR(established, 'YYYY-MM-DD') AS est
  FROM dealerships D
  WHERE NOT EXISTS (
    SELECT 1 FROM cars WHERE dealership_id = D.id
  );
```

### DISTINCT
*use the DISTINCT keyword to only get unique values from the table*

```sql
SELECT DISTINCT color FROM cars
    WHERE EXISTS (
        SELECT 1 FROM sold_cars WHERE cars_id = cars.id
    )
    ORDER BY color; -- sorting/ordering
```

### Getting the opposite with NOT

```sql
SELECT DISTINCT color FROM cars
    WHERE NOT EXISTS (
        SELECT 1 FROM sold_cars WHERE cars_id = cars.id
    )
    ORDER BY color;
```

# CASE statements provide conditional logic like `if` statements

## CASE IN SELECT

```sql

```

## CASE IN WHERE

```sql

```

## CASE IN UPDATE

```sql

```

