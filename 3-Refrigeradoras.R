setwd("C:/Users/rojas/Desktop/Chimbote")

#1. Importamos el df de Nuevo Chimbote
library(readxl)
Refrigeradora_NC <- read_excel("rawdata/(Original) Refrigeradora - Nvo Chimbote.xlsX", 
                               skip = 5)
head(Refrigeradora_NC)
tail(Refrigeradora_NC)
names(Refrigeradora_NC)

#2.Elegimos las columnas y las filas que tienen la info que nos interesa
Refrigeradora_NC <- Refrigeradora_NC [2:5]
Refrigeradora_NC <- Refrigeradora_NC [1:1983,]

#3. Los mismos pasos que 1 y 2, pero para Chimbote
Refrigeradora_C <- read_excel("rawdata/(Original) Refrigeradora - Chimbote.xlsX", 
                              skip = 5)
head(Refrigeradora_C)
tail(Refrigeradora_C)
names(Refrigeradora_C)

Refrigeradora_C <- Refrigeradora_C [2:5]
Refrigeradora_C <- Refrigeradora_C [1:1992,]

#4. Unimos los dos df en uno solo
Refrigeradora <- rbind(Refrigeradora_C,Refrigeradora_NC)
  #4.1.Obtenemos el total de manzanas que no tienen refri
  sum(Refrigeradora$`No tiene refrigeradora o congeladora`)
  #37081
  #4.2.Calculamos qué porcentaje de esos hogares está en cada manzana
  Refrigeradora$No_TotalPR=Refrigeradora$`No tiene refrigeradora o congeladora`/37081*100

#5. Separamos la columna 'Manzana' para obtener el código exacto de cada manzana)
library(tidyr)
Refrigeradora <- separate(Refrigeradora, Manzana, c("Cod","Reg","Prov","Dist","Ubi"))
names(Refrigeradora)

Refrigeradora_ok <- select(Refrigeradora, 2, 9)

#6. Vemos si hay duplicados y los eliminamos
duplis3=data.frame(duplicated(Refrigeradora_ok$Cod)) #duplicada la manzana
                                                     #021809000101800039

Refrigeradora_ok=Refrigeradora_ok[
  Refrigeradora_ok$Cod != '021809000101800039', ]

#7. Exportamos
library(openxlsx)
write.csv(Refrigeradora_ok,"data/2-Refrigeradora.csv")
