#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

FECHA=$(date +"%Y-%m-%d")
DEST="/mnt/Datos01/backups/$FECHA"
mkdir -p "$DEST"

# Dump de base de datos
mariadb-dump --skip-ssl -h mariadb -u"root" -p"supersecret" --all-databases > "$DEST/db_backup.sql"

# Backup de carpetas
while IFS=: read -r TAG FOLDER; do
  tar -czf "$DEST/${TAG}_backup.tar.gz" -C "$(dirname "$FOLDER")" "$(basename "$FOLDER")"
done < /usr/local/bin/folders.conf

# Comprimir carpeta completa
tar -czf "/mnt/Datos01/backups/${FECHA}.tar.gz" -C "/mnt/Datos01/backups" "$FECHA"

# Registro
echo "$FECHA: $(ls "$DEST")" >> /mnt/Datos01/backups/registro_generados.txt
