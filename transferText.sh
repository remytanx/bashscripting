#!/bin/bash

# echo -e "\nExecute command"
# dr1114=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
# echo '$dr1114: "'$dr1114'"'
# echo -e "Command executed\n"


# echo -e "\nExecute command"
# /sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}'
# echo -e "Command executed\n"


echo -e "\nExecute command\n"
echo "mount -o remount,noexec /var/tmp"
mount -o remount,noexec /var/tmp
dr1110=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
echo '$dr1110: "'$dr1110'"'
echo "mount | grep -E '\s/var/tmp\s' | grep -v noexec"
mount | grep -E '\s/var/tmp\s' | grep -v noexec

/usr/bin/mount | /usr/bin/grep 'on /var/tmp '

echo -e "\nCommand executed\n"

# tmpfs	/tmp	tmpfs	noexec	0	0
# /tmp	/var/tmp	none	rw,noexec,nosuid,nodev,bind	0	0


# echo -e "\nExecute command"

# if [[ ! -f "/etc/fstab.original" ]]
#     then
#         echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
#         echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
#         yes | cp /etc/fstab /etc/fstab.original | tee -a $LOG
#     else
#         echo "/etc/fstab.original EXIST.." | tee -a $LOG
#         echo "yes | cp /etc/fstab /etc/fstab.backup | tee -a $LOG"
#         yes | cp /etc/fstab /etc/fstab.backup | tee -a $LOG
#     fi

# echo -e "Command executed\n"


# echo -e "\nExecute command"

# if [[ ! -f "/etc/fstab.backup*" ]]
#     then
#         echo "yes | cp /etc/fstab /etc/fstab.backup | tee -a $LOG"
#         yes | cp /etc/fstab /etc/fstab.backup | tee -a $LOG
#     else
#         echo 'yes | cp /etc/fstab /etc/fstab.backup | tee -a $LOG'
#         diff /etc/fstab /etc/fstab.backup | tee -a $LOG
#         cat /etc/fstab
# fi

# echo -e "\nCommand executed\n"


echo -e "\nExecute command\n"

/bin/mount | /bin/grep 'on /dev/shm '

echo -e "\nCommand executed\n"