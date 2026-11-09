Tahap 2 - Implementasi Basis Data
-- 1. Tabel Ruas_Jalan (Entitas Master)
CREATE TABLE rkpl_db.Ruas_Jalan (
    id_ruas INT PRIMARY KEY,
    nama_ruas VARCHAR(100) NOT NULL,
    jenis_jalan VARCHAR(50),
    panjang DECIMAL(10,2),
    lebar_jalan DECIMAL(5,2),
    kecepatan_normal DECIMAL(5,2),
    geometri TEXT
);

-- 2. Tabel Kepadatan (Relasi 1 ke N dari Ruas_Jalan)
CREATE TABLE rkpl_db.Kepadatan (
    id_kepadatan INT PRIMARY KEY,
    id_ruas INT,
    waktu DATETIME,
    jumlah_kendaraan INT,
    kecepatan_rata2 DECIMAL(5,2),
    tingkat_kepadatan VARCHAR(50),
    FOREIGN KEY (id_ruas) REFERENCES rkpl_db.Ruas_Jalan(id_ruas)
);

-- 3. Tabel Rute (Entitas Master)
CREATE TABLE rkpl_db.Rute (
    id_rute INT PRIMARY KEY,
    jenis_rute VARCHAR(50),
    total_jarak DECIMAL(10,2),
    eta VARCHAR(50),
    sisa_jarak DECIMAL(10,2)
);

-- 4. Tabel Penghubung 'melewati' (Relasi Many-to-Many antara Ruas_Jalan dan Rute)
CREATE TABLE rkpl_db.Melewati (
    id_ruas INT,
    id_rute INT,
    urutan INT,
    PRIMARY KEY (id_ruas, id_rute),
    FOREIGN KEY (id_ruas) REFERENCES rkpl_db.Ruas_Jalan(id_ruas),
    FOREIGN KEY (id_rute) REFERENCES rkpl_db.Rute(id_rute)
);

-- 5. Tabel Lokasi (Entitas Master)
CREATE TABLE rkpl_db.Lokasi (
    id_lokasi INT PRIMARY KEY,
    nama_lokasi VARCHAR(100),
    alamat TEXT,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8)
);

-- 6. Tabel Perjalanan (Relasi ke Rute dan Lokasi)
CREATE TABLE rkpl_db.Perjalanan (
    id_perjalanan INT PRIMARY KEY,
    id_rute INT,
    id_lokasi INT,
    waktu_mulai DATETIME,
    status VARCHAR(50),
    posisi_asal VARCHAR(100),
    FOREIGN KEY (id_rute) REFERENCES rkpl_db.Rute(id_rute),
    FOREIGN KEY (id_lokasi) REFERENCES rkpl_db.Lokasi(id_lokasi)
);


-- 1. Mengisi Data ke Tabel Ruas_Jalan
INSERT INTO rkpl_db.Ruas_Jalan (id_ruas, nama_ruas, jenis_jalan, panjang, lebar_jalan, kecepatan_normal, geometri) VALUES
(1, 'Jl. Serayu', 'Kolektor', 2.50, 10.00, 40.00, 'LINESTRING(... )'),
(2, 'Jl. Salak', 'Lokal', 1.20, 6.00, 30.00, 'LINESTRING(... )');

-- 2. Mengisi Data ke Tabel Kepadatan (Relasi ke Ruas_Jalan)
INSERT INTO rkpl_db.Kepadatan (id_kepadatan, id_ruas, waktu, jumlah_kendaraan, kecepatan_rata2, tingkat_kepadatan) VALUES
(1, 1, '2026-10-29 07:30:00', 320, 25.00, 'Padat'),
(2, 1, '2026-10-29 17:00:00', 450, 18.00, 'Sangat Padat'),
(3, 2, '2026-10-29 08:00:00', 90,  28.00, 'Lancar');

-- 3. Mengisi Data ke Tabel Rute
INSERT INTO rkpl_db.Rute (id_rute, jenis_rute, total_jarak, eta, sisa_jarak) VALUES
(101, 'Tercepat', 3.70, '15 Menit', 0.00),
(102, 'Alternatif', 4.10, '20 Menit', 1.20);

-- 4. Mengisi Data ke Tabel Lokasi
INSERT INTO rkpl_db.Lokasi (id_lokasi, nama_lokasi, alamat, latitude, longitude) VALUES
(1, 'Stasiun Madiun', 'Jl. Kompol Sunarto', -7.62980000, 111.52510000),
(2, 'Alun-Alun Madiun', 'Jl. Pahlawan', -7.63150000, 111.52380000);

-- 5. Mengisi Data ke Tabel Perjalanan (Relasi ke Rute dan Lokasi)
INSERT INTO rkpl_db.Perjalanan (id_perjalanan, id_rute, id_lokasi, waktu_mulai, status, posisi_asal) VALUES
(1001, 101, 1, '2026-10-29 07:00:00', 'Aktif', 'Jl. Serayu'),
(1002, 102, 2, '2026-10-29 07:15:00', 'Selesai', 'Jl. Salak');


Tahap 3 – Praktik Operasi Database (CRUD)
    --CREATE 
   INSERT INTO ruas_jalan (nama_ruas, jenis_jalan, panjang, lebar_jalan, kecepatan_normal) VALUES
('Jl. Asahan', 'Protokol', 3.50, 12.00, 50.00),
('Jl. Diponegoro', 'Arteri', 2.00, 14.00, 60.00);
  --READ
SELECT * FROM ruas_jalan
  --UPDATE 
UPDATE ruas_jalan SET nama_ruas = 'Jl. Diponegoro' WHERE id_ruas = 3;
UPDATE ruas_jalan SET nama_ruas = 'Jl. Asahan' WHERE id_ruas = 4;
-- DELETE
DELETE FROM kepadatan WHERE id_kepadatan = 3;
   --Menguji Integritas Referensial

INSERT INTO kepadatan (id_kepadatan, id_ruas, jumlah_kendaraan) VALUES (999, 99, 100);
DELETE FROM ruas_jalan WHERE id_ruas = 1;


Tahap 4 – Pengujian Transaksi Database
  --ROLLBACK
  START TRANSACTION;
-- Step 1: Tambah data kepadatan baru
INSERT INTO kepadatan (id_ruas, jumlah_kendaraan) VALUES (1, 300);
-- Step 2: Update kolom denormalisasi di ruas_jalan
UPDATE ruas_jalan 
SET total_kendaraan = total_kendaraan + 300 
WHERE id_ruas = 1;
-- Skenario simulasi kesalahan / pembatalan bisnis
ROLLBACK; 
-- Hasil Check: Data tidak berubah di database (di-restore ke kondisi awal)
SELECT total_kendaraan FROM ruas_jalan WHERE id_ruas = 1;

  --COOMMIT
  START TRANSACTION;
-- Step 1: Tambah data kepadatan baru
INSERT INTO kepadatan (id_ruas, jumlah_kendaraan) VALUES (1, 300);
-- Step 2: Update kolom denormalisasi di ruas_jalan
UPDATE ruas_jalan 
SET total_kendaraan = total_kendaraan + 300 
WHERE id_ruas = 1;
-- Simpan secara permanen
COMMIT;
-- Hasil Check: Data berhasil diperbarui secara permanen di database
SELECT total_kendaraan FROM ruas_jalan WHERE id_ruas = 1;



Tahap 5 - Analisis performa database
-- 1. sebelum
EXPLAIN SELECT
    rj.id_ruas,
    rj.nama_ruas,
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM rkp1_db.ruas_jalan rj
JOIN rkp1_db.kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY rj.id_ruas, rj.nama_ruas;
-- 2. sesudah
CREATE INDEX idx_kepadatan_id_ruas ON rkp1_db.kepadatan(id_ruas);

EXPLAIN SELECT
    rj.id_ruas,
    rj.nama_ruas,
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM rkp1_db.ruas_jalan rj
JOIN rkp1_db.kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY rj.id_ruas, rj.nama_ruas;
