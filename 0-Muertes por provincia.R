setwd("G:/Mi unidad/Documentos personales/Muertes Covid-19 por Áreas urbanas - Perú/1-Cálculos previos con límites INEI")

library(dplyr)
library(readr)

#1.Este df solo tiene datos de a qué provincia y departamento pertenece
#cada distrito
pertenencia <- read_csv("rawdata/Distritos Provincias y Departamentos.csv", 
                        col_types = cols(IDPROV = col_double()))
pertenencia=select(pertenencia, CODUBIGEO, IDPROV,CCDD)
names(pertenencia)[1]="UBIGEO"

#2.Este df tiene datos de muertes por Covid-19. La fuente es
#NOTI-SINADEF, descargada el 07 de julio de 2021.
fallecidos_covid <- read_delim("rawdata/fallecidos_covid.csv", 
                               ";", escape_double = FALSE, col_types = cols(FECHA_CORTE = col_date(format = "%Y%m%d"), 
                                                                            FECHA_FALLECIMIENTO = col_date(format = "%Y%m%d")), 
                               trim_ws = TRUE)

#3.NOTI-SINADEF por defecto solo tiene codigo UBIGEO, quiero añadir
#el código de provincia y departamento
df=merge(fallecidos_covid,pertenencia,by="UBIGEO")

#4.Para poder sumar cada fallecimiento le añadimos esta columna
df$Muertes=rep(1)

#5.Hacemos un df nuevo que agrupe fallecimientos por provincia
din_df <- df %>%
  group_by(PROVINCIA,IDPROV) %>%
  summarise(Muertes=sum(Muertes))

#6.Importamos df con datos de población por provincia
#y unimos con el anterior para conocer fallecimientos por cada
#100.000 habitantes
pobprov <- read_csv("rawdata/PoblacionProv_INEI2017.csv", 
                    col_types = cols(IDPROV = col_double()))

din_df=merge(din_df,pobprov,by="IDPROV")
din_df$MuertesPond=din_df$Muertes/din_df$POB2017*100000

#7.Notamos que debemos juntar provincias de Lima y Callao,
#que en conjunto forman Lima Metropolitana.
limaycallao <- din_df %>%
  filter( PROVINCIA == "LIMA" | PROVINCIA == "CALLAO")
sum(limaycallao$Muertes)
sum(limaycallao$POB2017)

IDPROV=c("701 y 1501")
PROVINCIA=c("LIMA METROPOLITANA")
Muertes=c(89372)
POB2017=c(9569468)

limamet=data.frame(IDPROV,PROVINCIA,Muertes,POB2017)
limamet$MuertesPond=limamet$Muertes/limamet$POB2017*100000

#8.Eliminamos filas de Lima y Callao por separado
din_df=din_df[
  din_df$PROVINCIA != 'LIMA', ]
din_df=din_df[
  din_df$PROVINCIA != 'CALLAO', ]

#9.Unimos con Lima Metropolitana
df_final=rbind(din_df,limamet)

#10.Exportamos en caso se quiera revisar manualmente
library(openxlsx)
write.csv(df_final,"data/MuertesxProvincia.csv")
