-- I'm going to create the student table 
CREATE TABLE students  (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  gender VARCHAR(25),
  birthday DATETIME 
);

--DROP TABLE students;

INSERT INTO students VALUES (1, 'Ryan', 'M', '2001-2-2 02:03:03');
INSERT INTO students VALUES (2, "Joanna", 'F', '1965-2-2 02:03:03');
INSERT INTO students VALUES (3, "Bob", 3.14159,'1965-2-2 02:03:03');
INSERT INTO students (id, name, gender) VALUES (4, "Marianna", 'F');

INSERT INTO students VALUES 
(5, 'Mo', 'M', '1905-01-01 00:00:00'),
(6, 'Larry', 'M', '1906-01-01 00:00:00');

SELECT * FROM students;

-- Let's add another table for dogs
CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  breed VARCHAR(10) DEFAULT 'Mix'
);

SELECT * FROM dogs;

INSERT INTO dogs VALUES (1, 'Fido', 'Labrador');
INSERT INTO dogs (id, name) VALUES (2, 'Spot');
--DELETE FROM dogs WHERE id=2;

-- what if we want a column to connect dogs to students?  
ALTER TABLE dogs ADD COLUMN student_id INTEGER;
UPDATE dogs SET student_id = 4 WHERE id=1;
UPDATE dogs SET student_id = 6 WHERE id=2;

UPDATE dogs SET breed = 'Mix' WHERE id=2;


--ALTER TABLE dogs DROP COLUMN student_id;
--SELECT * FROM dogs

--DROP table dogs;


SELECT TRIM(car_make) FROM cars
UPDATE cars SET car_make = 'ford' WHERE car_make='ford ';

