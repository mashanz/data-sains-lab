library(openxlsx)

#Membaca tiap file staging Excel dan menyimpannya dalam variable bernama awalan staging 
staging.nama <- read.xlsx("staging.nama.xlsx")
staging.no_telepon <- read.xlsx("staging.no_telepon.xlsx")
staging.kode_pos <- read.xlsx("staging.kode_pos.xlsx")
staging.alamat <- read.xlsx("staging.alamat.xlsx")
staging.aktif <- read.xlsx("staging.aktif.xlsx")

#Menggabungkan variable staging dengan function merge
staging.teks <- merge(x=staging.nama, y=staging.no_telepon, by.x = "kode_pelanggan", by.y = "kode_pelanggan", all = TRUE)
staging.teks <- merge(x=staging.teks, y=staging.kode_pos, by.x = "kode_pelanggan", by.y = "kode_pelanggan", all = TRUE)
staging.teks <- merge(x=staging.teks, y=staging.alamat, by.x = "kode_pelanggan", by.y = "kode_pelanggan", all = TRUE)
staging.teks <- merge(x=staging.teks, y=staging.aktif, by.x = "kode_pelanggan", by.y = "kode_pelanggan", all = TRUE)
staging.teks <- staging.teks[c("kode_pelanggan","nama", "alamat", "no_telepon", "anomali_no_telepon", "kode_pos")]
write.xlsx(file="staging.teks.xlsx", staging.teks)
