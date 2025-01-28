#!/bin/bash
  
  SSH_CONNECTIONS=$(netstat | grep -e "ESTABLISHED" | grep -e ".ssh" | wc -l)
  HTTPS_CONNECTIONS=$(netstat | grep -e "ESTABLISHED" | grep -e ".https" | wc -l)
  TNAS_SSH_CONNECTIONS=$(netstat | grep -e "ESTABLISHED" | grep -e ".9322" | wc -l)
  RSYNC_PROCESSES=$(ps -U baccount | grep -e "/usr/local/bin/rsync" | wc -l)
  SSH_PROCESSES=$(ps -U baccount | grep -e "ssh" | wc -l)
  
  echo "$SSH_CONNECTIONS"
  echo "$HTTPS_CONNECTIONS"
  echo "$TNAS_SSH_CONNECTIONS"
  echo "$RSYNC_PROCESSES"
  echo "$SSH_PROCESSES"
  
  if [ "$SSH_CONNECTIONS" -ne "0" -a "$HTTPS_CONNECTIONS" -ne "0" -a "$TNAS_SSH_CONNECTIONS" -ne "0" -a "$RSYNC_PROCESSES" -ne "0" -a "$SSH_PROCESSES" -ne "0" ]; then
  	
  	echo "Processes Running"
  	
  else
  	
  	echo "Shutdown"
  	/root/NOC01TRUENAS01_BACKUP_DISK_USAGE.sh
  	/root/NOC01TRUENAS01_ROOT_DISK_USAGE.sh
  	poweroff
  	
  fi
