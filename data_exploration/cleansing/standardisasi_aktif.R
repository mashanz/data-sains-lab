library(RMySQL)
library(openxlsx)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Konstruksi SQL
sql <- "select kode_pelanggan, aktif, pola_aktif from dqlab_messy_data"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
data_aktif <- fetch(rs, n=-1)
data_aktif$aktif <- gsub("I","1",  data_aktif$aktif)
data_aktif$aktif <- gsub("O","0",  data_aktif$aktif)
data_aktif$aktif <- gsub("TRUE","1",  data_aktif$aktif)
data_aktif$aktif <- gsub("FALSE","0",  data_aktif$aktif)
print(data_aktif)

#Menulis output ke file Excel
write.xlsx(file="staging.aktif.xlsx", x=data_aktif)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
