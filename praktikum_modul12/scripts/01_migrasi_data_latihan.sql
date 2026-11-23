### 1. Masukkan Data Ruas Jalan 1 (Jl. Serayu)
PUT https://localhost:9200/ruas_jalan/_doc/1
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "id_ruas": 1,
  "nama_ruas": "Jl. Serayu",
  "jenis_jalan": "Protokol",
  "panjang": 5.40,
  "lebar_jalan": 12.50,
  "kecepatan_normal": 60,
  "total_kendaraan": 350,
  "geometri": {
    "koordinat_awal": [-7.62, 111.52],
    "koordinat_akhir": [-7.63, 111.53],
    "jalur_khusus_bus": true,
    "titik_persimpangan": ["Simpang Serayu", "Tugu Pendekar"]
  }
}

  

### 2. Masukkan Data Ruas Jalan 2 (Jl. Salak)
PUT https://localhost:9200/ruas_jalan/_doc/2
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "id_ruas": 2,
  "nama_ruas": "Jl. Salak",
  "jenis_jalan": "Arteri",
  "panjang": 8.20,
  "lebar_jalan": 14.00,
  "kecepatan_normal": 50,
  "total_kendaraan": 480,
  "geometri": {
    "koordinat_awal": [-7.61, 111.51],
    "koordinat_akhir": [-7.64, 111.54],
    "zona_sekolah": true,
    "pembatasan_truk": "Jam Sibuk"
  }
}


  
### 3. Masukkan Data Ruas Jalan 3 (Jl. Asahan)
PUT https://localhost:9200/ruas_jalan/_doc/3
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "id_ruas": 3,
  "nama_ruas": "Jl. Asahan",
  "jenis_jalan": "Protokol",
  "panjang": 8.35,
  "lebar_jalan": 14.50,
  "kecepatan_normal": 60,
  "total_kendaraan": 410,
  "geometri": {
    "koordinat_awal": [-7.65, 111.55],
    "koordinat_akhir": [-7.67, 111.57],
    "lampu_penerangan": "LED",
    "jalur_sepeda": true,
    "kondisi_permukaan": "Aspal Mulus"
  }
}



  
### Script & Hasil Query di Elasticsearch
GET https://localhost:9200/ruas_jalan/_search
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "_source": ["nama_ruas", "jenis_jalan", "total_kendaraan"],
  "query": {
    "bool": {
      "filter": [
        { "term": { "jenis_jalan": "Protokol" } },
        { "range": { "total_kendaraan": { "gt": 380 } } }
      ]
    }
  }
}

