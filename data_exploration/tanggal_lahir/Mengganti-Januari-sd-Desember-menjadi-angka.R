library(RMySQL)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Melakukan query untuk data yang mengandung huruf alfabet
sql <- "select tanggal_lahir from dqlab_messy_data where tanggal_lahir regexp '[a-z]'"

rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan <- fetch(rs, n=-1)
dbClearResult(rs)
#Menghilangkan spasi
data.pelanggan$tanggal_lahir <- gsub(" ","", data.pelanggan$tanggal_lahir)

#Melakukan standarisasi nama bulan ke angka bulan
data.pelanggan$tanggal_lahir <- gsub("Januari","-01-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Februari","-02-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Maret","-03-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("April","-04-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Mei","-05-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Juni","-06-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Juli","-07-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Agustus","-08-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("September","-09-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Oktober","-10-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("November","-11-", data.pelanggan$tanggal_lahir)
data.pelanggan$tanggal_lahir <- gsub("Desember","-12-", data.pelanggan$tanggal_lahir)
data.pelanggan

#Menutup seluruh koneksi MySQL
all_cons <- dbListConnections(MySQL())
for(con in all_cons)
    + dbDisconnect(con)
