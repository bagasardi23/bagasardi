CREATE TABLE mahasiswa 
(id_mahasiswa INT PRIMARY KEY, nama_mahasiswa VARCHAR(100) NOT NULL);

CREATE TABLE matakuliah 
(id_matakuliah INT PRIMARY KEY, nama_matakuliah VARCHAR(100) NOT NULL);

INSERT INTO mahasiswa (id_mahasiswa, nama_mahasiswa) VALUES 
(1, 'Budi'), (2, 'Siti'), (3, 'Agus');

INSERT INTO matakuliah (id_matakuliah, nama_matakuliah) VALUES 
(1, 'Matematika'), (2, 'Fisika'), (3, 'Kimia');

CREATE TABLE nilai 
(id_nilai INT PRIMARY KEY AUTO_INCREMENT, id_mahasiswa INT, id_matakuliah INT, nilai INT, 
FOREIGN KEY (id_mahasiswa) REFERENCES Mahasiswa(id_mahasiswa), 
FOREIGN KEY (id_matakuliah) REFERENCES MataKuliah(id_matakuliah));

INSERT INTO nilai (id_mahasiswa, id_matakuliah, nilai) VALUES 
(1, 1, 85), (2, 1, 90), (3, 2, 78);

DROP PROCEDURE IF EXISTS tambah_nilai;
DELIMITER $$
CREATE PROCEDURE tambah_nilai (
    IN p_id_mahasiswa INT,
    IN p_id_matakuliah INT,
    IN p_nilai INT
)
BEGIN
    INSERT INTO nilai (id_mahasiswa, id_matakuliah, nilai) 
    VALUES (p_id_mahasiswa, p_id_matakuliah, p_nilai);
END$$
DELIMITER ;

CALL tambah_nilai (2, 2, 88);

SELECT * FROM nilai;

DROP PROCEDURE IF EXISTS update_nilai;
DELIMITER $$
CREATE PROCEDURE update_nilai (
    IN p_id_nilai INT,
    IN p_nilai INT
)
BEGIN
    UPDATE nilai 
    SET nilai = p_nilai
    WHERE id_nilai = p_id_nilai;
END$$
DELIMITER ;

CALL update_nilai (4, 100);

SELECT * FROM nilai;
 
DROP PROCEDURE IF EXISTS hapus_nilai;
DELIMITER $$
CREATE PROCEDURE hapus_nilai (
    IN p_id_nilai INT
)
BEGIN
    DELETE FROM nilai
    WHERE id_nilai = p_id_nilai;
END$$
DELIMITER ;

CALL hapus_nilai (4);

SELECT * FROM nilai;


-- CONTOH PENGGUNAAN FUNCTION
DROP FUNCTION IF EXISTS hitung_rata_rata;
DELIMITER $$
CREATE FUNCTION hitung_rata_rata(p_id_mahasiswa INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE rata_rata DECIMAL(5,2);
    
    SELECT AVG(nilai) INTO rata_rata
    FROM nilai
    WHERE id_mahasiswa = p_id_mahasiswa;
    
    RETURN COALESCE(rata_rata, 0);
END$$
DELIMITER ;

SELECT hitung_rata_rata(2) AS rata_rata_mahasiswa; AS rata_rata_mahasiswa;

DROP FUNCTION IF EXISTS get_nama_matakuliah;
DELIMITER $$
CREATE FUNCTION get_nama_matakuliah (p_id_matakuliah INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nama VARCHAR(100);
    SELECT nama_matakuliah INTO nama
    FROM matakuliah
    WHERE id_matakuliah = p_id_matakuliah;
    RETURN COALESCE (nama, 'Tidak Ditemukan');
END$$
DELIMITER ;

SELECT get_nama_matakuliah(100) AS nama_matakuliah; AS nama_matakuliah;

DROP FUNCTION IF EXISTS hitung_total_mahasiswa;
DELIMITER $$
CREATE FUNCTION hitung_total_mahasiswa (p_id_mahasiswa INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM nilai
    WHERE id_mahasiswa = p_id_mahasiswa;
    RETURN COALESCE (total, 0);
END$$
DELIMITER ;

SELECT hitung_total_mahasiswa (3) AS total_nilai_mahasiswa;

DROP PROCEDURE IF EXISTS cek_status_mahasiswa;
DELIMITER $$
CREATE PROCEDURE cek_status_mahasiswa (
    IN p_id_mahasiswa INT,
    OUT p_status VARCHAR(50)
)
BEGIN
    DECLARE rata_rata DECIMAL(5,2);
    
    SELECT AVG(nilai) INTO rata_rata
    FROM nilai
    WHERE id_mahasiswa = p_id_mahasiswa;

    IF rata_rata >= 85 THEN
        SET p_status = 'Sangat Baik';
    ELSEIF rata_rata >= 70 THEN
        SET p_status = 'Baik';
    ELSE
        SET p_status = 'Perlu Peningkatan';
    END IF;
END$$
DELIMITER ;

CALL cek_status_mahasiswa (2, @status);

SELECT @status AS status_mahasiswa;

DROP PROCEDURE IF EXISTS kategori_mahasiswa;
DELIMITER $$
CREATE PROCEDURE kategori_mahasiswa (
    IN p_id_mahasiswa INT,
    OUT p_kategori VARCHAR(50)
)
BEGIN
    DECLARE p_nilai_rata DECIMAL(5,2);

    SELECT AVG(nilai) INTO p_nilai_rata
    FROM nilai
    WHERE id_mahasiswa = p_id_mahasiswa;

    SET p_kategori = 
        CASE 
            WHEN p_nilai_rata >= 85 THEN 'sangat baik'
            WHEN p_nilai_rata >= 70 THEN 'baik'
            ELSE 'perlu peningkatan'
        END;
END$$
DELIMITER ;

CALL kategori_mahasiswa (1, @kategori);

SELECT @kategori AS kategori_mahasiswa;

DROP PROCEDURE IF EXISTS hitung_total_nilai;
DELIMITER $$
CREATE PROCEDURE hitung_total_nilai (
    IN p_id_mahasiswa INT,
    OUT p_total_nilai INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE nilai INT;
    DECLARE cur CURSOR FOR SELECT nilai FROM nilai WHERE id_mahasiswa = p_id_mahasiswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET p_total_nilai = 0;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO nilai;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET p_total_nilai = p_total_nilai + nilai;
    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;

CALL hitung_total_nilai (1, @total_nilai);

SELECT @total_nilai AS total_nilai_mahasiswa;

 --- End of file: procedurepraktikum.sql

 --- Start Praktikum Trigger

CREATE TABLE log_nilai (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    id_matakuliah INT,
    nilai INT,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER after_nilai_insert
AFTER INSERT ON nilai
FOR EACH ROW
BEGIN
    INSERT INTO log_nilai (id_mahasiswa, id_matakuliah, nilai)
    VALUES (NEW.id_mahasiswa, NEW.id_matakuliah, NEW.nilai);
END;

INSERT INTO nilai (id_mahasiswa, id_matakuliah, nilai) VALUES (2, 3, 120);

CREATE TRIGGER before_insert_nilai
BEFORE INSERT ON nilai  
FOR EACH ROW
BEGIN
    IF NEW.nilai < 0 OR NEW.nilai > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nilai harus antara 0 dan 100';
    END IF;
END;

SELECT * FROM log_nilai;

SELECT* FROM nilai;

ALTER Table mahasiswa ADD rata DECIMAL(5,2);

CREATE TRIGGER before_insert_nilai
BEFORE INSERT ON nilai
FOR EACH ROW
BEGIN
    IF NEW.nilai < 0 OR NEW.nilai > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nilai harus berada dalam rentang 0 hingga 100';
    END IF;
END;

UPDATE nilai SET nilai = 95 WHERE id_nilai = 9;

SELECT * FROM mahasiswa;



-- Tugas Bisnis Intellegent - Procedure & Trigger at SQL
-- ===================================================================
-- Nama   : Bagas Ardi Pratama Putra
-- NIM    : 2310244
-- Kelas : Sistem Informasi Kelautan - A5
-- ===================================================================

CREATE TABLE IF NOT EXISTS mahasiswa (
  id_mahasiswa INT PRIMARY KEY,
  nama VARCHAR(100),
  total_nilai DECIMAL(18,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS nilai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_mahasiswa INT NOT NULL,
  nilai DECIMAL(5,2) NOT NULL,
  CONSTRAINT fk_nilai_mahasiswa FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa)
);

CREATE TABLE IF NOT EXISTS log_nilai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_mahasiswa INT,
  nilai DECIMAL(18,2),
  deleted_at DATETIME
);

DELIMITER //

-- 1) Latihan Kondisional: Buat prosedur cek_kelulusan yang menerima ID mahasiswa dan mengevaluasi apakah mahasiswa tersebut lulus atau tidak berdasarkan nilai rata-rata. Jika rata-rata >= 75, mahasiswa dinyatakan lulus.

CREATE OR REPLACE PROCEDURE cek_kelulusan(IN p_id_mahasiswa INT)
BEGIN
  DECLARE v_rata DECIMAL(6,2);

  SELECT AVG(COALESCE(n.nilai, 0))
    INTO v_rata
    FROM nilai n
   WHERE n.id_mahasiswa = p_id_mahasiswa;

  IF v_rata IS NULL THEN
    SELECT CONCAT('Tidak ada nilai untuk mahasiswa ', p_id_mahasiswa) AS pesan;
  ELSEIF v_rata >= 75 THEN
    SELECT CONCAT('Mahasiswa ', p_id_mahasiswa, ' dinyatakan lulus. Rata-rata: ', FORMAT(v_rata, 2)) AS pesan;
  ELSE
    SELECT CONCAT('Mahasiswa ', p_id_mahasiswa, ' dinyatakan tidak lulus. Rata-rata: ', FORMAT(v_rata, 2)) AS pesan;
  END IF;
END //

-- 2) Latihan Looping: Buat prosedur total_nilai_semua_mahasiswa yang menghitung total nilai seluruh mahasiswa dalam tabel nilai dengan menggunakan loop.

CREATE OR REPLACE PROCEDURE total_nilai_semua_mahasiswa(OUT p_total DECIMAL(18,2))
BEGIN
  DECLARE v_nilai DECIMAL(18,2);
  DECLARE done INT DEFAULT 0;
  DECLARE cur_nilai CURSOR FOR SELECT COALESCE(n.nilai, 0) FROM nilai n;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SET p_total = 0;
  OPEN cur_nilai;
  read_loop: LOOP
    FETCH cur_nilai INTO v_nilai;
    IF done = 1 THEN LEAVE read_loop; END IF;
    SET p_total = p_total + v_nilai;
  END LOOP;
  CLOSE cur_nilai;

  SELECT CONCAT('Total nilai seluruh mahasiswa: ', FORMAT(p_total, 2)) AS pesan;
END //

-- 3) Latihan Error Handling: Buat prosedur cari_nama_matakuliah yang menerima ID mata kuliah dan mengembalikan nama mata kuliah. Jika ID mata kuliah tidak ditemukan, tampilkan pesan 'Mata kuliah tidak ditemukan'.

CREATE OR REPLACE PROCEDURE cari_nama_matakuliah(
  IN p_id_matakuliah INT,
  OUT p_nama VARCHAR(255)
)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SELECT m.nama_matakuliah
    INTO p_nama
    FROM mata_kuliah m
   WHERE m.id_matakuliah = p_id_matakuliah;

  IF done = 1 THEN
    SET p_nama = NULL;
    SELECT 'Mata kuliah tidak ditemukan' AS pesan;
  ELSE
    SELECT CONCAT('Nama mata kuliah: ', p_nama) AS pesan;
  END IF;
END //

DELIMITER ;

-- ===================================================================
-- Triggers 
-- ===================================================================
DELIMITER //

-- 1) Buat trigger yang memblokir penghapusan data dari tabel nilai jika nilai tersebut di bawah 50.
CREATE OR REPLACE TRIGGER trg_nilai_block_delete_low
BEFORE DELETE ON nilai
FOR EACH ROW
BEGIN
  IF OLD.nilai < 50 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penghapusan ditolak: nilai di bawah 50';
  END IF;
END //

-- 2) Buat trigger AFTER DELETE yang mencatat data yang dihapus dari tabel nilai ke tabel log.

CREATE OR REPLACE TRIGGER trg_nilai_after_delete_log
AFTER DELETE ON nilai
FOR EACH ROW
BEGIN
  INSERT INTO log_nilai(id_mahasiswa, nilai, deleted_at)
  VALUES (OLD.id_mahasiswa, OLD.nilai, NOW());
END //

-- 3) Buat trigger BEFORE UPDATE yang menambahkan kolom total_nilai di tabel mahasiswa, di mana total_nilai adalah total semua nilai mahasiswa di tabel nilai.
CREATE OR REPLACE TRIGGER trg_mahasiswa_before_update_total
BEFORE UPDATE ON mahasiswa
FOR EACH ROW
BEGIN
  SET NEW.total_nilai = (
    SELECT COALESCE(SUM(n.nilai), 0)
      FROM nilai n
     WHERE n.id_mahasiswa = NEW.id_mahasiswa
  );
END //

DELIMITER ;

INSERT INTO mahasiswa (id_mahasiswa, nama) VALUES
  (1, 'Iman'),
  (2, 'Bagas')
ON DUPLICATE KEY UPDATE nama = VALUES(nama);

INSERT INTO nilai (id_mahasiswa, nilai) VALUES
  (1, 80.00),
  (1, 70.00),
  (2, 40.00)
ON DUPLICATE KEY UPDATE nilai = VALUES(nilai);
CALL cek_kelulusan(1);
CALL cek_kelulusan(2);
CALL total_nilai_semua_mahasiswa(@total_semua);
SELECT @total_semua AS total_semua;
DELETE FROM nilai WHERE id_mahasiswa = 2 AND nilai = 40.00;

DELETE FROM nilai WHERE id_mahasiswa = 1 AND nilai = 70.00;

SELECT * FROM log_nilai;

UPDATE mahasiswa SET nama = nama;
SELECT id_mahasiswa, total_nilai FROM mahasiswa;
