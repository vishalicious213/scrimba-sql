# Creating & Joining Tables

[CREATING TABLES](#creating-tables)

- CREATE TABLE IF NOT EXISTS

[POPULATING TABLES](#populating-tables)

- INSERT INTO & VALUES

[ALTER TABLE](#alter-table)

- ALTER TABLE, ADD COLUMN
- SET
- ALTER COLUMN
- ADD CONSTRAINT
- FOREIGN KEY

[JOINS](#joins)

- LEFT JOIN
- RIGHT JOIN
- DROP
- INNER JOIN
- FULL JOIN

[ALTER CONSTRAINTS](#alter-constraints)

## Creating tables

```sql
CREATE TABLE IF NOT EXISTS dealerships (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    state CHAR(2) NOT NULL,
    established DATE NOT NULL
)

CREATE TABLE IF NOT EXISTS staff (
    id SERIAL PRIMARY KEY,
    dealership_id INTEGER NOT NULL REFERENCES dealerships(id),
    name TEXT NOT NULL,
    role TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sold_cars (
  id SERIAL PRIMARY KEY,
  cars_id INTEGER NOT NULL REFERENCES cars(id),
  seller INTEGER NOT NULL REFERENCES staff(id),
  sold_date DATE NOT NULL,
  sold_price INTEGER NOT NULL
);
```

## Populating tables

```sql
INSERT INTO dealerships (city, state, established)
VALUES
    ('Chicago', 'IL', '2022-04-14'),
    ('Atlanta', 'GA', '2022-04-14'),
    ('Detroit', 'MI', '2025-05-01'),
    ('Philadelphia', 'PA', '2026-07-01');

INSERT INTO staff (dealership_id, name, role)
VALUES
    (1, 'Rodney Ride', 'CEO'),
    (1, 'Penny Piston', 'Accountant'),
    (1, 'Rhonda Rules', 'HR Officer'),
    (1, 'Nina Nitro', 'Salesperson'),
    (1, 'Frankie Fender', 'Salesperson'),
    (1, 'Mike Anic', 'Mechanic'),
    (1, 'Meg A Byte', 'Data Administrator');
```

## Alter table

```sql
-- 1. Add the column (initially nullable)
ALTER TABLE cars
ADD COLUMN dealership_id INTEGER;

-- 2. Insert data to backfill the dealership_id column
UPDATE cars SET
dealership_id = 1
WHERE dealership_id IS NULL;

-- 3. Add the NOT NULL constraint
ALTER TABLE cars
ALTER COLUMN dealership_id SET NOT NULL;

-- 4. Add the foreign key constraint
ALTER TABLE cars
ADD CONSTRAINT dealership_fk FOREIGN KEY (dealership_id) -- dealership_fk, fk = foreign key, we made up the name
REFERENCES dealerships(id);

ALTER TABLE cars
ALTER COLUMN brand SET NOT NULL,
ALTER COLUMN model SET NOT NULL,
ALTER COLUMN year SET NOT NULL,
ALTER COLUMN price SET NOT NULL,
ALTER COLUMN color SET NOT NULL,
ALTER COLUMN condition SET NOT NULL,
ALTER COLUMN sold SET NOT NULL;
```

## Joins

### LEFT JOIN

```sql
SELECT brand, model, price, sold, sold_price 
  FROM sold_cars 
  LEFT JOIN cars ON sold_cars.cars_id = cars.id;

SELECT brand, model, price, sold, sold_price 
  FROM sold_cars SC -- using alias to call sold_cars SC
  LEFT JOIN cars C ON SC.cars_id = C.id; -- using alias to call cars C

SELECT name, role, city, state FROM staff
  LEFT JOIN dealerships ON dealership_id = dealerships.id;
```

### RIGHT JOIN

```sql
SELECT brand, model, price, sold, sold_price 
  FROM sold_cars SC
  RIGHT JOIN cars C ON SC.cars_id = C.id;

SELECT name, role, city, state FROM staff
  RIGHT JOIN dealerships ON dealership_id = dealerships.id;
```

### DROP
*the opposite of CREATE*

```sql
ALTER TABLE staff
ALTER COLUMN dealership_id DROP NOT NULL; -- drop the NOT NULL constraint
```

### INNER JOIN

```sql
SELECT name, role, city, state FROM staff
	INNER JOIN dealerships ON dealership_id = dealerships.id;
```

### FULL JOIN

```sql
SELECT name, role, city, state FROM staff
	FULL JOIN dealerships ON dealership_id = dealerships.id;
```

## Alter Constraints

```sql
  /*
	1. Alter table sold_cars
		alter column seller
		drop the not null constraint
*/

ALTER TABLE sold_cars
ALTER COLUMN seller DROP NOT NULL;

/*
	2. Update sold_cars setting the seller to null
	     where the seller was Frankie
	     hint: you can select his id from staff in query.js first
*/

UPDATE sold_cars SET seller = NULL WHERE seller = 5;

/*
	3. Delete Frankie Fender from the staff table
*/

DELETE FROM staff WHERE name = 'Frankie Fender';
```