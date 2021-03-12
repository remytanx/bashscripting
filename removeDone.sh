#!/bin/bash

echo -e "\nExecution"
echo "Execute: rm -rf /tmp/rhel8-3-remediation.txt"
rm -rf /tmp/rhel8-3-remediation.txt
echo "Execute: rm -rf /etc/modprobe.d/cramfs.conf"
rm -rf /etc/modprobe.d/cramfs.conf
echo "Execute: rm -rf /etc/modprobe.d/squashfs.conf"
rm -rf /etc/modprobe.d/squashfs.conf
echo "Execute: rm -rf /etc/modprobe.d/udf.conf"
rm -rf /etc/modprobe.d/udf.conf
echo "Execute: cp /etc/fstab.original /etc/fstab"
yes | cp /etc/fstab.original /etc/fstab
echo -e "\nDone execution\n"
