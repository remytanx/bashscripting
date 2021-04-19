#!/bin/bash

# echo -e "\nExecute command"
# dr1114=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
# echo '$dr1114: "'$dr1114'"'
# echo -e "Command executed\n"


# echo -e "\nExecute command"
# /sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}'
# echo -e "Command executed\n"


# echo -e "\nExecute command\n"
# echo "mount -o remount,noexec /var/tmp"
# mount -o remount,noexec /var/tmp
# dr1110=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
# echo '$dr1110: "'$dr1110'"'
# echo "mount | grep -E '\s/var/tmp\s' | grep -v noexec"
# mount | grep -E '\s/var/tmp\s' | grep -v noexec

# /usr/bin/mount | /usr/bin/grep 'on /var/tmp '
# echo -e "\nCommand executed\n"


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


# echo -e "\nExecute command\n"
# /bin/mount | /bin/grep 'on /dev/shm '
# echo -e "\nCommand executed\n"


### NEED TO unset array after use ###
# echo -e "\nExecute command\n"
# my_array=("Command executed")     # This array declaration works
# my_array=(Command executed)     # This array declaration works
# my_array+=("Execute command")
# my_array+=(Execute command)
# echo "${my_array[@]}"
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# /usr/bin/mount | /bin/grep /tmp     # This returns empty string
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# sed 's/foo/bar/g' hello.txt       # This works
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# while read -r line                # This works to print out strings in text files
# do
#     line=${line##*/}
#     echo "${line%\"}"
# done < "hello.txt"
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# filename=hello.txt

# sed -i "s/foo/bar/w changelog.txt" "$filename"
# if [ -s changelog.txt ]; then
#     echo "# CHANGES MADE, DO SOME STUFF HERE"
# else
#     echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
# fi
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# filename=fstab

# Before
# echo -e "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" >> $filename
# echo -e "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" >> $filename
# echo "2 lines added.."
# cat fstab

# After
# sed -i "s/tmpfs\t\/tmp\ttmpfs/tmpfs\t\/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0/w changelog.txt" "$filename"
# if [ -s changelog.txt ]; then
#     echo "# CHANGES MADE, DO SOME STUFF HERE"
# else
#     echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
# fi
# cat fstab
# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"

# FILE="/etc/fstab.backup"

# cat $FILE

# sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
# sed -i 's/^< //' /etc/fstab.backup

# sed -i -n '/^< /{s/.*//;x;d;};x;p;${x;p;}' /etc/fstab.backup | sed ' sed '/^$/d''

# sed '/^[0-9]/d' $FILE
# sed 's/^< //' /etc/fstab.backup
# cat $FILE

# echo -e "\nunset \$FILE"
# unset FILE
# echo -e '$FILE:"'$FILE'"'

# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"
# filename="rhel8-3-remediation.txt.log"
# # touch changelog.txt

# systemctl enable tmp.mount 2>&1 | tee -a $filename

# FOUND=$(cat $filename | grep "Failed to enable unit: Unit /run/systemd/generator/tmp.mount is transient or generated.")

# echo $FOUND
# if [[ $FOUND != "" ]]
# then
#     echo "FOUND!"
# else
#     echo "NOT FOUND!"
# fi

# echo -e "\nCommand executed\n"

# sed 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount

# echo -e "\nCommand executed\n"


# echo -e "\nCommand executed\n"

# # Check for the following output
# echo "unset r1_1_2 for reuse.." | tee -a $LOG
# unset r1_1_2
# echo 'Show Variable: $r1.1.2='$r1_1_2 | tee -a $LOG
# r1_1_2=$(/usr/bin/systemctl is-enabled tmp.mount)
# echo 'Set Variable: $r1.1.2='$r1_1_2 | tee -a $LOG

# echo -e "\nCommand executed\n"


# echo -e "\nExecute command\n"

# /usr/bin/mount | /usr/bin/grep 'on /tmp '

# echo -e "\nCommand executed\n"



# echo -e "\nExecute command\n"

# checkExist=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')

# echo -e '$checkExist="'$checkExist'"'

# if [[ ! -z $checkExist ]]
# then
#     echo "Mounted"
# else
#     echo "NOT mounted"
# fi

# echo -e "\nCommand executed\n"sed -i '/^---.*/d' /etc/fstab.backup

# touch test.txt
# /usr/bin/subscription-manager identity 2> test.txt
# echo 'Set Variable: $r1.2.1="'$r1_2_1'"' | tee -a test.txt

# echo "Create a checkVar.txt file." #| tee -a $LOG
# touch /root/checkVar.txt

# echo -e "Check for subscription-manager registration" #| tee -a $LOG
# /usr/bin/subscription-manager identity 2> /root/checkVar.txt

# r1_2_1=$(cat /root/checkVar.txt)
# echo 'Set Variable: $r1.2.1="'$r1_2_1'"' #| tee -a $LOG

# echo "Remove /root/checkVar.txt" | tee -a $LOG
# rm -rf /root/checkVar.txt

echo "Create a checkVar.txt file."
touch /root/checkVar.txt

echo -e "Check for gpgcheck=1"
# grep -r 'gpgcheck=10' /etc/yum.repos.d/ | tee -a /root/checkVar.txt
# grep -r 'gpgcheck=10' /etc/yum.conf | tee -a /root/checkVar.txt
grep -r 'gpgcheck=1' yum.conf | tee -a /root/checkVar.txt

r1_2_4=$(cat /root/checkVar.txt)
echo 'Set Variable: $r1.2.4="'$r1_2_4'"'

echo "Remove /root/checkVar.txt"
rm -rf /root/checkVar.txt

touch changelog.txt

if [[ -z $r1_2_4 ]]
then
    sed -i "s/gpgcheck=.*/gpgcheck=1/w changelog.txt" yum.conf
    if [ -s changelog.txt ]; then
        echo "# CHANGES MADE, DO SOME STUFF HERE"
    else
        echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
    fi
else
    echo -e "Got things"
fi

rm -rf changelog.txt
unset r1_2_4