CREATE TABLE students (
	id INTEGER PRIMARY KEY,
	name VARCHAR(255),
	gender VARCHAR(255),
	birthday DATETIME
);

INSERT INTO students VALUES (1, "Ryan", "M", "2001-2-2 02:03:00");
INSERT INTO students VALUES (2, 'Joanna', 'F', '1965-4-6 02:03:00');

INSERT INTO students VALUES
(3, 'Mo', 'M', '1905-02-07 01:01:00'),
(4, 'Larry', 'M', '1003-01-02 01:00:00')
;

INSERT INTO students (id, name, gender)
VALUES
(5, 'Louis', 'M'),
(6, 'Curley', 'M')
;

ALTER TABLE students ADD homestate VARCHAR(255);

UPDATE students SET homestate = 'VA' WHERE id=1;

ALTER TABLE students DROP COLUMN homestate;

--DELETE FROM students --will delete data but leave structure

--DROP TABLE students; -- will delete both data and structure