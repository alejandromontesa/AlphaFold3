# AlphaFold3. Grupo Química Bioorgánica - UZ

## Cómo hacer tu primera predicción

AlphaFold puede ser ejectuado con el siguiente comando:

```bash
docker run -it \
    --volume $HOME/af_input:/root/af_input \
    --volume $HOME/af_output:/root/af_output \
    --volume <MODEL_PARAMETERS_DIR>:/root/models \
    --volume <DATABASES_DIR>:/root/public_databases \
    --gpus all \
    alphafold3 \
    python run_alphafold.py \
    --json_path=/root/af_input/fold_input.json \
    --model_dir=/root/models \
    --output_dir=/root/af_output
```

El cual se puede encontrar en el [repositorio original de Alphafold3](https://github.com/google-deepmind/alphafold3); sin embargo, nosotros usaremos el script `alphafold3_4.0.sh` que se puede encontrar en la carpeta `/scripts`. La ventaja de este script es que podremos ejecutar AlphaFold3 desde cualquier carpeta sin preocuparnos por modificar las rutas del Docker o la máquina virtual. Este script es una versión mejorada del anterior que asegura que el campo *name* del fichero `.json` es recogido correctamente, gracias al paquete [`jq`](https://jqlang.org/) el cual tenemos instalado en nuestras máquinas. La versión actual del script añade la flag `--gpu_device` al comando `run_alphafold.py` para elegir en que GPU queremos correr la inferencia (podemos ver el estado de las GPUs con el comando `nvidia-smi`), pues por defecto Alphafold3 elige la tarjeta 0 para correrlas.

Además, el comando `run_alphafold.py` puede recibir varias flags que no han sido incluidas en el script. Dos de las flags más utilizadas y que controlan que partes de AlphaFold3 son ejectuadas son:

* `--run_data_pipeline` (su valor por defecto es true), determina si se ejectua la pipeline, la búsqueda de modelos (require de CPU y es bastante costosa computacionalmente hablando)
* `--run_inference` (su valor por defecto es true), determina si se ejectura la inferencia (requiere de GPU)

Por ahora, solo podremos ejecutar AlphaFold3 en **Castor** y **Polux**, para lo que recomendamos crear una carpeta `/Alphafold` dentro de `/media/disk2/user_name` donde `user_name` es vuestro usuario en cada caso.

## Formato del input de AlphaFold3

Mira la [documentación sobre el input](https://github.com/alejandromontesa/AlphaFold3/blob/main/docs/input.md).

## Formato del output de AlphaFold3

Mira la [documentación sobre el output](https://github.com/alejandromontesa/AlphaFold3/blob/main/docs/output.md).

## ¿Cómo citar AlphaFold3?

Cualquier publicación que contenga hallazgos encontrados usando el código de AlphaFold3, los modelos o sus outputs, deberá citar:

```bash
@article{Abramson2024,
  author  = {Abramson, Josh and Adler, Jonas and Dunger, Jack and Evans, Richard and Green, Tim and Pritzel, Alexander and Ronneberger, Olaf and Willmore, Lindsay and Ballard, Andrew J. and Bambrick, Joshua and Bodenstein, Sebastian W. and Evans, David A. and Hung, Chia-Chun and O’Neill, Michael and Reiman, David and Tunyasuvunakool, Kathryn and Wu, Zachary and Žemgulytė, Akvilė and Arvaniti, Eirini and Beattie, Charles and Bertolli, Ottavia and Bridgland, Alex and Cherepanov, Alexey and Congreve, Miles and Cowen-Rivers, Alexander I. and Cowie, Andrew and Figurnov, Michael and Fuchs, Fabian B. and Gladman, Hannah and Jain, Rishub and Khan, Yousuf A. and Low, Caroline M. R. and Perlin, Kuba and Potapenko, Anna and Savy, Pascal and Singh, Sukhdeep and Stecula, Adrian and Thillaisundaram, Ashok and Tong, Catherine and Yakneen, Sergei and Zhong, Ellen D. and Zielinski, Michal and Žídek, Augustin and Bapst, Victor and Kohli, Pushmeet and Jaderberg, Max and Hassabis, Demis and Jumper, John M.},
  journal = {Nature},
  title   = {Accurate structure prediction of biomolecular interactions with AlphaFold 3},
  year    = {2024},
  volume  = {630},
  number  = {8016},
  pages   = {493–-500},
  doi     = {10.1038/s41586-024-07487-w}
}
```
