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

[AGGREGATES](#aggregates)

[JOINING MULTIPLE TABLES](#joining-multiple-tables)

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

SELECT name, role, sold_price FROM staff
	INNER JOIN sold_cars ON staff.id = seller;
```

### FULL JOIN

```sql
SELECT name, role, city, state FROM staff
	FULL JOIN dealerships ON dealership_id = dealerships.id;

SELECT name, role, sold_price FROM staff
	FULL JOIN sold_cars ON staff.id = seller;
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

## Aggregates

```sql
/*
	Select the city and average car price
	Round that car price to a whole number
	
	Only show dealerships which have cars
	
	Group by dealership city and state
*/

SELECT city, state, ROUND(AVG(price), 2) AS avg_price
	FROM cars
	LEFT JOIN dealerships D ON dealership_id = D.id
GROUP BY city, state;
```

```sql
/*
	Select the name and role, alongside a total_sales:
		this is the sum of sales by a member of staff
	
	Use staff as your left table and sold_cars as your right table
	
	Include a where clause to select only staff with the role 'Salesperson'
	
	Group by staff name and role
	Order by the total_sales from high to low
*/

SELECT name, role, SUM(sold_price) AS total_sales
	FROM staff S
	LEFT JOIN sold_cars ON S.id = seller
WHERE role = 'Salesperson'
GROUP BY name, role
ORDER BY total_sales DESC;
```

```sql
/*
	Select the city, state and
		count the total number of cars in each dealership
		alias the count as car_count
	
	Use cars as the left table, and dealerships as the right table
		choosing a join which will show every dealership
		
	Include a condition to count unsold cars
	
	Group by dealership city and state
	Order by the car_count
*/

SELECT city, state, COUNT(C.id) AS car_count
	FROM cars C
	RIGHT JOIN dealerships D ON dealership_id = D.id
WHERE sold IS NOT TRUE
GROUP BY city, state
ORDER BY car_count;
```

## Joining multiple tables
*joining multiple tables by chaining JOIN clauses*

```sql
/*
	List:
		- the brand and model of cars
		- include the name of the seller,
		- the city they work in
		- the date of the sale
	
	Format the sold_date as DD-MM-YYYY using TO_CHAR()
	
	Use sold_cars as the left table and join other tables
		show sold_cars when we have no record of the seller
*/

SELECT
	C.brand,
	C.model,
	S.name AS seller_name,
	D.city,
	TO_CHAR(SC.sold_date, 'DD-MM-YYYY') AS date_of_sale
FROM sold_cars SC
	INNER JOIN cars C ON SC.cars_id = C.id
	LEFT JOIN staff S ON SC.seller = S.id
	LEFT JOIN dealerships D ON S.dealership_id = D.id;
```

```sql
/*
	Select the name, role and city from sold_cars
	
	Join with the staff and dealerships tables
		use appropriate joins to show staff who have no dealership_id
		
	Include a where clause to find
		- null values in sold_cars
		- staff who have the role 'Salesperson'
*/

SELECT
	S.name,
	S.role,
	D.city
FROM sold_cars SC
	FULL JOIN staff S ON SC.seller = S.id
	LEFT JOIN dealerships D ON S.dealership_id = D.id
WHERE SC.id IS NULL
	AND S.role = 'Salesperson';
```

```sql
/*
	Show the city and state of dealerships
		with a count of the cars sold
		aliased as cars_sold
		
	Select from sold_cars
		join with the relevant tables
		
	Include dealerships which have no sold cars
	
	Order the count in descending order
		
	Hint: you may need to join using a table not included in our columns
*/

SELECT
	D.city,
	D.state,
	COUNT(SC.id) AS cars_sold
FROM sold_cars SC
	LEFT JOIN cars C ON SC.cars_id = C.id
	RIGHT JOIN dealerships D ON C.dealership_id = D.id
GROUP BY D.city, D.state
ORDER BY cars_sold DESC;
```