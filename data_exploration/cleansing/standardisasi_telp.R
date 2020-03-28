library(RMySQL)
library(openxlsx)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Konstruksi SQL untuk Profil 1
sql <- "select kode_pelanggan, no_telepon, pola_no_telepon from dqlab_messy_data"

#Mengirimkan query untuk standarisasi no_telepon
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk standarisasi no_telepon
data.telepon <- fetch(rs, n=-1)
data.telepon$anomali_no_telepon <- TRUE

data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$no_telepon <- paste("+", data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$no_telepon, sep="")
data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$no_telepon <- gsub("^0","+62",  data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$no_telepon)
data.telepon[data.telepon$pola_no_telepon=="+9999999999999999",]$anomali_no_telepon <- FALSE 
data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$anomali_no_telepon <- FALSE 
data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$anomali_no_telepon <- FALSE
print(data.telepon)

write.xlsx(file="staging.no_telepon.xlsx", x=data.telepon)

#Clear resultset untuk standarisasi
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
