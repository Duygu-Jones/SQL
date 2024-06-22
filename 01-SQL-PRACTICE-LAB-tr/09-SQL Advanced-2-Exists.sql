--------------------------: EXISTS (Mevcut) :--------------------------

-- EXISTS: Alt sorgunun satır döndürüp döndürmediğini kontrol eder.
-- NOT EXISTS: Alt sorgunun satır döndürmediğini kontrol eder.

------------------------: TABLE CREATION :--------------------------

-- Mevcut 'students' ve 'enrollments' tablolarını kontrol et ve sil.
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS enrollments;

-- CREATE TABLE: 'students' tablosunu oluşturur.
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255),
    major VARCHAR(255)
);

-- CREATE TABLE: 'enrollments' tablosunu oluşturur.
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(255),
    semester VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- INSERT INTO: 'students' ve 'enrollments' tablolarına örnek veriler ekler.
INSERT INTO students (student_name, major) VALUES
('Alice', 'Computer Science'),
('Bob', 'Mathematics'),
('Charlie', 'Physics'),
('David', 'Engineering'),
('Eve', 'Biology');

INSERT INTO enrollments (student_id, course_name, semester) VALUES
(1, 'Algorithms', 'Fall 2024'),
(2, 'Calculus', 'Fall 2024'),
(3, 'Quantum Mechanics', 'Fall 2024'),
(4, 'Thermodynamics', 'Fall 2024'),
(5, 'Genetics', 'Fall 2024'),
(1, 'Data Structures', 'Spring 2024'),
(2, 'Linear Algebra', 'Spring 2024'),
(3, 'Electrodynamics', 'Spring 2024'),
(4, 'Fluid Mechanics', 'Spring 2024'),
(5, 'Cell Biology', 'Spring 2024');

------------------------: PRACTICE :--------------------------




-- 1. 'Algorithms' dersine kayıtlı öğrenciler varsa, 'students' tablosundaki tüm öğrencileri listeleyin.
SELECT *
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE course_name = 'Algorithms'
);

-- 2. 'Genetics' dersine kayıtlı öğrenciler varsa, 'students' tablosundaki tüm öğrencileri listeleyin.
SELECT *
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE course_name = 'Genetics'
);

-- 3. Öğrencinin 'Fall 2024' döneminde kayıtlı olduğu dersler varsa, 'students' tablosundaki öğrenci kimliği ve adını listeleyin.
SELECT student_id, student_name
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE enrollments.student_id = students.student_id 
    AND semester = 'Fall 2024'
);

-- 4. Öğrencinin hem 'Fall 2024' hem de 'Spring 2024' dönemlerinde kayıtlı olduğu dersler varsa, 'students' tablosundaki öğrenci adını ve bölümünü listeleyin.
SELECT student_name, major
FROM students AS s
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments AS e 
    WHERE e.student_id = s.student_id 
    AND semester = 'Fall 2024'
)
AND EXISTS (
    SELECT course_name 
    FROM enrollments AS e 
    WHERE e.student_id = s.student_id 
    AND semester = 'Spring 2024'
);

-- 5. Öğrenci 'Spring 2024' döneminde kayıtlı değilse, 'students' tablosundaki öğrenci adını ve bölümünü listeleyin.
SELECT student_name, major
FROM students AS s
WHERE NOT EXISTS (
    SELECT course_name
    FROM enrollments AS e 
    WHERE e.student_id = s.student_id 
    AND semester = 'Spring 2024'
);


-- Soru:. 'Data Structures' dersine kayıtlı en az bir öğrenci varsa, 'students' tablosundaki tüm öğrencileri listeleyin.
SELECT *
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE course_name = 'Data Structures'
);

-- Soru:. 'students' tablosundaki öğrencilerin tüm bilgilerini listeleyin, eğer 'Fluid Mechanics' dersi 'Spring 2024' döneminde kayıtlıysa.
SELECT *
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE course_name = 'Fluid Mechanics' 
    AND semester = 'Spring 2024'
);

-- Soru:. 'Electrodynamics' dersine kayıtlı öğrenciler varsa, 'students' tablosundaki tüm öğrencileri listeleyin.
SELECT *
FROM students
WHERE EXISTS (
    SELECT course_name 
    FROM enrollments 
    WHERE course_name = 'Electrodynamics'
);


------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM enrollments WHERE EXISTS (SELECT 1 FROM enrollments);
DELETE FROM students WHERE EXISTS (SELECT 1 FROM students);

-- Tabloları silin.
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
