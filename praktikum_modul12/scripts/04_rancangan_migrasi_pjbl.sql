### 1. Rancangan Perubahan Skema Indeks navimadiun_kel9
PUT https://localhost:9200/navimadiun_kel9
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "mappings": {
    "properties": {
      "id_ruas": { "type": "integer" },
      "nama_ruas": { "type": "keyword" },
      "jenis_jalan": { "type": "keyword" },
      "lebar_jalan": { "type": "float" },
      "panjang": { "type": "float" },
      "kelayakan": { "type": "boolean" },
      "kecepatan_normal": { "type": "integer" },
      "kepadatan_terkini": {
        "properties": {
          "tingkat_kepadatan": { "type": "keyword" },
          "jumlah_kendaraan": { "type": "integer" },
          "kecepatan_rata2": { "type": "integer" },
          "waktu_pencatatan": { "type": "date" }
        }
      },
      "lokasi_koordinat": { "type": "geo_point" }
    }
  }
}

  

### 2. Migrasi Data Ruas Jalan ke navimadiun_kel9
PUT https://localhost:9200/navimadiun_kel9/_doc/1
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "id_ruas": 1,
  "nama_ruas": "Jl. Pahlawan Madiun",
  "jenis_jalan": "Utama",
  "lebar_jalan": 14.0,
  "panjang": 3.5,
  "kelayakan": true,
  "kecepatan_normal": 50,
  "kepadatan_terkini": {
    "tingkat_kepadatan": "Merah",
    "jumlah_kendaraan": 510,
    "kecepatan_rata2": 15,
    "waktu_pencatatan": "2026-11-19T08:30:00Z"
  },
  "lokasi_koordinat": {
    "lat": -7.6298,
    "lon": 111.5239
  }
}



### 3. Query Teroptimasi pada navimadiun_kel9
GET https://localhost:9200/navimadiun_kel9/_search
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "_source": ["nama_ruas", "jenis_jalan", "kepadatan_terkini.tingkat_kepadatan", "kepadatan_terkini.kecepatan_rata2"],
  "query": {
    "bool": {
      "filter": [
        { "term": { "kelayakan": true } },
        { "terms": { "kepadatan_terkini.tingkat_kepadatan": ["Merah", "Merah Tua"] } }
      ]
    }
  }
}




### 4. Membuat Role DCL Petugas Lalu Lintas (navimadiun_kel9)
POST https://localhost:9200/_security/role/petugas_lalin_kel9
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "indices": [
    {
      "names": ["navimadiun_kel9"],
      "privileges": ["read", "index", "write"]
    }
  ]
}



  
### 5. Membuat User Petugas Patroli (navimadiun_kel9)
POST https://localhost:9200/_security/user/patroli_kel9_01
Authorization: Basic elastic OyPadnf==5Rp9U9m2JxX
Content-Type: application/json

{
  "password": "NaviMadiunKel9Password!",
  "roles": ["petugas_lalin_kel9"],
  "full_name": "Petugas Lalu Lintas NaviMadiun Kelompok 9"
}

