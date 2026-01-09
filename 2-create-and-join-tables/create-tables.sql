/*

Create the cars table with the following columns:
* id - SERIAL PRIMARY KEY
* brand - TEXT
* model - TEXT
* year - INTEGER
* price INTEGER,
* color TEXT,
* condition INTEGER,
* sold BOOLEAN

*/

CREATE TABLE IF NOT EXISTS cars (
id SERIAL PRIMARY KEY,
brand TEXT,
model TEXT,
year INTEGER,
price INTEGER,
color TEXT,
condition INTEGER,
sold BOOLEAN
);

/*
	Create the dealerships table
		Include these columns:
			id - serial primary key
			city - text - NOT NULL
			state - char(2) - NOT NULL
			established - date - NOT NULL
*/

CREATE TABLE IF NOT EXISTS dealerships (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    state CHAR(2) NOT NULL,
    established DATE NOT NULL
)

/*
	Create the staff table
		Include these columns:
			id - serial primary key
			dealership_id - INTEGER NOT NULL REFERENCES dealerships(id)
			name - text - NOT NULL
			role - text - NOT NULL
*/

CREATE TABLE IF NOT EXISTS staff (
    id SERIAL PRIMARY KEY,
    dealership_id INTEGER NOT NULL REFERENCES dealerships(id),
    name TEXT NOT NULL,
    role TEXT NOT NULL
);