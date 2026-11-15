-- 1.RUAS JALAN
-- Pastikan menggunakan database yang aktif
USE praktikum_modul11;

-- Perintah untuk membuat tabel ruas_jalan
CREATE TABLE ruas_jalan (
    id_ruas INT AUTO_INCREMENT PRIMARY KEY,
    nama_ruas VARCHAR(100) NOT NULL,
    jenis_jalan VARCHAR(50) NOT NULL,
    panjang DECIMAL(8, 2) NOT NULL,
    lebar_jalan DECIMAL(5, 2) NOT NULL,
    kecepatan_normal INT NOT NULL,
    geometri JSON NOT NULL, -- Implementasi kolom tipe data JSON untuk data semi-terstruktur/spasial
    total_kendaraan INT DEFAULT 0
) ENGINE=InnoDB;




-- 2.KATEGORI JALAN
CREATE TABLE kategori_jalan (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

INSERT INTO kategori_jalan (nama_kategori) VALUES ('Protokol'), ('Arteri');

UPDATE ruas_jalan 
SET id_kategori = 1 
WHERE id_kategori = 0;

ALTER TABLE ruas_jalan 
ADD CONSTRAINT fk_id_kategori 
FOREIGN KEY (id_kategori) 
REFERENCES kategori_jalan (id_kategori);
