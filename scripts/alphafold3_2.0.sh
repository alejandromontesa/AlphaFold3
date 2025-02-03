#!/bin/bash
#Introduce el nombre de tu archivo JSON:
name=t7-ternary-ramon4
fname=$name.json

#Extrae el nombre del trabajo que entra a alphafold3:
namej=$(jq -r '.name' "$fname")

#Copia el fichero de tu carpeta actual donde corres el script a /root/af_input
cp $fname /root/af_input

#Docker de alphafold3
docker run -it --volume /root/af_input:/root/af_input --volume /root/af_output:/root/af_output --volume /data/alphafold3/models:/root/models --volume /data/alphafold3/public_databases:/root/public_databases --gpus all alphafold3 python run_alphafold.py --json_path=/root/af_input/$name.json --model_dir=/root/models --output_dir=/root/af_output

#Copia el output generado a la carpeta donde corres el script:
cp -r /root/af_output/$namej .
