#Membaca dataset dengan read.csv dan dimasukkan ke variable penduduk.dki
penduduk.dki <- read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",")
penduduk.dki
str(penduduk.dki)
summary(penduduk.dki)

penduduk.dki <- read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",", check.names = FALSE)
str(penduduk.dki)

penduduk.dki <- read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.tsv", sep="\t")
penduduk.dki

library(openxlsx)
#Membaca dataset dengan read.xlsx dan dimasukkan ke variable penduduk.dki
penduduk.dki.xlsx <- read.xlsx(xlsxFile="https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.xlsx")
str(penduduk.dki.xlsx)

#Membaca dataset csv
penduduk.dki.csv <-read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",")
#Menggunakan names untuk variable penduduk.dki.csv
names(penduduk.dki.csv)

#Membaca dataset csv
penduduk.dki.csv <-read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",")
names(penduduk.dki.csv)[1] <- "PERIODE"
names(penduduk.dki.csv)[2] <- "PROPINSI"
names(penduduk.dki.csv)

#Membaca dataset csv
penduduk.dki.csv <-read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",")
names(penduduk.dki.csv)[c(1:2)] <- c("PERIODE", "PROPINSI")
names(penduduk.dki.csv)

#Membaca dataset csv
penduduk.dki.csv <-read.csv("https://academy.dqlab.id/dataset/dkikepadatankelurahan2013.csv", sep=",")
#Membuang kolom X, X.1, X.2 s/d X.11
penduduk.dki.csv <- penduduk.dki.csv[,!names(penduduk.dki.csv) %in% c("X", "X.1","X.2","X.3","X.4","X.5","X.6","X.7","X.8","X.9","X.10", "X.11")]
names(penduduk.dki.csv)
