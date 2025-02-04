# Formato del Output 

## Estructura del directorio 

Para nuestros trabajos, AlphaFold3 escribe todos los ficheros de salida en un directo que tiene una versión curada del nombre del trabajo que ponemos en el primer campo del fichero .json (*name*). Es decir, si en el campo *name* ponemos el nombre "Mi primera prueba", AlphaFold3 escribirá  los ficheros de salida en un directorio llamado `mi_primera_prueba`. Por ello y para que nuestro script `alphafold3_2.0.sh`funcione correctamente, recomendamos nombras los trabajos siguiendo la convención *snake case* para el nombre de variables. Si el directorio que AlphaFold3 va a crear ya existe, se añadirá la fecha al nomrbe del directorio para evitar que se sobreescriban los datos.

En el directorio de salida se sigue la siguiente estructura:

* Se crearán subdirectorios para cada muestra (*sample*) y cada semilla (*seed) que se nombrarán como `seed-<valor de la seed>_sample_<valor del sample>`. Cada directorio contiene un fichero JSON de la confianza del trabajo, un fichero JSON a modo de resumen y el modelo mmCIF con la estructura predicha
* *Embeddings* para cada *seed*: `seed-<valor de la seed>_embeddings/embeddings.npz` solamente si corremos AlphaFold3 con la opción `--save_embeddings=true` (no lo he probado)
* Mejor predicción mmCIF: `<nombre_del_trabajo>_model.cif`, fichero que contiene las coordenadas y debe ser compatible con la mayoría de herramientas de biología estructural. El formato CIF puede ser convertido fácilmente a PDB
* Fichero de entrada JSON con el MSA (alineamiento de secuencia múltiple) y los datos añadidos durante el procesado: `<nombre_del_trabajo>_data.json`
* Scores para todas las predicciones: `ranking_score.csv`. La predicción con mayor ranking es la que se incluye en el directorio principal
* Términos de uso de los ficheros de salida: `TERMS_OF_USE.md`
