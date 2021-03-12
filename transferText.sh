#!/bin/bash

# echo -e "\nExecute command"
# dr1114=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
# echo '$dr1114: "'$dr1114'"'
# echo -e "Command executed\n"


# echo -e "\nExecute command"
# /sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}'
# echo -e "Command executed\n"


echo -e "\nExecute command"
echo "mount -o remount,noexec /var/tmp"
mount -o remount,noexec /var/tmp
dr1110=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
echo '$dr1110: "'$dr1110'"'
echo "mount | grep -E '\s/var/tmp\s' | grep -v noexec"
mount | grep -E '\s/var/tmp\s' | grep -v noexec
echo -e "Command executed\n"

tmpfs	/tmp	tmpfs	noexec	0	0
/tmp	/var/tmp	none	rw,noexec,nosuid,nodev,bind	0	0
