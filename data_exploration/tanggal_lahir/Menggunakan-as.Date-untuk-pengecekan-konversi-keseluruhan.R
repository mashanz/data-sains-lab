library(openxlsx)
#Membaca file staging Excel hasil standarisasi tanggal lahir 
data.pelanggan <- read.xlsx("staging_tanggal_lahir1.xlsx")

#Menggunakan as.Date untuk melakukan konversi kolom tanggal_lahir dan menyimpannya kembali ke kolom tersebut 
data.pelanggan$tanggal_lahir <- format(as.Date(data.pelanggan$tanggal_lahir, "%d-%m-%Y"),"%d-%m-%Y")
data.pelanggan

#Menulis hasil ke file staging_tanggal_lahir2.xlsx
write.xlsx(data.pelanggan, file="staging_tanggal_lahir2.xlsx")
