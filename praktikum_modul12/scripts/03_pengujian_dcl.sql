### A. GRANT Awal: Buat Role petugas_pantau dengan izin read & write pada index ruas_jalan
POST https://localhost:9200/_security/role/petugas_pantau
Authorization: Basic elastic DOkSQNduD_O5qM*VTRN6
Content-Type: application/json

{
  "indices": [
    {
      "names": ["ruas_jalan"],
      "privileges": ["read", "write"]
    }
  ]
}

### B. Buat User Uji Coba (petugas1) dengan Role petugas_pantau
POST https://localhost:9200/_security/user/petugas1
Authorization: Basic elastic DOkSQNduD_O5qM*VTRN6
Content-Type: application/json

{
  "password": "PasswordPetugas123!",
  "roles": ["petugas_pantau"],
  "full_name": "Petugas Pemantau SDG Transport"
}

### C. Uji Izin SELECT (Read) sebagai petugas1 -> Harus 200 OK
GET https://localhost:9200/ruas_jalan/_search
Authorization: Basic petugas1 PasswordPetugas123!
Content-Type: application/json

{
  "query": {
    "match_all": {}
  }
}

### D. Uji Izin DELETE sebagai petugas1 sebelum di-REVOKE -> Harus 200 OK
DELETE https://localhost:9200/ruas_jalan/_doc/1
Authorization: Basic petugas1 PasswordPetugas123!

### E. REVOKE Izin Write/Delete: Ubah Role petugas_pantau menjadi read-only (hanya read)
PUT https://localhost:9200/_security/role/petugas_pantau
Authorization: Basic elastic DOkSQNduD_O5qM*VTRN6
Content-Type: application/json

{
  "indices": [
    {
      "names": ["ruas_jalan"],
      "privileges": ["read"]
    }
  ]
}

### F. Uji Ulang DELETE sebagai petugas1 setelah REVOKE -> Harus 403 Forbidden
DELETE https://localhost:9200/ruas_jalan/_doc/2
Authorization: Basic petugas1 PasswordPetugas123!

### G. Uji Ulang SELECT sebagai petugas1 setelah REVOKE -> Tetap 200 OK
GET https://localhost:9200/ruas_jalan/_search
Authorization: Basic petugas1 PasswordPetugas123!


