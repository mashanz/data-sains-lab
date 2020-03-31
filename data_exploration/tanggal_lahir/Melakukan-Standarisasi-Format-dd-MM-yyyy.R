library(RMySQL)
library(reshape2)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")
#Mengambil data yang memiliki tanda garis miring /
sql <- "select tanggal_lahir from dqlab_messy_data where tanggal_lahir like '%/%'"

rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan <- fetch(rs, n=-1)
dbClearResult(rs)
#Melakukan split dan menyimpannya ke variable tanggal.split dengan urutan bulan, hari dan tahun
tanggal.split <- colsplit(data.pelanggan$tanggal_lahir,"/",c("bulan","hari","tahun"))

#Menggabungkan kembali dalam urutan hari, bulan dan tahun dan menyimpannya kembali ke data.pelanggan$tanggal_lahir
data.pelanggan$tanggal_lahir <- paste(tanggal.split$hari, tanggal.split$bulan, tanggal.split$tahun, sep="-")
data.pelanggan$tanggal_lahir 
#Menutup seluruh koneksi MySQL
all_cons <- dbListConnections(MySQL())
for(con in all_cons)
    + dbDisconnect(con)
