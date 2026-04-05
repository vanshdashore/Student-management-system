CREATE DATABASE student_db;

USE student_db;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    roll_no INT UNIQUE,
    branch VARCHAR(50),
    cgpa FLOAT,
    skills VARCHAR(100)
);

select * from students;
