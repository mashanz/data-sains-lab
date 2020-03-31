library(RMySQL)
library(openxlsx)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Melakukan query data untuk format tanggal yang memiliki huruf dengan regex [A-Za-z]
sql <- "SELECT * from dqlab_messy_data"
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan <- fetch(rs, n=-1)
dbClearResult(rs)

#Menulis hasil ke file staging_tanggal_lahir2.xlsx
write.xlsx(data.pelanggan, file="raw.xlsx")

#Menutup seluruh koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons)
    + dbDisconnect(con)
