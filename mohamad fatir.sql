-- Query Tahap 1: JOIN + Agregasi
SELECT 
    rj.id_ruas,
    rj.nama_ruas,
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM 
    rkpl_db.ruas_jalan rj
JOIN 
    rkpl_db.kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY 
    rj.id_ruas, 
    rj.nama_ruas;

-- DDL Tahap 2: Menambahkan kolom turunan
ALTER TABLE rkpl_db.ruas_jalan 
ADD COLUMN total_kendaraan INT DEFAULT 0;

-- Mengisi nilai awal ke kolom denormalisasi berdasarkan hasil Tahap 1
UPDATE rkpl_db.ruas_jalan rj
SET total_kendaraan = (
    SELECT COALESCE(SUM(k.jumlah_kendaraan), 0)
    FROM rkpl_db.kepadatan k
    WHERE k.id_ruas = rj.id_ruas
);

-- Query Tahap 3: Memanggil data tanpa JOIN / Agregasi
SELECT 
    id_ruas,
    nama_ruas,
    total_kendaraan
FROM 
    rkpl_db.ruas_jalan;

