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

