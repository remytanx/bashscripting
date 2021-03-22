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
ls -lat /tmp | grep rhel
ls -lat /etc/modprobe.d
ls -lat /etc | grep fstab

echo -e "\nList FAILED\n"
if [[ -f "/tmp/rhel8-3-remediation.txt" ]]
then
    cat /tmp/rhel8-3-remediation.txt | grep "NOT SUCCESSFUL"
else
    echo -e "File Does Not EXIST..\n"
fi