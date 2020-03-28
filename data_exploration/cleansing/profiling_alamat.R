library(RMySQL)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")
#Konstruksi SQL
sql <- "SELECT kode_pelanggan, alamat, pola_alamat from dqlab_messy_data where pola_alamat REGEXP '^[aAw]+$' or pola_alamat REGEXP '^[9w]+$'"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
data_alamat <- fetch(rs, n=-1)
print(data_alamat)

#Clear resultset
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
