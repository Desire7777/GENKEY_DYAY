#!/bin/bash

#filename : backupscript.sh
#Schedule : Run everyday at 3AM
#Run /backupscriptsh --install-cron to add to crontab


#Variables
BACKUP_DIR="/backups"
SOURCE_DIR="/home/user/data"
LOG_FILE="/var/log/audit.log"
DATE="$(date +%Y%m%d)"
SCRIPT_PATH="$(realpath "$0")"
CRON_JOB="0 3 * * * $SCRIPT_PATH"

log.message(){
        echo "[$DATE] $1" >> "LOG_FILE"
        }

if [ "$1" == "--install-cron" ]; then
    if ! crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH" >/dev/null; then
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        log.nessage "Cronjob Installed : $CRON_JOB"
        echo "Cronjob installed : $CRON_JOB"
    else
    echo "Cronjob Exists"
  
    fi
    exit 0

if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
      log.message "$BACKUP_DIR created"
      fi
      exit 0

tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR" 2>> "$LOG_FILE"

if [ $? -eq 0 ]; then
      log.message "Backup Complete : backup_$DATE.tar.gz"
    else 
    log.message "backup failed"
    exit 1
fi

#Clear 7 day old backups
find "$BACKUP_DIR" -type f -name "*.tar.gz -mtime +7 -delete
log.message "Old backups cleaned up"

exit 0


