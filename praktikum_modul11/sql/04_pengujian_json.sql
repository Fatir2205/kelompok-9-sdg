--1.INSERT
USE praktikum_modul11;

-- Bersihkan data lama jika ingin di-reset (opsional)
-- TRUNCATE TABLE ruas_jalan;

-- Data ke-1: Atribut fokus pada transportasi umum & persimpangan
INSERT INTO ruas_jalan (nama_ruas, jenis_jalan, panjang, lebar_jalan, kecepatan_normal, geometri, total_kendaraan) 
VALUES ('Jl. Serayu', 'Protokol', 5.40, 12.50, 60, '{
    "koordinat_awal": [-7.62, 111.52],
    "koordinat_akhir": [-7.63, 111.53],
    "jalur_khusus_bus": true,
    "titik_persimpangan": ["Simpang Serayu", "Tugu Pendekar"]
}', 350);

-- Data ke-2: Atribut fokus pada zona khusus & aturan lalu lintas
INSERT INTO ruas_jalan (nama_ruas, jenis_jalan, panjang, lebar_jalan, kecepatan_normal, geometri, total_kendaraan) 
VALUES ('Jl. Salak', 'Arteri', 8.20, 14.00, 50, '{
    "koordinat_awal": [-7.61, 111.51],
    "koordinat_akhir": [-7.64, 111.54],
    "zona_sekolah": true,
    "pembatasan_truk": "Jam Sibuk"
}', 480);

-- Data ke-3: Atribut fokus pada fasilitas infrastruktur jalan
INSERT INTO ruas_jalan (nama_ruas, jenis_jalan, panjang, lebar_jalan, kecepatan_normal, geometri, total_kendaraan) 
VALUES ('Jl. Asahan', 'Protokol', 8.35, 14.50, 60, '{
    "koordinat_awal": [-7.65, 111.55],
    "koordinat_akhir": [-7.67, 111.57],
    "lampu_penerangan": "LED",
    "jalur_sepeda": true,
    "kondisi_permukaan": "Aspal Mulus"
}', 410);



-- 2.SELECT
SELECT 
    nama_ruas,
    jenis_jalan,
    -- Membaca atribut unik dari masing-masing ruas
    JSON_EXTRACT(geometri, '$.jalur_khusus_bus') AS jalur_bus,
    JSON_EXTRACT(geometri, '$.zona_sekolah') AS zona_sekolah,
    JSON_EXTRACT(geometri, '$.lampu_penerangan') AS penerangan
FROM ruas_jalan;




-- 3.UPDATE
-- 1. Gunakan database Anda
USE praktikum_modul11;

-- 2. Menambahkan atribut baru 'kondisi_rambu' ke dalam data JSON geometri untuk Jl. Serayu
UPDATE ruas_jalan
SET geometri = JSON_SET(
    geometri,
    '$.kondisi_rambu',
    'Baik'
)
WHERE nama_ruas = 'Jl. Serayu';

-- 3. Memeriksa hasil penambahan atribut tersebut
SELECT 
    nama_ruas,
    geometri
FROM ruas_jalan
WHERE nama_ruas = 'Jl. Serayu';
```[cite: 5]



-- 4.REMOVE
UPDATE ruas_jalan
SET geometri = JSON_REMOVE(
    geometri,
    '$.jalur_khusus_bus'
)
WHERE nama_ruas = 'Jl. Serayu';

-- Dan untuk memeriksa hasil penghapusan tersebut:

SELECT 
    nama_ruas,
    geometri
FROM ruas_jalan;

