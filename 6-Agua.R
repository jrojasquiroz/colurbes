setwd("G:/Mi unidad/Documentos personales/Columna UrbesLab/Procesos Columna UrbesLab")
library(dplyr)

#1.Importamos
library(readxl)
agua_NC <- read_excel("rawdata/(Original) Agua - Nvo Chimbote.xlsX", 
                      skip = 5)

agua_C <- read_excel("rawdata/(Original) Agua-Chimbote.xlsX", 
                     skip = 5)

#2.Vemos la estructura de datos de NC
head(agua_NC)
tail(agua_NC)
names(agua_NC)

#3.Elegimos las columnas y filas que nos interesan
agua_NC <- agua_NC [2:11]
agua_NC <- agua_NC [1:1983,]

#4.Hacemos lo mismo para Chimbote
head(agua_C)
tail(agua_C)
names(agua_C)

agua_C <- agua_C[2:12]
agua_C <- agua_C[1:1992,]

#5.Ordenamos un poco ambos df. Vamos a determinar cuántas viviendas
#tienen red pública dentro de su vivienda o edificación
agua_NC$AguaSI=agua_NC$`Red pública dentro de la vivienda`+
  agua_NC$`Red pública fuera de la vivienda, pero dentro de la edificación`
agua_NC$Tot = rowSums(agua_NC[,3:10])
agua_NC$AguaSI_PR=agua_NC$AguaSI/agua_NC$Tot*100
agua_NC<-select(agua_NC,1,2,13)

agua_C$AguaSI=agua_C$`Red pública dentro de la vivienda`+
  agua_C$`Red pública fuera de la vivienda, pero dentro de la edificación`
agua_C$Tot = rowSums(agua_C[,3:11])
agua_C$AguaSI_PR=agua_C$AguaSI/agua_C$Tot*100
agua_C<-select(agua_C,1,2,14)

totviv=sum(agua_C$Tot)+sum(agua_NC$Tot)
viv_aguasi=sum(agua_C$AguaSI)+sum(agua_NC$AguaSI)

totviv-viv_aguasi
21976/95018*100

#6.Unimos Chimbote y Nuevo Chimbote
agua<-rbind(agua_NC,agua_C)

#7. Separamos la columna 'Manzana' para obtener el código exacto de cada manzana)
library(tidyr)
library(dplyr)
agua <- separate(agua, Manzana, c("Cod","Reg","Prov","Dist","Ubi"))
agua_ok <- select(agua,2,7)

#8. Veamos si hay duplicados
duplis_agua=data.frame(duplicated(agua_ok$Cod)) #duplicada la manzana
#021809000101800039

agua_ok=agua_ok[
  agua_ok$Cod != '021809000101800039', ]

#9. Exportamos
library(openxlsx)
write.csv(agua_ok,"data/6-Agua.csv")
