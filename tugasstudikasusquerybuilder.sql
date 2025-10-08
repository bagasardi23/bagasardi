CREATE TABLE anggota (
    id_anggota INT(3) PRIMARY KEY,
    nm_anggota VARCHAR(32),
    alamat TEXT,
    ttl_anggota TEXT,
    status_anggota VARCHAR(1)
);

SELECT * FROM anggota;

CREATE TABLE buku (
    kd_buku VARCHAR(5) PRIMARY KEY,
    judul_buku VARCHAR(32),
    pengarang VARCHAR(32),
    jenis_buku VARCHAR(32),
    penerbit VARCHAR(32)
);

SELECT * FROM buku;

CREATE TABLE meminjam (
    id_pinjam INT(3) PRIMARY KEY,
    tgl_pinjam DATE,
    jumlah_pinjam INT(2),
    tgl_kembali DATE,
    id_anggota INT(3),
    kd_buku VARCHAR(5),
    kembali INT(1),
    FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    FOREIGN KEY (kd_buku) REFERENCES buku(kd_buku)
);

SELECT * FROM meminjam;

INSERT INTO anggota (id_anggota, nm_anggota, alamat, ttl_anggota, status_anggota) VALUES
(236, 'Syaila', 'Alamanda Regency', '28 November 2005', 'S'),
(234, 'Bagas', 'Jakarta', '23 Januari 2004', 'S'),
(230, 'Sila', 'Cililin', '27 November 2005', 'T'),
(233, 'Fadli', 'Sukabumi', '20 Januari 2005', 'S'),
(231, 'Shofia', 'Solok', '01 Juli 2005', 'T'),
(235, 'Nabil', 'Depok', '13 Desember 2004', 'T'),
(237, 'Najwa', 'Puri Cendana', '10 Desember 2004', 'S'),
(220, 'Pikrom', 'Bogor', '11 Februari 2004', 'S'),
(222, 'Vinsa', 'Bekasi', '14 April 2005', 'T'),
(223, 'Azlia', 'Tambun Selatan', '15 Juni 2004', 'T');

SELECT *FROM anggota;

INSERT INTO buku (kd_buku, judul_buku, pengarang, jenis_buku, penerbit) VALUES
('B001', 'Dasar Pemrograman', 'A. Nugraha', 'Teknologi', 'Informatika Press'),
('B002', 'Laskar Pelangi', 'Andrea Hirata', 'Fiksi', 'Bentang Pustaka'),
('B003', 'Sejarah Dunia', 'E. Saputra', 'Sejarah', 'Gramedia'),
('B004', 'Biologi Umum', 'Dr. T. Rahmawati', 'Sains', 'Erlangga'),
('B005', 'Ekonomi Mikro', 'P. Santoso', 'Ekonomi', 'Salemba Empat'),
('B006', 'Psikologi Remaja', 'R. Suryani', 'Psikologi', 'Deepublish'),
('B007', 'Algoritma dan Struktur Data', 'D. Pratama', 'Teknologi', 'Informatika Press'),
('B008', 'Matematika Lanjut', 'Y. Hadi', 'Pendidikan', 'Erlangga'),
('B009', 'Filsafat Hidup', 'S. Munir', 'Filsafat', 'Kompas'),
('B010', 'Pengantar Oseanografi', 'M. Firmansyah', 'Kelautan', 'UI Press');

SELECT *FROM buku;

INSERT INTO meminjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku, kembali) VALUES
(101, '2025-09-01', 1, '2025-09-08', 236, 'B002', 1),  
(102, '2025-09-03', 2, '2025-09-10', 234, 'B001', 0),  
(103, '2025-09-05', 1, '2025-09-12', 230, 'B006', 1),  
(104, '2025-09-06', 1, '2025-09-13', 233, 'B007', 0),  
(105, '2025-09-07', 1, '2025-09-14', 231, 'B003', 1),  
(106, '2025-09-08', 2, '2025-09-15', 235, 'B004', 0),  
(107, '2025-09-09', 1, '2025-09-16', 237, 'B010', 1),  
(108, '2025-09-10', 1, '2025-09-17', 220, 'B005', 1),  
(109, '2025-09-11', 1, '2025-09-18', 222, 'B009', 0),  
(110, '2025-09-12', 1, '2025-09-19', 223, 'B008', 1);  

UPDATE meminjam
SET tgl_pinjam = DATE_ADD('2025-08-10', INTERVAL FLOOR(RAND() * 4) DAY);

UPDATE meminjam
SET jumlah_pinjam = 5, kd_buku = 'B001'
WHERE id_pinjam = 102;

DELETE FROM meminjam
WHERE id_anggota = 223;

SELECT *FROM meminjam;

-- 2. Anggota yang pernah meminjam
SELECT DISTINCT a.id_anggota, a.nm_anggota, a.status_anggota
FROM anggota a
JOIN meminjam m ON a.id_anggota = m.id_anggota;

-- 3. Anggota yang belum pernah meminjam
SELECT a.id_anggota, a.nm_anggota, a.status_anggota
FROM anggota a
LEFT JOIN meminjam m ON a.id_anggota = m.id_anggota
WHERE m.id_anggota IS NULL;

-- 4. Anggota yang meminjam hari ini
SELECT a.nm_anggota, b.judul_buku, m.tgl_pinjam
FROM anggota a
JOIN meminjam m ON a.id_anggota = m.id_anggota
JOIN buku b ON m.kd_buku = b.kd_buku
WHERE m.tgl_pinjam = "2025-08-10";

-- 5. Anggota yang meminjam lebih dari 3 buku
SELECT a.id_anggota, a.nm_anggota, m.jumlah_pinjam
FROM anggota a
JOIN meminjam m ON a.id_anggota = m.id_anggota
WHERE m.jumlah_pinjam > 3;

-- 6. Buku yang belum kembali setelah deadline
SELECT b.judul_buku, a.nm_anggota, m.tgl_pinjam, m.tgl_kembali
FROM meminjam m
JOIN buku b ON m.kd_buku = b.kd_buku
JOIN anggota a ON m.id_anggota = a.id_anggota
WHERE m.kembali = 0 AND m.tgl_kembali < CURDATE();

-- 7. Ubah status anggota menjadi tidak aktif jika belum pernah meminjam
SELECT *
FROM anggota
WHERE id_anggota NOT IN (SELECT DISTINCT id_anggota FROM meminjam);