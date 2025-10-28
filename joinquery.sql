
-- Departemen / Prodi
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- Mahasiswa
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    entry_year INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Dosen
CREATE TABLE lecturers (
    lect_id INT PRIMARY KEY,
    lect_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Mata kuliah
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE,
    course_title VARCHAR(150),
    credits INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Kelas (penyelenggaraan MK per semester & dosen)
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    course_id INT,
    lect_id INT,
    semester VARCHAR(10),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id)
);

-- Ruang
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_name VARCHAR(50),
    capacity INT
);

-- Jadwal kelas di ruang
CREATE TABLE schedules (
    schedule_id INT PRIMARY KEY,
    class_id INT,
    room_id INT,
    day_of_week VARCHAR(10),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- KRS 
CREATE TABLE enrollments (
    student_id INT,
    class_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- Prasyarat MK 
CREATE TABLE prerequisites (
    course_id INT,
    prereq_id INT,
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (prereq_id) REFERENCES courses(course_id)
);

-- Hierarki dosen 
CREATE TABLE lecturer_supervisions (
    lect_id INT,
    supervisor_id INT,
    PRIMARY KEY (lect_id, supervisor_id),
    FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id),
    FOREIGN KEY (supervisor_id) REFERENCES lecturers(lect_id)
);


INSERT INTO departments VALUES
(10,'Sistem Informasi Kelautan'),
(20,'Ilmu Komputer'),
(30,'Biologi Kelautan');

INSERT INTO students VALUES
(2103118,'Roni Antonius Sinabutar',2021,10),
(2103120,'Salsa Aurelia',2021,10),
(2204101,'Rakhil Syakira Yusuf',2022,10),
(2205205,'Adit Pratama',2022,20),
(2306102,'Nadia Putri',2023,20),
(2307107,'Bima Mahesa',2023,30);

INSERT INTO lecturers VALUES
(501,'Willdan',10),
(502,'Supriadi',10),
(503,'Ayang',20),
(504,'Alam',30),
(505,'Luthfi',10);

INSERT INTO courses VALUES
(1001,'KL202','Algoritma & Pemrograman',3,10),
(1002,'KL218','Sistem Basis Data',3,10),
(1003,'CS101','Pengantar Ilmu Komputer',2,20),
(1004,'CS205','Basis Data Lanjut',3,20),
(1005,'MB110','Biologi Laut Dasar',2,30),
(1006,'KL305','SIG Kelautan',3,10);

INSERT INTO classes VALUES
(9001,1002,501,'2025-1'),
(9002,1001,502,'2025-1'),
(9003,1003,503,'2025-1'),
(9004,1005,504,'2025-1'),
(9005,1004,503,'2025-1'),
(9006,1006,505,'2025-1');

INSERT INTO rooms VALUES
(1,'Lab Big Data',30),
(2,'Ruang Kuliah 201',40),
(3,'Lab Komputasi 1',25),
(4,'Aula 3',100);

INSERT INTO schedules VALUES
(7001,9001,3,'Monday','08:00','10:30'),
(7002,9002,2,'Tuesday','10:00','12:00'),
(7003,9003,2,'Wednesday','08:00','10:00'),
(7004,9004,4,'Thursday','13:00','15:00'),
(7005,9005,3,'Friday','09:00','11:30'),
(7006,9006,1,'Monday','13:00','15:30');

INSERT INTO enrollments VALUES
(2103118,9001,'A'),
(2103118,9002,'B'),
(2103120,9001,'B'),
(2103120,9006,'A'),
(2204101,9001,NULL),
(2204101,9005,NULL),
(2205205,9003,'A'),
(2306102,9003,'B'),
(2306102,9005,NULL),
(2307107,9004,'A');

INSERT INTO prerequisites VALUES
(1004,1002),
(1006,1001);

INSERT INTO lecturer_supervisions VALUES
(501,505),
(502,501),
(503,501),
(504,505);


-- 1. Nama mahasiswa dan nama departemennya
SELECT s.student_name, d.dept_name
FROM students s
INNER JOIN departments d ON s.dept_id = d.dept_id;

-- 2. Daftar kelas beserta mata kuliah dan dosen pengajarnya
SELECT cl.class_id, c.course_code, c.course_title, l.lect_name, cl.semester
FROM classes cl
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN lecturers l ON cl.lect_id = l.lect_id;

-- 3. Mahasiswa yang mengambil kelas 'Sistem Basis Data' (1002)
SELECT s.student_name, c.course_title
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
WHERE c.course_id = 1002;

-- 4. Jadwal lengkap kelas (hari, jam, ruang) untuk tiap mata kuliah
SELECT c.course_code, c.course_title, l.lect_name, 
       sch.day_of_week, sch.start_time, sch.end_time, r.room_name
FROM schedules sch
INNER JOIN classes cl ON sch.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN lecturers l ON cl.lect_id = l.lect_id
INNER JOIN rooms r ON sch.room_id = r.room_id;

-- 5. Jumlah mahasiswa per departemen yang terdaftar di semester '2025-1'
SELECT d.dept_name, COUNT(DISTINCT e.student_id) AS jumlah_mahasiswa
FROM departments d
LEFT JOIN students s ON d.dept_id = s.dept_id
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN classes cl ON e.class_id = cl.class_id AND cl.semester = '2025-1'
GROUP BY d.dept_id, d.dept_name;

-- 6. Kelas yang diajar oleh dosen satu departemen dengan mata kuliah yang diajarkan
SELECT cl.class_id, c.course_code, c.course_title, l.lect_name, 
       d.dept_name AS dept_course_dan_lecturer
FROM classes cl
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN lecturers l ON cl.lect_id = l.lect_id
INNER JOIN departments d ON c.dept_id = d.dept_id AND l.dept_id = d.dept_id;

-- 7. Mahasiswa SIK (dept 10) yang mengambil kelas di luar dept-nya
SELECT s.student_name, c.course_code, c.course_title, d.dept_name AS dept_mata_kuliah
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN departments d ON c.dept_id = d.dept_id
WHERE s.dept_id = 10 AND c.dept_id != 10;

-- 8. Mata kuliah beserta prasyaratnya (self-join pada courses via prerequisites)
SELECT c1.course_code AS course, c1.course_title AS course_title,
       c2.course_code AS prereq_code, c2.course_title AS prereq_title
FROM prerequisites p
INNER JOIN courses c1 ON p.course_id = c1.course_id
INNER JOIN courses c2 ON p.prereq_id = c2.course_id;

-- 9. Daftar dosen dan dosen pembinanya (self-join lecturers)
SELECT l1.lect_name AS dosen, l2.lect_name AS pembina
FROM lecturer_supervisions ls
INNER JOIN lecturers l1 ON ls.lect_id = l1.lect_id
INNER JOIN lecturers l2 ON ls.supervisor_id = l2.lect_id;

-- 10. Kelas yang belum memiliki nilai untuk sebagian mahasiswa (grade NULL)
SELECT DISTINCT cl.class_id, c.course_code, c.course_title, l.lect_name
FROM enrollments e
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN lecturers l ON cl.lect_id = l.lect_id
WHERE e.grade IS NULL;

-- 11. Mahasiswa yang tidak mengambil kelas 'SIG Kelautan' (1006) namun satu departemen dengan MK itu
SELECT s.student_name
FROM students s
WHERE s.dept_id = (SELECT dept_id FROM courses WHERE course_id = 1006)
AND s.student_id NOT IN (
    SELECT e.student_id 
    FROM enrollments e
    INNER JOIN classes cl ON e.class_id = cl.class_id
    WHERE cl.course_id = 1006
);

-- 12. Jumlah kelas per hari beserta total kapasitas ruang yang dipakai hari itu
SELECT sch.day_of_week, COUNT(DISTINCT sch.class_id) AS jumlah_kelas, 
       SUM(r.capacity) AS total_kapasitas
FROM schedules sch
INNER JOIN rooms r ON sch.room_id = r.room_id
GROUP BY sch.day_of_week;

-- 13. Daftar mahasiswa dan total SKS yang sedang ditempuh (berdasarkan kelas yang diambil)
SELECT s.student_name, SUM(c.credits) AS total_sks
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
GROUP BY s.student_id, s.student_name;

-- 14. Mata kuliah lintas prodi: course dept ≠ lecturer dept pada kelas berjalan
SELECT c.course_code, c.course_title, d1.dept_name AS dept_course, 
       l.lect_name, d2.dept_name AS dept_lecturer
FROM classes cl
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN lecturers l ON cl.lect_id = l.lect_id
INNER JOIN departments d1 ON c.dept_id = d1.dept_id
INNER JOIN departments d2 ON l.dept_id = d2.dept_id
WHERE c.dept_id != l.dept_id;

-- 15. Kelas beserta jumlah peserta & kapasitas ruang, dan status 'PENUH' jika jumlah ≥ kapasitas
SELECT cl.class_id, c.course_code, c.course_title, 
       COUNT(e.student_id) AS jumlah_peserta, r.capacity,
       CASE 
           WHEN COUNT(e.student_id) >= r.capacity THEN 'PENUH'
           ELSE 'TERSEDIA'
       END AS status
FROM classes cl
INNER JOIN courses c ON cl.course_id = c.course_id
LEFT JOIN enrollments e ON cl.class_id = e.class_id
LEFT JOIN schedules sch ON cl.class_id = sch.class_id
LEFT JOIN rooms r ON sch.room_id = r.room_id
GROUP BY cl.class_id, c.course_code, c.course_title, r.capacity;

-- 16. Riwayat KRS tiap mahasiswa dalam semester '2025-1' (urut nama mhs, lalu course_code)
SELECT s.student_name, c.course_code, c.course_title, e.grade
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
WHERE cl.semester = '2025-1'
ORDER BY s.student_name, c.course_code;

-- 17. Daftar mata kuliah yang menjadi prasyarat untuk setidaknya satu mata kuliah lain
SELECT DISTINCT c.course_code, c.course_title
FROM courses c
INNER JOIN prerequisites p ON c.course_id = p.prereq_id;

-- 18. Dosen pembina beserta jumlah dosen yang dibinanya
SELECT l.lect_name AS pembina, COUNT(ls.lect_id) AS jumlah_binaan
FROM lecturers l
INNER JOIN lecturer_supervisions ls ON l.lect_id = ls.supervisor_id
GROUP BY l.lect_id, l.lect_name;

-- 19. Mahasiswa + kelas + ruang jika kelasnya hari 'Monday'
SELECT s.student_name, c.course_code, c.course_title, r.room_name, sch.day_of_week
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN schedules sch ON cl.class_id = sch.class_id
INNER JOIN rooms r ON sch.room_id = r.room_id
WHERE sch.day_of_week = 'Monday';

-- 20. Mata kuliah yang diambil mahasiswa dari departemen berbeda
SELECT DISTINCT c.course_code, c.course_title, d1.dept_name AS dept_course, 
       s.student_name, d2.dept_name AS dept_student
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN courses c ON cl.course_id = c.course_id
INNER JOIN departments d1 ON c.dept_id = d1.dept_id
INNER JOIN departments d2 ON s.dept_id = d2.dept_id
WHERE c.dept_id != s.dept_id;

-- 21. Semua dosen beserta kelas yang diajar (jika tidak mengajar, tetap tampil)
SELECT l.lect_name, c.course_code, c.course_title, cl.semester
FROM lecturers l
LEFT JOIN classes cl ON l.lect_id = cl.lect_id
LEFT JOIN courses c ON cl.course_id = c.course_id;

-- 22. Semua mata kuliah beserta kelasnya pada semester '2025-1' (yang belum dibuka kelasnya tetap tampil)
SELECT c.course_code, c.course_title, cl.class_id, l.lect_name, cl.semester
FROM courses c
LEFT JOIN classes cl ON c.course_id = cl.course_id AND cl.semester = '2025-1'
LEFT JOIN lecturers l ON cl.lect_id = l.lect_id;

-- 23. Pasangan mata kuliah & prasyaratnya dalam satu baris, termasuk yang tidak punya prasyarat (tampilkan NULL)
SELECT c1.course_code, c1.course_title, 
       c2.course_code AS prereq_code, c2.course_title AS prereq_title
FROM courses c1
LEFT JOIN prerequisites p ON c1.course_id = p.course_id
LEFT JOIN courses c2 ON p.prereq_id = c2.course_id;

-- 24. Daftar mahasiswa yang mengambil kelas dosen pembinanya
SELECT s.student_name, l1.lect_name AS dosen_pengajar, l2.lect_name AS pembina_mahasiswa
FROM students s
INNER JOIN lecturers l_student ON s.dept_id = l_student.dept_id
INNER JOIN lecturer_supervisions ls ON l_student.lect_id = ls.lect_id
INNER JOIN lecturers l2 ON ls.supervisor_id = l2.lect_id
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN classes cl ON e.class_id = cl.class_id
INNER JOIN lecturers l1 ON cl.lect_id = l1.lect_id
WHERE l1.lect_id = l2.lect_id;

-- 25. Cek bentrok ruang: pasangan kelas di ruang yang sama pada hari & rentang waktu yang tumpang tindih
SELECT s1.class_id AS class_1, s2.class_id AS class_2, 
       r.room_name, s1.day_of_week, 
       s1.start_time AS start_1, s1.end_time AS end_1,
       s2.start_time AS start_2, s2.end_time AS end_2
FROM schedules s1
INNER JOIN schedules s2 ON s1.room_id = s2.room_id 
                        AND s1.day_of_week = s2.day_of_week
                        AND s1.class_id < s2.class_id
INNER JOIN rooms r ON s1.room_id = r.room_id
WHERE (s1.start_time < s2.end_time AND s1.end_time > s2.start_time);