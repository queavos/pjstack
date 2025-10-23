#!/bin/bash
# Local: borrar carpetas y archivos .tar.gz de más de 10 días
find /mnt/Datos01/backups -type d -mtime +10 -exec rm -r {} \;
find /mnt/Datos01/backups -type f -name "*.tar.gz" -mtime +10 -exec rm {} \;

# Mega: borrar archivos de más de 28 días
rclone delete --min-age 28d mega:/BackupsLegendarios
