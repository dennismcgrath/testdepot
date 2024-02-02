CREATE TABLE students (
	student_id INTEGER PRIMARY KEY,
	firstname VARCHAR(255),
    lastname VARCHAR(255), 
    state VARCHAR(2)
	);

	DROP TABLE students;
	
INSERT INTO Students VALUES 
(1, 'George', 'Washington', 'Virginia'),
(2, 'Abraham', 'Lincoln', 'Illinois'),
(3, 'John', 'Kennedy', 'Massachusetts');

SELECT * FROM students 
WHERE state = 'Virginia'

SELECT * FROM students 
WHERE firstname LIKE 'A%'

