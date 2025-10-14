-- 1. Query untuk membuat table

CREATE TABLE nelayan (
    id_nelayan INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_nelayan VARCHAR(100),
    alamat VARCHAR(255)
);

SELECT * FROM nelayan;

CREATE TABLE kapal (
    id_kapal INT(11) AUTO_INCREMENT PRIMARY KEY,
    nama_kapal VARCHAR(100),
    kapasitas_kapal DECIMAL(10, 2),
    id_nelayan INT(11),

    CONSTRAINT fk_nelayan FOREIGN KEY (id_nelayan) REFERENCES nelayan(id_nelayan) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM kapal;

CREATE TABLE daerah_tangkap (
    id_daerah INT (11) PRIMARY KEY AUTO_INCREMENT,
    nama_daerah VARCHAR(100),
    koordinat VARCHAR(100)
);

SELECT * FROM daerah_tangkap;

CREATE TABLE jenis_ikan (
    id_jenis_ikan INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_ikan VARCHAR(100),
    kategori_ikan VARCHAR(50)
);

CREATE TABLE pelabuhan (
    id_pelabuhan INT(11) AUTO_INCREMENT PRIMARY KEY,
    nama_pelabuhan VARCHAR(100),
    lokasi VARCHAR(255)
);

CREATE TABLE hasil_tangkapan (
    id_tangkapan INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_nelayan INT (11),
    id_jenis_ikan INT(11),
    id_daerah INT(11),
    berat_tangkapan DECIMAL(10, 2),

    CONSTRAINT fk_tangkapan_nelayan FOREIGN KEY (id_nelayan) REFERENCES nelayan(id_nelayan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_jenis_ikan FOREIGN KEY (id_jenis_ikan) REFERENCES jenis_ikan(id_jenis_ikan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT dk_daerah FOREIGN KEY (id_daerah) REFERENCES daerah_tangkap(id_daerah) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM hasil_tangkapan

CREATE TABLE pendaratan_ikan (
    id_pendaratan INT(11) PRIMARY KEY AUTO_INCREMENT,
    id_pelabuhan INT(11),
    id_tangkapan INT(11),
    tanggal_pendaratan DATE,

    CONSTRAINT fk_pelabuhan FOREIGN KEY (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tangkapan FOREIGN KEY (id_tangkapan) REFERENCES hasil_tangkapan(id_tangkapan) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM pendaratan_ikan

CREATE TABLE harga_ikan (
    id_harga INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_jenis_ikan INT(11),
    id_pelabuhan INT(11),
    harga_per_kg DECIMAL (10, 2),

    CONSTRAINT fk_jenis_ikan_tangkap FOREIGN KEY (id_jenis_ikan) REFERENCES jenis_ikan(id_jenis_ikan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pelabuhan_tangkap FOREIGN KEY (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE penjual_ikan (
    id_penjual INT(11) AUTO_INCREMENT PRIMARY KEY,
    nama_penjual VARCHAR(100),
    id_pelabuhan INT(11),

    CONSTRAINT fk_pelabuhan_jual FOREIGN KEY (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pembeli_ikan (
    id_pembeli INT(11) AUTO_INCREMENT PRIMARY KEY,
    nama_pembeli VARCHAR(100),
    id_penjual INT(11),
    jumlah_pembelian DECIMAL(10, 2),
    tanggal_pembelian DATE,

    CONSTRAINT fk_pembeli FOREIGN KEY (id_penjual) REFERENCES penjual_ikan(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2. Tambahkan data pada setiap table menjadi seperti berikut:

INSERT INTO nelayan (nama_nelayan, alamat) VALUES
('Budi', 'Jalan Laut 10'),
('Slamet', 'Jalan Samudra 20'),
('Joko', 'Jalan Bahari 5'),
('Hasan', 'Jalan Pelabuhan 15'),
('Hendra', 'Jalan Karang 30'),
('Rahmat', 'Jalan Laut Selatan 12'),
('Dewi', 'Jalan Samudera Kecil 18'),
('Fajar', 'Jalan Ikan Patin 9'),
('Rizal', 'Jalan Pantai Timur 27'),
('Andi', 'Jalan Karang Laut 5')

SELECT * FROM nelayan

INSERT INTO kapal (id_kapal, nama_kapal, kapasitas_kapal
, id_nelayan) VALUES
(101, 'Sumber Laut', 100, 1),
(102, 'Makmur Jaya', 120, 2),
(103, 'Bahari Indah', 150, 3),
(104, 'Laut Sejahtera', 200, 4),
(105, 'Nusantara Indah', 180, 5),
(106, 'Nusantara', 130, 6),
(107, 'Samudra Perkasa', 150, 7),
(108, 'Angin Laut', 110, 8),
(109, 'Bintang Laut', 140, 9),
(110, 'Bahari Sejahtera', 120, 10)

SELECT * FROM kapal

INSERT INTO jenis_ikan (nama_ikan, kategori_ikan) VALUES 
('Tongkol', 'Pelagis Kecil'),
('Tenggiri', 'Pelagis Besar'),
('Cakalang', 'Pelagis Kecil'),
('Layur', 'Demersal'),
('Kakap Merah', 'Karang'),
('Tuna', 'Pelagis Besar'),
('Barakuda', 'Pelagis Besar'),
('Ikan Kembung', 'Pelagis Kecil'),
('Layang', 'Pelagis Kecil'),
('Kakap', 'Karang')

SELECT * FROM jenis_ikan

INSERT INTO daerah_tangkap (id_daerah, nama_daerah, koordinat) VALUES
(301, 'Laut Jawa', '-6.112, 110.419'),
(302, 'Samudra Hindia', '-9.412, 112.873'),
(303, 'Selat Makassar', '-2.205, 117.461'),
(304, 'Laut Banda', '-4.523, 129.289'),
(305, 'Selat Karimata', '-1.832, 108.972'),
(306, 'Laut Sulawesi', '-3.945, 123.721'),
(307, 'Selat Sunda', '-5.882, 105.842'),
(308, 'Laut Jawa', '-6.105, 110.719'),
(309, 'Laut Maluku', '-1.654, 126.451'),
(310, 'Samudra Hindia', '-9.125, 112.453')

SELECT * FROM daerah_tangkap

INSERT INTO hasil_tangkapan (id_tangkapan, id_nelayan, id_jenis_ikan, id_daerah, berat_tangkapan) VALUES
(5001, 1, 1, 301, 500),
(5002, 2, 2, 302, 400),
(5003, 3, 3, 303, 350),
(5004, 4, 4, 304, 450),
(5005, 5, 5, 305, 600),
(5006, 6, 6, 306, 520),
(5007, 7, 7, 307, 480),
(5008, 8, 8, 308, 360),
(5009, 9, 9, 309, 420),
(5010, 10, 10, 310, 530),
(5011, 1, 1, 301, 200),
(5012, 2, 2, 302, 150),
(5013, 3, 3, 303, 300),
(5014, 4, 4, 304, 250),
(5015, 5, 5, 305, 220),
(5016, 6, 6, 306, 180),
(5017, 2, 2, 302, 160),
(5018, 4, 4, 304, 210),
(5019, 6, 6, 306, 190),
(5020, 7, 7, 307, 230),
(5021, 8, 8, 308, 400)

SELECT * FROM hasil_tangkapan

INSERT INTO pelabuhan (nama_pelabuhan, lokasi) VALUES
('Pelabuhan Perikanan Samudra Jakarta', 'Jakarta'),
('Pelabuhan Perikanan Samudra Cilacap', 'Cilacap'),
('Pelabuhan Perikanan Samudra Bitung', 'Bitung'),
('Pelabuhan Perikanan Samudra Kendari', 'Kendari'),
('Pelabuhan Perikanan Samudra Ambon', 'Ambon'),
('Pelabuhan Perikanan Samudra Tual', 'Tual'),
('Pelabuhan Perikanan Samudra Pelabuhanratu', 'Pelabuhanratu'),
('Pelabuhan Perikanan Samudra Muara Angke', 'Jakarta Utara'),
('Pelabuhan Perikanan Samudra Ternate', 'Ternate'),
('Pelabuhan Perikanan Samudra Bali', 'Bali')

SELECT * FROM pelabuhan

INSERT INTO pendaratan_ikan (id_pendaratan, id_pelabuhan, id_tangkapan, tanggal_pendaratan) VALUES
(9001, 1, 5001, '2024-09-12'),
(9002, 2, 5002, '2024-09-13'),
(9003, 3, 5003, '2024-09-14'),
(9004, 4, 5004, '2024-09-15'),
(9005, 5, 5005, '2024-09-16'),
(9006, 6, 5006, '2024-09-16'),
(9007, 7, 5007, '2024-09-17'),
(9008, 8, 5008, '2024-09-17'),
(9009, 9, 5009, '2024-09-18'),
(9010, 10, 5010, '2024-09-18'),
(9011, 1, 5011, '2024-09-19'),
(9012, 2, 5012, '2024-09-19'),
(9013, 3, 5013, '2024-09-20'),
(9014, 4, 5014, '2024-09-20'),
(9015, 5, 5015, '2024-09-21'),
(9016, 6, 5016, '2024-09-25'),
(9017, 2, 5017, '2024-09-26'),
(9018, 4, 5018, '2024-09-27'),
(9019, 6, 5019, '2024-09-28'),
(9020, 7, 5020, '2024-09-29'),
(9021, 10, 5021, '2024-09-30')

SELECT * FROM pendaratan_ikan

INSERT INTO penjual_ikan (id_penjual, nama_penjual, id_pelabuhan) VALUES
(101, 'Pak Budi', 1), 
(102, 'Pak Slamet', 2), 
(103, 'Pak Joko', 3), 
(104, 'Bu Siti', 4), 
(105, 'Pak Yoyo', 5), 
(106, 'Pak Herman', 6), 
(107, 'Bu Nina', 7), 
(108, 'Pak Edi', 8), 
(109, 'Bu Wati', 9), 
(110, 'Pak Suryo', 10)

INSERT INTO harga_ikan (id_jenis_ikan, id_pelabuhan, harga_per_kg) VALUES
(1, 1, 50000),
(2, 2, 75000),
(3, 3, 60000),
(4, 4, 40000),
(5, 5, 85000),
(6, 6, 85000),
(7, 7, 76000),
(8, 8, 35000),
(9, 9, 32000),
(10, 10, 70000)

SELECT * FROM harga_ikan

INSERT INTO pembeli_ikan (id_pembeli, nama_pembeli, id_penjual, jumlah_pembelian, tanggal_pembelian) VALUES
(1001, 'Pak Ahmad', 101, 50, '2024-09-12'),
(1002, 'Bu Rini', 102, 100, '2024-09-13'),
(1003, 'Pak Sugeng', 103, 75, '2024-09-14'),
(1004, 'Bu Dian', 104, 60, '2024-09-15'),
(1005, 'Pak Iwan', 106, 90, '2024-09-16'),
(1006, 'Bu Ani', 107, 40, '2024-09-16'),
(1007, 'Pak Hari', 108, 120, '2024-09-17'),
(1008, 'Bu Nita', 109, 85, '2024-09-17'),
(1009, 'Pak Danu', 110, 70, '2024-09-18'),
(1010, 'Bu Sari', 101, 95, '2024-09-18'),
(1011, 'Pak Ahmad', 101, 50, '2024-09-19'),
(1012, 'Pak Budi', 102, 75, '2024-09-19'),
(1013, 'Bu Citra', 103, 60, '2024-09-20'),
(1014, 'Bu Dewi', 104, 80, '2024-09-20'),
(1015, 'Pak Eko', 106, 70, '2024-09-21'),
(1016, 'Pak Fahmi', 101, 55, '2024-09-25'),
(1017, 'Bu Gita', 103, 62, '2024-09-26'),
(1018, 'Pak Hendra', 104, 78, '2024-09-27'),
(1019, 'Bu Indah', 102, 8, '2024-09-28'),
(1020, 'Pak Joko', 106, 710, '2024-09-29')

-- 3. sertakan query memperbarui berat tangkapan dengan id_tangkapan 5001 menjadi 550
UPDATE hasil_tangkapan SET berat_tangkapan = 550 WHERE id_tangkapan = 5001;

SELECT * FROM hasil_tangkapan WHERE id_tangkapan = 5001;

-- 4. Sertakan query untuk memperbarui harga per kg untuk jenis ikan dengan id_jenis_ikan 2 di pelabuhan dengan id_pelabuhan 2 menjadi 80000
UPDATE harga_ikan SET harga_per_kg = 80000 WHERE id_jenis_ikan = 2 AND id_pelabuhan = 2;

SELECT * FROM harga_ikan WHERE id_jenis_ikan = 2 AND id_pelabuhan = 2;

-- 5. Sertakan query untuk mengubah nama penjual dari 'Pak Joko' menjadi 'Pak Joni' pada tabel penjual. 
UPDATE penjual_ikan SET nama_penjual = 'Pak Joni' WHERE nama_penjual = 'Pak Joko';

SELECT * FROM penjual_ikan WHERE nama_penjual = 'Pak Joni';

-- 6. SertKn query untuk memperbarui lokasi pelabuhan dari 'Ambon' menjadi 'Ambon Baru' pada tabel pelabuhan
UPDATE pelabuhan SET lokasi = 'Ambon Baru' WHERE lokasi = 'Ambon';

SELECT * FROM pelabuhan WHERE lokasi = 'Ambon Baru';

-- 7. Sertakan query untuk memperbarui tanggal pendaratan untuk pendaratan dengan id_pendaratan 9003 menjadi '2024-09-15
UPDATE pendaratan_ikan SET tanggal_pendaratan = '2024-09-15' WHERE id_pendaratan = 9003;

SELECT * FROM pendaratan_ikan WHERE id_pendaratan = 9003;

-- 8. Sertakan query untuk menghapus semua data pendaratan yang terjadi sebelum tanggal '2024-09-30' dari tabel pendaratan. 
DELETE FROM pendaratan_ikan WHERE tanggal_pendaratan < '2024-09-30';

SELECT * FROM pendaratan_ikan;

-- 9. Sertakan query untuk menghapus data tangkapan dengan id_tangkapan 5021 dari tabel tangkapan.
DELETE FROM hasil_tangkapan WHERE id_tangkapan = 5021;

SELECT * FROM hasil_tangkapan WHERE id_tangkapan = 5021;

-- 10. Sertakan query untuk menghapus data Penjual_Ikan yang tidak aktif menjual/sepi pembeli 
DELETE FROM penjual_ikan WHERE id_penjual NOT IN (SELECT DISTINCT id_penjual FROM pembeli_ikan);

SELECT * FROM penjual_ikan;

-- 11. Sertakan query untuk menampilkan nama kapal dan kapasitas kapal dari tabel kapal yang memiliki kapasitas lebih dari 150
SELECT nama_kapal, kapasitas_kapal FROM kapal WHERE kapasitas_kapal > 150;

-- 12. Sertakan query untuk menampilkan semua ikan yang termasuk dalam kategori 'Pelagis Kecil' dari tabel jenis_ikan. 
SELECT * FROM jenis_ikan WHERE kategori_ikan = 'Pelagis Kecil';

-- 13. Sertakan query untuk menampilkan jumlah total tangkapan (berat_tangkapan) untuk setiap nelayan dan tampilkan id_nelayan, nama_nelayan, dan total tangkapan.
SELECT n.id_nelayan, n.nama_nelayan, SUM(ht.berat_tangkapan) AS total_tangkapan
FROM nelayan n
JOIN hasil_tangkapan ht ON n.id_nelayan = ht.id_nelayan
GROUP BY n.id_nelayan, n.nama_nelayan;

-- 14.  Sertakan query untuk menampilkan nama_pembeli dan jumlah_pembelian dari tabel pembeli yang jumlah pembeliannya lebih dari 100.
SELECT nama_pembeli, jumlah_pembelian FROM pembeli_ikan WHERE jumlah_pembelian > 100;

-- 15. Sertakan query untuk menampilkan nama ikan dan harga per kg dari tabel harga untuk ikan yang harga per kg-nya lebih dari 60000. 
SELECT ji.nama_ikan, hi.harga_per_kg
FROM jenis_ikan ji
JOIN harga_ikan hi ON ji.id_jenis_ikan = hi.id_jenis_ikan
WHERE hi.harga_per_kg > 60000;

-- 16.  Sertakan query untuk menampilkan semua data pembeli yang melakukan pembelian pada tanggal '2024-09-20'.
SELECT * FROM pembeli_ikan WHERE tanggal_pembelian = '2024-09-20';

-- 17. Sertakan query untuk menampilkan id_tangkapan, nama ikan, dan berat tangkapan dari tabel hasil_tangkapan dan jenis_ikan.
SELECT ht.id_tangkapan, ji.nama_ikan, ht.berat_tangkapan
FROM hasil_tangkapan ht
JOIN jenis_ikan ji ON ht.id_jenis_ikan = ji.id_jenis_ikan;

-- 18. Sertakan query untuk menghitung total berat tangkapan ikan yang diambil dari setiap daerah. Tampilkan nama_daerah dan total berat_tangkapan. (query agregasi)
SELECT dt.nama_daerah, SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM daerah_tangkap dt
JOIN hasil_tangkapan ht ON dt.id_daerah = ht.id_daerah
GROUP BY dt.nama_daerah;

-- 19. Sertakan query untuk menghitung rata-rata harga per kg untuk setiap jenis ikan dari tabel harga. Tampilkan nama_ikan dan rata-rata harga. (query agregasi) 
SELECT ji.nama_ikan, AVG(hi.harga_per_kg) AS rata_rata_harga
FROM jenis_ikan ji
JOIN harga_ikan hi ON ji.id_jenis_ikan = hi.id_jenis_ikan
GROUP BY ji.nama_ikan;

-- 20. Sertakan query untuk menghitung jumlah total tangkapan (berat_tangkapan) untuk setiap nelayan. Tampilkan id_nelayan, nama_nelayan, dan total berat_tangkapan. (query agregasi)
SELECT n.id_nelayan, n.nama_nelayan, SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM nelayan n
JOIN hasil_tangkapan ht ON n.id_nelayan = ht.id_nelayan
GROUP BY n.id_nelayan, n.nama_nelayan;

-- 21. Sertakan query untuk menghitung jumlah pembeli yang melakukan transaksi untuk setiap penjual. Tampilkan id_penjual, nama_penjual, dan total jumlah pembeli. (query agregasi) 
SELECT pi.id_penjual, pi.nama_penjual, COUNT(DISTINCT bi.id_pembeli) AS total_jumlah_pembeli
FROM penjual_ikan pi
JOIN pembeli_ikan bi ON pi.id_penjual = bi.id_penjual
GROUP BY pi.id_penjual, pi.nama_penjual;

-- 22.  Sertakan query untuk menemukan jenis ikan yang memiliki total berat tangkapan tertinggi. Tampilkan nama_ikan dan total berat_tangkapan. (query agregasi)
SELECT ji.nama_ikan, SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM jenis_ikan ji
JOIN hasil_tangkapan ht ON ji.id_jenis_ikan = ht.id_jenis_ikan
GROUP BY ji.nama_ikan
ORDER BY total_berat_tangkapan DESC
LIMIT 1;

-- 23. Sertakan query untuk menampilkan id_nelayan, nama_nelayan, id_jenis_ikan, nama_ikan, dan total berat tangkapan untuk setiap nelayan dan jenis ikan. Pastikan hasilnya terurut berdasarkan nama nelayan dan nama ikan. (dapat menggunakan subquery)
SELECT n.id_nelayan, n.nama_nelayan, ji.id_jenis_ikan, ji.nama_ikan, SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM nelayan n
JOIN hasil_tangkapan ht ON n.id_nelayan = ht.id_nelayan
JOIN jenis_ikan ji ON ht.id_jenis_ikan = ji.id_jenis_ikan
GROUP BY n.id_nelayan, n.nama_nelayan, ji.id_jenis_ikan, ji.nama_ikan
ORDER BY n.nama_nelayan, ji.nama_ikan;

-- 24. Sertakan query untuk menampilkan id_pelabuhan, nama_pelabuhan, dan rata-rata harga per kilogram dari semua jenis ikan yang ditangkap dan didaratkan di setiap pelabuhan. Pastikan hasilnya terurut berdasarkan nama pelabuhan. (dapat menggunakan subquery)
SELECT p.id_pelabuhan, p.nama_pelabuhan, AVG(hp.harga_per_kg) AS rata_rata_harga_per_kg
FROM pelabuhan p
JOIN pendaratan_ikan pi ON p.id_pelabuhan = pi.id_pelabuhan
JOIN hasil_tangkapan ht ON pi.id_tangkapan = ht.id_tangkapan
JOIN harga_ikan hp ON ht.id_jenis_ikan = hp.id_jenis_ikan AND p.id_pelabuhan = hp.id_pelabuhan
GROUP BY p.id_pelabuhan, p.nama_pelabuhan
ORDER BY p.nama_pelabuhan;

-- 25.  Sertakan  query untuk menampilkan id_pembeli, nama_pembeli, dan total pembelian (jumlah pembelian * harga per kg) untuk setiap pembeli. Pastikan hanya menampilkan pembeli dengan total pembelian di atas 5.000. Hasilkan daftar yang terurut berdasarkan total pembelian tertinggi. (dapat menggunakan subquery)
SELECT bi.id_pembeli, bi.nama_pembeli, 
       SUM(bi.jumlah_pembelian * hi.harga_per_kg) AS total_pembelian
FROM pembeli_ikan bi
JOIN penjual_ikan pi ON bi.id_penjual = pi.id_penjual
JOIN harga_ikan hi ON pi.id_pelabuhan = hi.id_pelabuhan
GROUP BY bi.id_pembeli, bi.nama_pembeli
HAVING total_pembelian > 5000
ORDER BY total_pembelian DESC;