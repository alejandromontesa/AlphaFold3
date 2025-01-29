#!/bin/bash
#RECUERDA EJECUTAR EL SCRIPT CON SUDO BASH
#Introduce el nombre de tu archivo JSON:
name=
fname=$name.json

#Extrae el nombre del trabajo que entra a alphafold3 (variable "name:" del archivo .json):
namej=$(awk '/name/ {print $2}' $fname)
namej=$(echo "$namej" | sed 's/^.\(.*\)..$/\1/')

#Copia el .json de tu carpeta actual a /root/af_input (no funcionará si no eres sudoer):
cp $fname /root/af_input

#Docker de alphafold3:
docker run -it --volume /root/af_input:/root/af_input --volume /root/af_output:/root/af_output --volume /data/alphafold3/models:/root/models --volume /data/alphafold3:/root/public_databases --gpus all alphafold3 python run_alphafold.py --json_path=/root/af_input/$name.json --model_dir=/root/models --output_dir=/root/af_output

#Copia el output generado a tu carpeta actual:
cp -r /root/af_output/$namej .
