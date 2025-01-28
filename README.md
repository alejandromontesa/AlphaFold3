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

El cual se puede encontrar en el github original de Alphafold3