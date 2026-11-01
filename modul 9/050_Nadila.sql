SELECT 
    rj.id_ruas,
    rj.nama_ruas,
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM 
    ruas_jalan rj
JOIN 
    kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY 
    rj.id_ruas, 
    rj.nama_ruas;     cara cek query diatas sudah berhasil a[a nelu,

-- Menambahkan kolom turunan ke tabel ruas_jalan
ALTER TABLE ruas_jalan 
ADD COLUMN total_kendaraan INT DEFAULT 0;

-- Mengisi nilai awal ke kolom denormalisasi berdasarkan hasil perhitungan sebelumnya
UPDATE ruas_jalan rj
SET total_kendaraan = (
    SELECT COALESCE(SUM(k.jumlah_kendaraan), 0)
    FROM kepadatan k
    WHERE k.id_ruas = rj.id_ruas
);

-- Memanggil data tanpa JOIN / Agregasi langsung dari tabel ruas_jalan
SELECT 
    id_ruas,
    nama_ruas,
    total_kendaraan
FROM 
    ruas_jalan;
