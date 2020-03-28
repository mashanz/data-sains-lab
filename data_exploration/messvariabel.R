library(openxlsx)
library(bpa)
#Membaca dataset pelanggan
data.pelanggan <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_messy_data_pelanggan.xlsx",
                            sheet="Pelanggan")

data.pelanggan$Aktif <- as.factor(data.pelanggan$Aktif)
#Menampilkan variable data.pelanggan
data.pelanggan
str(data.pelanggan)
summary(data.pelanggan)

# BPA
basic_pattern_analysis(x="DQLab")
basic_pattern_analysis(x="17 Agustus 1945")
basic_pattern_analysis(x=3.14)
basic_pattern_analysis(c("KD-008", "012345", "KD-010"))
basic_pattern_analysis(c("KD-008", "012345", "KD-010"), unique_only=TRUE)
basic_pattern_analysis(data.pelanggan$Kode.Pelanggan, unique_only = TRUE)
basic_pattern_analysis(data.pelanggan$Kode.Pelanggan)=="AA-9999"
data.pelanggan[ basic_pattern_analysis(data.pelanggan$Kode.Pelanggan)=="AA-9999" , ]
basic_pattern_analysis(data.pelanggan$Nama, unique_only = TRUE)

grepl(pattern="[a]", x="pelanggan")
grepl(pattern="[^a]", x="pelanggan")
grepl(pattern="[bc]", x="pelanggan")
grepl(pattern="[^bc]", x="pelanggan")
grepl(pattern="[s]", x="pelanggan")
grepl(pattern="[^s]", x="pelanggan")
grepl(pattern="aa", x="pelanggan")

data.pelanggan[grepl(pattern="[^Aaw.,]", x=basic_pattern_analysis(data.pelanggan$Nama)),]
data.pelanggan[grepl(pattern="ww", x=basic_pattern_analysis(data.pelanggan$Nama)),]

basic_pattern_analysis(data.pelanggan)

#Melakukan profiling terhadap seluruh kolom data.pelanggan 
pola.data.pelanggan <- basic_pattern_analysis(data.pelanggan)
#Merubah nama kolom
names(pola.data.pelanggan)<-paste("Pola",names(pola.data.pelanggan),sep=".")
#Menggabungkan dua data.frame
data.pelanggan <- cbind(data.pelanggan, pola.data.pelanggan)
#Menampilkan struktur
str(data.pelanggan)
#Menulis File Excel
write.xlsx(data.pelanggan, file="data.pelanggan.xlsx")
