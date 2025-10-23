#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
echo "🧪 PATH actual: $PATH"
which dirname
which basename
which tar
NOW=$(date +"%Y-%m-%d_%H-%M")
DEST="/mnt/Datos01/backups/$NOW"
DB_CONTAINER="mariadb"
DB_USER="root"
DB_PASS="supersecret"
mkdir -p "$DEST"
# Dump de MariaDB
#docker exec "$DB_CONTAINER" sh -c "mysqldump -u$DB_USER -p$DB_PASS --all-databases" > "$DEST/db_backup_$NOW.sql"
mariadb-dump --skip-ssl -h mariadb -u"$DB_USER" -p"$DB_PASS" --all-databases > "$DEST/db_backup.sql"
tar -czf "$DEST/db_backup.tar.gz" -C "$DEST" "db_backup.sql"
rm "$DEST/db_backup.sql"

# Backup de carpetas
while IFS=: read -r TAG FOLDER; do
  ARCHIVE="$DEST/${TAG}_backup.tar.gz"
  tar -czf "$ARCHIVE" -C "$(dirname "$FOLDER")" "$(basename "$FOLDER")"
done < /usr/local/bin/folders.conf
