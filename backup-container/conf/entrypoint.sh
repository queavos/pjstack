#!/bin/bash
#echo "0 3 * * * /usr/local/bin/backup.sh" >> /etc/crontabs/root
#echo "0 4 1 * * /usr/local/bin/cleanup.sh" >> /etc/crontabs/root
#echo "0 5 * * * /usr/local/bin/upload.sh" >> /etc/crontabs/root
#!/bin/bash
# Backup diario: lunes a viernes a las 03:00
echo "0 3 * * 1-5 /usr/local/bin/backup_diario.sh" >> /etc/crontabs/root
# Backup sabatino: sábado a las 04:00
echo "0 4 * * 6 /usr/local/bin/backup_sabado.sh" >> /etc/crontabs/root
# Iniciar cron en primer plano
crond -f
