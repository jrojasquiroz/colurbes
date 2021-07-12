setwd("C:/Users/rojas/Desktop/Chimbote")

#######Primero sacamos la población por manzana
#######
#1. Importamos el df de Nuevo Chimbote
library(readxl)
vp_NC <- read_excel("rawdata/(Original) Vivienda y Poblacion - Nvo Chimbote.xlsX", 
                               skip = 5)
head(vp_NC)
tail(vp_NC)
names(vp_NC)

#2.Elegimos las columnas y las filas que tienen la info que nos interesa
vp_NC <- vp_NC [2:5]
vp_NC <- vp_NC [1:1983,]

#3. Los mismos pasos que 1 y 2, pero para Chimbote
vp_C <- read_excel("rawdata/(Original) Vivienda y Poblacion - Chimbote.xlsX", 
                              skip = 5)
head(vp_C)
tail(vp_C)
names(vp_C)

vp_C <- vp_C [2:5]
vp_C <- vp_C [1:1992,]

#4. Unimos los dos df en uno solo
viv_pob <- rbind(vp_C,vp_NC)

#5. Separamos la columna 'Manzana' para obtener el código exacto de cada manzana)
library(tidyr)
viv_pob <- separate(viv_pob, Manzana, c("Cod","Reg","Prov","Dist","Ubi"))
names(viv_pob)

#6.Elegimos la columna que nos interesa para calcular el Hacinamiento
pob <- select(viv_pob, 2, 8)

#######Ahora calculamos las habitaciones por manzana
#######
#1. Importamos el df de Nuevo Chimbote
library(readxl)
habs_NC <- read_excel("rawdata/(Original) Nro habitaciones - Nvo Chimbote.xlsX", 
                    skip = 5)
head(habs_NC)
tail(habs_NC)
names(habs_NC)
habs_NC$`1 habitación`
#2.Elegimos las columnas y las filas que tienen la info que nos interesa
habs_NC <- habs_NC [2:17]
habs_NC <- habs_NC [1:1983,]

#3.Calculamos el total de habitaciones por manzana
habs_NC$TotHabs=habs_NC$`1 habitación`*1+
  habs_NC$`2 habitaciones`*2+
  habs_NC$`3 habitaciones`*3+
  habs_NC$`4 habitaciones`*4+
  habs_NC$`5 habitaciones`*5+
  habs_NC$`6 habitaciones`*6+
  habs_NC$`7 habitaciones`*7+
  habs_NC$`8 habitaciones`*8+
  habs_NC$`9 habitaciones`*9+
  habs_NC$`10 habitaciones`*10+
  habs_NC$`11 habitaciones`*11+
  habs_NC$`12 habitaciones`*12+
  habs_NC$`13 habitaciones`*13+
  habs_NC$`14 habitaciones`*14

#4. Los mismos pasos que 1, 2 y 3, pero para Chimbote
habs_C <- read_excel("rawdata/(Original) Nro habitaciones - Chimbote.xlsX", 
                   skip = 5)
head(habs_C)
tail(habs_C)
names(habs_C)

habs_C <- habs_C [2:18]
habs_C <- habs_C [1:1992,]

habs_C$TotHabs=habs_C$`1 habitación`*1+
  habs_C$`2 habitaciones`*2+
  habs_C$`3 habitaciones`*3+
  habs_C$`4 habitaciones`*4+
  habs_C$`5 habitaciones`*5+
  habs_C$`6 habitaciones`*6+
  habs_C$`7 habitaciones`*7+
  habs_C$`8 habitaciones`*8+
  habs_C$`9 habitaciones`*9+
  habs_C$`10 habitaciones`*10+
  habs_C$`11 habitaciones`*11+
  habs_C$`12 habitaciones`*12+
  habs_C$`13 habitaciones`*13+
  habs_C$`14 habitaciones`*14+
  habs_C$`15  habitaciones`*15

#5.Escojemos solo las columnas que nos interesan
habs_NC=select(habs_NC,Manzana,TotHabs)
habs_C=select(habs_C,Manzana,TotHabs)

#6. Unimos los dos df en uno solo
habs <- rbind(habs_C,habs_NC)

#7. Separamos la columna 'Manzana' para obtener el código exacto de cada manzana)
library(tidyr)
habs <- separate(habs, Manzana, c("Cod","Reg","Prov","Dist","Ubi"))
names(habs)

habs_ok <- select(habs, 1, 6)

#####
#####Ahora sí calculamos el hacinamiento
#####

#1.Primero corroboramos que los archivos a unir estén OK
  #1.1.El paquete mice nos permite saber qué columnas tienen valores perdidos
  library(mice)
  md.pattern(habs_ok)
  md.pattern(pob) #todo bien

  #1.2.Vemos si no hay filas con valores NA
  is.na(habs_ok$Cod)
  is.na(pob$Cod)
  
  #1.3.Vemos si todas las filas tienen todos los valores
  complete.cases(habs_ok)
  complete.cases(pob)
  
  #1.4.Revisamos duplicados
  duplis=data.frame(duplicated(habs_ok$Cod)) #duplicada la manzana
                                             #021809000101800039
  duplis2=data.frame(duplicated(pob$Cod))    #duplicada la misma manzana
  
  #1.5.Eliminamos las dos filas con 
  #el mismo ID de manzana
  
  habs_ok=habs_ok[
    habs_ok$Cod != '021809000101800039', ]
  pob=pob[
    pob$Cod != '021809000101800039', ]
  
  
#2.Unimos los df obtenidos
hacin=merge(habs_ok,pob,by="Cod")

#3.Creamos la variable hacinamiento
hacin$Hacin=hacin$Población/hacin$TotHabs

library(dplyr)
hacin_ok <- hacin %>%
  select(Cod,Hacin)

#4. Exportamos
library(openxlsx)
write.csv(hacin_ok,"data/3-Hacinamiento.csv")
