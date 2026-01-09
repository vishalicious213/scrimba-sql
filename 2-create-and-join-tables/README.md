# Creating & Joining Tables

### Creating tables

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

### Populating tables

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