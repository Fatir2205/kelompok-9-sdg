-- 1. sebelum
EXPLAIN SELECT 
    rj.id_ruas, 
    rj.nama_ruas, 
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM rkpl_db.ruas_jalan rj
JOIN rkpl_db.kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY rj.id_ruas, rj.nama_ruas;


-- 2. sesudah
CREATE INDEX idx_kepadatan_id_ruas ON rkpl_db.kepadatan(id_ruas);

EXPLAIN SELECT 
    rj.id_ruas, 
    rj.nama_ruas, 
    SUM(k.jumlah_kendaraan) AS total_kendaraan
FROM rkpl_db.ruas_jalan rj
JOIN rkpl_db.kepadatan k ON rj.id_ruas = k.id_ruas
GROUP BY rj.id_ruas, rj.nama_ruas;
