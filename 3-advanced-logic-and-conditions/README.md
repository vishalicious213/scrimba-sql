# Advanced Logic and Conditions

[ANY](#any)

[ALL](#all)

[EXISTS](#exists)

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

## EXISTS
*look for single existing record within subquery*

```sql

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

