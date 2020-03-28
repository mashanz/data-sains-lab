library(RMySQL)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Konstruksi SQL untuk Profil 1
sql <- "SELECT left(no_telepon,1) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '999999999999999'
group by left(no_telepon,1), pola_no_telepon"

#Mengirimkan query untuk Profil 1
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 1
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 1
dbClearResult(rs)

#Konstruksi SQL untuk Profil 2
sql <- "SELECT left(no_telepon,2) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '9999999999999999'
group by left(no_telepon,2), pola_no_telepon"

#Mengirimkan query untuk Profil 2
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 2
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 2
dbClearResult(rs)

#Konstruksi SQL untuk Profil 3
sql <- "SELECT left(no_telepon,3) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '+9999999999999999'
group by left(no_telepon,3), pola_no_telepon"

#Mengirimkan query untuk Profil 3
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 3
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 3
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
