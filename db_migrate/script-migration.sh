#!/bin/bash
# Variables
SOURCE_HOST="127.0.0.1" #change source host
DEST_HOST="localhost" #change destination host
USER="test"
PASSWORD="pwdtest@!"
DUMP_FILE="/DATA/full_backup.sql.gz"
LOG_FILE="/DATA/full_backup_migration.log"

# Log start time
echo "Migration started at $(date)" >> $LOG_FILE

# Step 1: Backup Source Database with Compression
echo "Starting database dump from $SOURCE_HOST" >> $LOG_FILE
mysqldump -h $SOURCE_HOST -u $USER -p$PASSWORD osiris --single-transaction --routines --triggers --events | gzip > $DUMP_FILE

# Check if dump was successful
if [ $? -eq 0 ]; then
    echo "Database dump completed successfully" >> $LOG_FILE
else
    echo "Database dump failed" >> $LOG_FILE
    exit 1
fi

# Step 2: Restore to Destination Server with Decompression
echo "Starting database import to $DEST_HOST" >> $LOG_FILE
gunzip -c $DUMP_FILE | mysql -h $DEST_HOST -u $USER -p$PASSWORD

# Check if import was successful
if [ $? -eq 0 ]; then
    echo "Database import completed successfully" >> $LOG_FILE
else
    echo "Database import failed" >> $LOG_FILE
    exit 1
fi

# Log end time
echo "Migration completed at $(date)" >> $LOG_FILE