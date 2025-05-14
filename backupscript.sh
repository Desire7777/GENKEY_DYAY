#!/bin/bash

#filename : backupscript.sh
#Schedule : Run everyday at 3AM
#Run /backupscriptsh --install-cron to add to crontab


#Variables
BACKUP_DIR="/home/desire/backups"
SOURCE_DIR="/home/desire/backup-data"
LOG_FILE="/home/desire/audit.log"
DATE="$(date +%Y%m%d)"
SCRIPT_PATH="$(realpath "$0")"
CRON_JOB="0 3 * * * $SCRIPT_PATH"

log(){
        echo "[$(date '+%Y-%m-%d')] $1" >> $LOG_FILE
}


if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
      log "$BACKUP_DIR created"
            exit 0
fi


tar -czf $BACKUP_DIR/backup_"$DATE".tar.gz $SOURCE_DIR 2>> $LOG_FILE

if [ $? -eq 0 ]; then
      log "Backup Complete : backup_$DATE.tar.gz"
    else 
    log "backup failed"
    exit 1
fi

#Clear 7 day old backups
find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +2 -delete
if [ $? -eq 0 ]; then
	
     log "Old backups cleaned up"
else
	log "Clean up failed"

	exit 1
fi


if [ "$1" == "--install-cron" ]; then
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        log "Cronjob Installed : $CRON_JOB"
        echo "Cronjob installed : $CRON_JOB"
    fi
