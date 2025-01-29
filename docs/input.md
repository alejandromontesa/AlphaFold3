# Formato del Input

AlphaFold3 utiliza un formato de entrada JSON personalizado que permite:

* Especificar cadenas de proteínas, RNA y DNA, incluyendo residuos modificados
* Especificar alineamientos de secuencia múltiples (MSA, de sus siglas en inlgés) tanto para proteínas como cadenas de RNA/DNA
* Especificar modelos estructurales persoanlizados para cadenas proteicas
* Especificar ligandos usando códigos CCD (Chemical Component Dictionary codes)
* Especificar ligandos usando códigos SMILES
* Especificar ligandos usando el formato mmCIF CCD
* Especificar enlaces covalentes entre entidades
* Específicar múltiples *seeds* aleatorias

La estructura de nivel superior del JSON de entrada es:

```json
{
  "name": "Job name goes here",
  "modelSeeds": [1, 2],  # At least one seed required.
  "sequences": [
    {"protein": {...}},
    {"rna": {...}},
    {"dna": {...}},
    {"ligand": {...}}
  ],
  "bondedAtomPairs": [...],  # Optional
  "userCCD": "...",  # Optional
  "dialect": "alphafold3",  # Required
  "version": 2  # Required
}
```

Donde:

* `name: str`: es el nombre del trabajo (en nuestro script `/scripts/alphafold3.sh`) este será el nombre que recibirá posteriormente nuestra carpeta de salida
* `modelSeeds: list[int]`: una lista de *seeds* randoms. El protocolor y los modelos serán invocados con cada *seed* de la lista, es decir, si utilizamos *n* *seeds* random, obtendremos *n* estructuras, cada una para su respectiva *seed*. Se debe incluir al menos una
* `sequences: list[Protein | DNA | RNA | Ligand]`: una lita de diccionarios de secuencias, que definen cada una una entidad molecular (se explica más adelante)
* `bondedAtomPairs: list[Bond]`: lista opcional de átomos unidos covalentemente. Pueden unir átomos entre dos entidades diferentes o dentro de la misma entidad (se explica más adelante)
* `userCCD: str`: *string* (cadena de text) opcional con un diccionario de componentes químicos proporcionado por el usuario. Modo **pro** de proporcionar moléculas personalizadas cuando los códigos SMILES no son suficientes **IRENE Y MATTIA**. También se utilizan cuando tienes una molécula específica que necesita unirse a otras entidades, pues los códigos SMILES no pueden utilizarse en dichos casos
* `dialect: str`: dialecto del JSON de entrada, debe ser asignado como `alphafold3`
* `version: int`: versión del JSON de entrada, debe ser asignada a **1** (principalmente) or 2

## Versiones

El campo `version`que hemos comentado arriba puede tomar el valor `1` o `2`:

* `1`: formato de entrada típico de AlphaFold3
* `2`: se añade la opción de específicar un MSA externo usando nuevos campos (`unpairedMsaPath`, `pairedMsaPath`, `mmcifPath`)

## Secuencias

La sección `sequences` específica las cadenas de proteínas, RNA, DNA o los ligandos. Cada entidad en `sequences` debe tener un ID único que no tiene por que estar ordenado alfabéticamente aunque es lo más cómodo.

### Proteínas

Específica una cadena proteica:

```json
{
  "protein": {
    "id": "A",
    "sequence": "PVLSCGEWQL",
    "modifications": [
      {"ptmType": "HY3", "ptmPosition": 1},
      {"ptmType": "P1L", "ptmPosition": 5}
    ],
    "unpairedMsa": ...,  # Mutually exclusive with unpairedMsaPath.
    "unpairedMsaPath": ...,  # Mutually exclusive with unpairedMsa.
    "pairedMsa": ...,  # Mutually exclusive with pairedMsaPath.
    "pairedMsaPath": ...,  # Mutually exclusive with pairedMsa.
    "templates": [...]
  }
}
```

Donde:

* `id: str | list[str]`: letra/letras mayúsculas que especifican el ID único de cada copia de esta cadena proteica, de forma que si espeficamos una lista de IDs (`["A", "B", "C"]`) estaremos indicando que queremos 3 copias de la misma cadena
* `sequence: str`: secuencia de aminoácidos especificada como una cadena de texto que utiliza el código de 1 letra de los aminoácidos
* `modifications: list[ProteinModification]`: lista opcional de PTMs. Cada modificaión es específicada usando su código CCD y la posición del residuo (siendo el primer residuo el 1). En el ejemplo el primer residuo en vez de una prolina (`P`) es una (`HY3`)

El resto de parámetros no se utilizan normalmente.

### Ligandos

Especifica un ligando de una de las 3 formas siguientes:

* Código CCD: forma más fácil de especificar ligandos. 