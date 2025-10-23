#!/bin/bash
FECHA=$(date +"%Y-%m-%d")
ARCHIVO="/mnt/Datos01/backups/${FECHA}.tar.gz"

rclone copy "$ARCHIVO" mega:/BackupsLegendarios --log-level INFO
echo "$ARCHIVO" >> /mnt/Datos01/backups/registro_subidas.txt
