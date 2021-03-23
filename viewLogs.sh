#!/bin/bash

clear
echo "View Logs in /tmp/rhel8-3-remediation.txt"
if [[ -f "/tmp/rhel8-3-remediation.txt" ]]
then
    cat /tmp/rhel8-3-remediation.txt
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

# echo "Check if tmp.mount is enabled"
# list

echo -e "\nList FAILED\n"
if [[ -f "/tmp/rhel8-3-remediation.txt" ]]
then
    cat /tmp/rhel8-3-remediation.txt | grep "NOT SUCCESSFUL"
else
    echo -e "File Does Not EXIST..\n"
fi

echo -e "\nEnd of View Logs\n"