library(RMySQL)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Melakukan query data untuk format tanggal yang memiliki huruf dengan regex [A-Za-z]
sql <- "SELECT tanggal_lahir from dqlab_messy_data where tanggal_lahir REGEXP '[A-Za-z]'"
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
data.pelanggan <- fetch(rs, n=-1)
dbClearResult(rs)

# Menghapus karakter digit dan spasi dengan function gsub dan pola regex [0-9 ].
data.pelanggan$tanggal_lahir <- gsub('[0-9 ]','', data.pelanggan$tanggal_lahir)

#Melakukan grouping nama bulan dengan function unique
unique(data.pelanggan$tanggal_lahir)

#Menutup seluruh koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons)
    + dbDisconnect(con)
