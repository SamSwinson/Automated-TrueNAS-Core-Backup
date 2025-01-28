#!/bin/bash
  
  RSYNC_PROCESSES=$(ps -U baccount | grep -e "/usr/local/bin/rsync" | wc -l)
  SSH_PROCESSES=$(ps -U baccount | grep -e "ssh" | wc -l)
  
  echo "$RSYNC_PROCESSES"
  echo "$SSH_PROCESSES"
  
  while [ "$RSYNC_PROCESSES" -ne "0" -a "$SSH_PROCESSES" -ne "0" ]
  do
  	echo "Task Running"
      
  	TIME=$(ps -U baccount | grep -e "/usr/local/bin/rsync" | awk '{print $4}')
  	
  	if [ "$TIME" != "0:01.00" ]; then
          	STATUS="up"
  	else
          	STATUS="down"
  	fi
  	
  	echo "Start 10 minute sleep"
  	sleep 600
  	
  	RSYNC_PROCESSES=$(ps -U baccount | grep -e "/usr/local/bin/rsync" | wc -l)
  	SSH_PROCESSES=$(ps -U baccount | grep -e "ssh" | wc -l)
  
  done
  
  MESSAGE="Rsync from NOC01TNAS01 to NOC01TRUENAS01 Completed in ${TIME}"
  
  URL="http://192.168.1.20:3001/api/push/dKfL7Ii93I?"
  
  curl \
      --get \
      --data-urlencode "status=${STATUS}" \
      --data-urlencode "msg=${MESSAGE}" \
      --data-urlencode "ping=${TIME}" \
      --silent \
      ${URL} \
      > /dev/null
