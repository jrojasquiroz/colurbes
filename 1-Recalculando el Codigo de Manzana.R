setwd("Ruta/a/tu/carpeta")

library(readr)
mz_correo <- read_csv("rawdata/Manzanas_Chimbote_INEI_Oficial.csv")


#1.Seleccionamos las columnas que nos interesan
mz_correo=select(mz_correo,
                 ID, #para luego hacer el match con el gdf
                 UBIGEO,CODCCPP,CODZONA,
                 SUFZONA,CODMZNA,SUFMZNA)

#2.Uniremos las columnas en una sola. Pero como algunas filas
#de la columna SUFMZNA están vacías (valores NA) es necesario
#crear una función que las omita.

paste_noNA <- function(x,sep=", ") {
  gsub(", " ,sep, toString(x[!is.na(x) & x!="" & x!="NA"] ) ) }
sep="" #le decimos que tipo de separador queremos. En este caso
#no queremos que haya ni un espacio.

#3.Ahora sí creamos la columna que coincidirá con los datos que
#bajemos directamente de redatam
library(tidyverse)
mz_correo$Mz <- apply( mz_correo[ , c(2:7) ] #las columnas que nos
                                             #interesan están entre la 2 y
                                             #la 7
                     , 1,                    #no sé para qué es esto,
                                             #venía en el ejemplo. No tocar.
                     paste_noNA , 
                     sep=sep)
head(mz_correo)

#4.Exportamos
library(openxlsx)
mz_correo2=select(mz_correo,ID,Mz)
write.csv(mz_correo2,"data/CodigoManzanasOficial.csv")
