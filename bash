#Part 1: Fix the database

#You should rename the weight column to atomic_mass
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;

#You should rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

#Your melting_point_celsius and boiling_point_celsius columns should not accept null values
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

#You should add the UNIQUE constraint to the symbol and name columns from the elements table
#Your symbol and name columns should have the NOT NULL constraint

ALTER TABLE elements
   ADD CONSTRAINT unique_symbol UNIQUE (symbol),
   ADD CONSTRAINT unique_name UNIQUE (name),
   ALTER COLUMN symbol SET NOT NULL,
   ALTER COLUMN name SET NOT NULL;

#You should set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
ALTER TABLE properties ADD FOREIGN KEY (atomic_number)  REFERENCES elements(atomic_number);

#You should create a types table that will store the three types of elements
#Your types table should have a type_id column that is an integer and the primary key
#Your types table should have a type column that's a VARCHAR and cannot be null. It will store the different types from the type column in the properties table
CREATE TABLE types(
    type_id INT PRIMARY KEY,
    type VARCHAR(15) NOT NULL
);

#You should add three rows to your types table whose values are the three different types from the properties table
INSERT INTO types (type_id, type)
VALUES
    (1, 'nonmetal'),
    (2, 'metal'),
    (3, 'metalloid');

#Your properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
ALTER TABLE properties
   ADD COLUMN type_id INT NOT NULL DEFAULT 1 REFERENCES types(type_id);

#You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
UPDATE elements SET symbol = INITCAP(symbol);

#You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL(5);
ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL;

#You should add the element with atomic number 9 to your database. Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, boiling point is -188.1, and it's a nonmetal
INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 'nonmetal', 18.988, -220, -188.1, 1);

#You should add the element with atomic number 10 to your database. Its name is Neon, symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, and it's a nonmetal
INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 1);

