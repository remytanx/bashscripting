#!/bin/bash

declare -A my_my_array
my_my_array=()


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

# echo -e 
# '
# r1_1_1_1=""
# \ndr1_1_1_1=""
# \nr1_1_1_3=""
# \ndr1_1_1_3=""
# \nr1_1_1_4=""
# \ndr1_1_1_4=""
# \nr1_1_10=""
# \ndr1_1_10=""
# \nr1_1_17=""
# \nr1_1_2=""
# \ndr1_1_2=""

# '
# my_arr["r1_1_1_1"]="= \"\""
# my_arr+=( ["dr1_1_1_1"]="= \"\"" ["r1_1_1_3"]="= \"\"")

for key in ${!my_arr[@]}; do
    echo ${key} ${my_arr[${key}]}
done


echo -e "\nDone execution\n"
