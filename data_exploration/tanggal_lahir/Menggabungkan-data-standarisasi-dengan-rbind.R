library(RMySQL)
library(reshape2)
library(openxlsx)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Mengambil data yang memiliki tanda garis miring /
sql <- "select kode_pelanggan, tanggal_lahir from dqlab_messy_data where tanggal_lahir like '%/%'"

rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan1 <- fetch(rs, n=-1)
dbClearResult(rs)
#Melakukan split dan menyimpannya ke variable tanggal.split dengan urutan bulan, hari dan tahun
tanggal.split <- colsplit(data.pelanggan1$tanggal_lahir,"/",c("bulan","hari","tahun"))

#Memperbaiki data tahun dengan format satu dan dua digit angka
tanggal.split$tahun <- sapply(tanggal.split$tahun, function(x) if(x>=0 & x<10) 2000+x else if(x>=10 & x<100) 1900+x else x)	   

#Menggabungkan kembali dalam urutan hari, bulan dan tahun dan menyimpannya kembali ke data.pelanggan$tanggal_lahir
data.pelanggan1$tanggal_lahir <- paste(tanggal.split$hari, tanggal.split$bulan, tanggal.split$tahun, sep="-")

#Mengambil data yang tidak memiliki tanda garis miring /
sql <- "select kode_pelanggan, tanggal_lahir from dqlab_messy_data where not tanggal_lahir like '%/%'"

rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan2 <- fetch(rs, n=-1)
dbClearResult(rs)

#Mengganti Januari s/d Desember menjadi angka
data.pelanggan2$tanggal_lahir <- gsub(" ","", data.pelanggan2$tanggal_lahir)

data.pelanggan2$tanggal_lahir <- gsub("Januari","-01-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Februari","-02-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Maret","-03-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("April","-04-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Mei","-05-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Juni","-06-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Juli","-07-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Agustus","-08-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("September","-09-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Oktober","-10-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("November","-11-", data.pelanggan2$tanggal_lahir)
data.pelanggan2$tanggal_lahir <- gsub("Desember","-12-", data.pelanggan2$tanggal_lahir) 
#Menggabungkan dua porsi data pelanggan secara vertikal dengan rbind sesuai urutan porsi data yang diquery
data.gabungan <- rbind(data.pelanggan1, data.pelanggan2)
data.gabungan
write.xlsx(data.gabungan, file="staging_tanggal_lahir1.xlsx")

#Menutup seluruh koneksi MySQL
all_cons <- dbListConnections(MySQL())
for(con in all_cons)
    + dbDisconnect(con)
