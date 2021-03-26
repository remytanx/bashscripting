#!/bin/bash

clear
echo "View Logs in /root/rhel8-3-remediation.txt"
if [[ -f "/root/rhel8-3-remediation.txt" ]]
then
    cat /root/rhel8-3-remediation.txt
else
    echo -e "File Does Not EXIST..\n"
fi

echo "List Files in Directories"
echo "List /tmp and grep rhel"
ls -lat /tmp | grep rhel
echo -e "\nList /etc/modprobe.d"
ls -lat /etc/modprobe.d
echo -e "\nList /etc and grep fstab"
ls -lat /etc | grep fstab
echo -e "\n/etc/systemd/system/local-fs.target.wants/ and grep tmp"
ls -lat /etc/systemd/system/local-fs.target.wants/ | grep tmp

echo -e "\nCheck mount points"
echo -e "\n/usr/bin/mount | /usr/bin/grep 'on /var/tmp '"
/usr/bin/mount | /usr/bin/grep 'on /var/tmp '
echo -e "\n/bin/mount | /bin/grep 'on /dev/shm '"
/bin/mount | /bin/grep 'on /dev/shm '
echo -e "\n/usr/bin/mount | /bin/grep /tmp"
/usr/bin/mount | /bin/grep /tmp
echo -e "\n/usr/bin/mount | /usr/bin/grep 'on /tmp '"
/usr/bin/mount | /usr/bin/grep 'on /tmp '
echo -e "\nsystemctl is-enabled tmp.mount"
/usr/bin/systemctl is-enabled tmp.mount


echo -e "\nCheck df -h"
df -h

echo -e "\nList FAILED\n"
if [[ -f "/root/rhel8-3-remediation.txt" ]]
then
    cat /root/rhel8-3-remediation.txt | grep "NOT SUCCESSFUL"
else
    echo -e "File Does Not EXIST..\n"
fi

echo -e "\nEnd of View Logs\n"