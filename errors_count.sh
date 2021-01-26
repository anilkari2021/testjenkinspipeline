#!/bin/sh

#to cleanup the logs which are older than 3 days

/bin/find /var/log -name "*.log*" -type f -mtime +3 -exec rm -f {} \;

filename="$1"

count=`awk '$9~/^[4-5]/' $filename | wc -l`

echo "$count" 

if [ "$count" > 100 ]; then

echo "Error count exceeds 100" | mailx -s "subject" anilkari2001@gmail.com

fi
