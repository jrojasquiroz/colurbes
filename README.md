# Columna para URBES Lab
En este repositorio se pueden encontrar los cálculos hechos para la redacción de la columna.

En primer lugar, se puede revisar el proceso para encontrar las provincias con mayor tasa de *muertes por Covid-19 por cada 100.000 habitantes* dentro del script `0-Muertes por provincia` y los resultados en [este archivo]. En cualquier caso, las primeras diez provincias del país más afectadas son:

![imagen](https://user-images.githubusercontent.com/34352451/125222149-1ecec480-e28f-11eb-9818-8c5703719ffd.png)

Los procesos para encontrar el *porcentaje de familias con refrigeradoras por manzana* y las tasas de *personas por habitación* se encuentran en cuadernos escritos en R y Python, y los resultados están dentro de la carpeta `data`.

Los cálculos para calcular las áreas de esparcimiento fueron hechos manualmente en QGIS, por eso no está disponible el proceso en el repositorio. En cualquier caso, lo que hice fue descargar la información directamente de [OpenStreetMap], y limpiarla siguiendo tres criterios:
- Dentro de algunos parques/plazas hay campos de fulbito. Como la intención era, inicialmente, ver la facilidad para acceder a estos equipamientos durante la pandemia, las áreas ocupadas por los campos de fulbito fueron eliminadas debido a que no se pueden utilizar por motivos sanitarios.
- El Boulevard Isla Blanca estuvo en construcción desde inicios de la pandemia hasta Junio de 2021, por tanto también fue sacado del análisis.
- OSM toma en cuenta como áreas verdes algunas bermas. Las quito porque no son utilizables.

[este archivo]:https://github.com/jrojasquiroz/columnaUrbesLab/blob/main/data/MuertesxProvincia.csv
[OpenStreetMap]:https://www.openstreetmap.org/
