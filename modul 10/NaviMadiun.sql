Tahap 4 – Pengujian Transaksi Database
1. ROLLBACK
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
2. COMMIT
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
