# Automated TrueNAS Core Backup

Full Blog Post - https://knowledgeaddict.co.uk/2025/01/31/automate-your-home-backup-server-setup-easily/

## Introduction
Let's be honest, we all need better processes for our backups. It's the dirty little secret of many people in IT. Some go for the do nothing approach. Some go for the overly complicated approach. I think a healthy balance in between the two can give you enough confidence in your home storage without you feeling like running your home IT is a systems admin job that never ends with no help.

### Goal
The goal I was trying to achieve with my set up is that the backup server will turn on a set few times a month, automatically backup my main NAS server and then power off again. In addition to my main goal, I want visibility into the process so that I can have some assurance the automated process is working and if not then I can get notified.

### Setup
Some things to note about my setup. My main NAS is a TerraMaster NAS using BTRFS. My backup server is a Dell Poweredge (hence why I'm so keen on automated power on and off to save some monies) running TrueNAS Core using ZFS. My home service monitoring is done by Uptime Kuma and I use Home Assistant as my dashboard and home service manager.

## Configuration
- Cronjob to start Rsync task to copy data from main NAS to backup NAS. Rsync is running over SSH utilising an RSA keypair.
- Cronjob to start the Rsync task monitor script just after Rsync task starts. The monitor will push the result to an Uptime Kuma push monitor.
- Cronjob runs every 30 minutes to check if the system is idle and then power down the server. Idle is defined as no HTTPS or SSH connections established and no Rsync task running.
