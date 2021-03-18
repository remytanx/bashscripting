#!/bin/bash

unset my_arr
declare -A my_arr
my_arr=()


echo -e "\nExecution\n"


echo "Execute: rm -rf /tmp/rhel8-3-remediation.txt"
rm -rf /tmp/rhel8-3-remediation.txt
echo "Execute: rm -rf /etc/modprobe.d/cramfs.conf"
rm -rf /etc/modprobe.d/cramfs.conf
echo "Execute: rm -rf /etc/modprobe.d/squashfs.conf"
rm -rf /etc/modprobe.d/squashfs.conf
echo "Execute: rm -rf /etc/modprobe.d/udf.conf"
rm -rf /etc/modprobe.d/udf.conf
echo "Execute: yes | cp /etc/fstab.original /etc/fstab"
yes | cp /etc/fstab.original /etc/fstab
echo "Execute: rm -rf /etc/fstab.*"
rm -rf /etc/fstab.*
echo "Mount and Remount"
echo "umount /var/tmp"
umount /var/tmp
echo "mount -o remount,exec /dev/shm"
mount -o remount,exec /dev/shm



echo -e "\nSet all variables back to <empty>"
my_arr+=("r1_1_1_1=")
my_arr+=("dr1_1_1_1=")
my_arr+=("r1_1_1_3=")
my_arr+=("dr1_1_1_3=")
my_arr+=("r1_1_1_4=")
my_arr+=("dr1_1_1_4=")
my_arr+=("r1_1_10=")
my_arr+=("dr1_1_10=")
my_arr+=("r1_1_17=")
my_arr+=("r1_1_2=")
my_arr+=("dr1_1_2=")

for key in ${!my_arr[@]}; do
    echo ${key} ${my_arr[${key}]}
done


echo -e "\nDone execution\n"
