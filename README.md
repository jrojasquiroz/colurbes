# Columna para URBES Lab
En este repositorio se pueden encontrar los cálculos hechos para la redacción de una columna para Noticias Ser, como investigador de Urbes Lab. En la descripción se encuentra el enlace a ella, sugiero leerla para entender el repositorio.

En primer lugar, se puede revisar el proceso para encontrar las provincias con mayor *tasa de muertes por Covid-19 por cada 100.000 habitantes* dentro del script `0-Muertes por provincia` y los resultados en [este archivo]. En cualquier caso, las primeras diez provincias del país más afectadas son:

"","IDPROV","PROVINCIA","Muertes","POB2017","MuertesPond"
"1","101","CHACHAPOYAS",228,55506,410.76640363204
"2","102","BAGUA",390,74100,526.315789473684
"3","103","BONGARA",62,25637,241.837968561064
"4","104","CONDORCANQUI",91,42470,214.268895691076
"5","105","LUYA",74,44436,166.531641011792
"6","106","RODRIGUEZ DE MENDOZA",47,29998,156.677111807454
"7","107","UTCUBAMBA",281,107237,262.036423995449
"8","201","HUARAZ",996,163936,607.554167479992
"9","202","AIJA",16,6316,253.324889170361
"10","203","ANTONIO RAIMONDI",28,13650,205.128205128205

![imagen](https://user-images.githubusercontent.com/34352451/125222149-1ecec480-e28f-11eb-9818-8c5703719ffd.png)

Los procesos para encontrar el *porcentaje de familias con refrigeradoras por manzana* y las tasas de *personas por habitación* se encuentran en cuadernos escritos en R y Python, y los resultados están dentro de la carpeta `data`.

Los cálculos para calcular las áreas de esparcimiento fueron hechos manualmente en QGIS, por eso no está disponible el proceso en el repositorio. En cualquier caso, lo que hice fue descargar la información directamente de [OpenStreetMap], y limpiarla siguiendo tres criterios:
- Dentro de algunos parques/plazas hay campos de fulbito. Como la intención era, inicialmente, ver la facilidad para acceder a estos equipamientos durante la pandemia, las áreas ocupadas por los campos de fulbito fueron eliminadas debido a que no se pueden utilizar por motivos sanitarios.
- El Boulevard Isla Blanca estuvo en construcción desde inicios de la pandemia hasta Junio de 2021, por tanto también fue sacado del análisis.
- OSM toma en cuenta como áreas verdes algunas bermas. Las quito porque no son utilizables.

[este archivo]:https://github.com/jrojasquiroz/columnaUrbesLab/blob/main/data/MuertesxProvincia.csv
[OpenStreetMap]:https://www.openstreetmap.org/
