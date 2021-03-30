#!/bin/bash

##################################################################
# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]
echo -e "\n# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_10=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
echo 'Set Variable: $r1.1.10="'$r1_1_10'"' | tee -a $LOG

if [[ $r1_1_10 == "" ]] 
then
    echo -e "1.1.10" $REXEC | tee -a $LOG

    # Remediation
    echo "Backup original file" | tee -a $LOG

    if [[ ! -f "/etc/fstab.original" ]]
    then
        echo "/etc/fstab.original file does not exist.." | tee -a $LOG
        echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
        # echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.original
        echo -e "/etc/fstab.original created and backup" | tee -a $LOG
    else
        echo "/etc/fstab.original EXIST.." | tee -a $LOG
    fi

    if [[ ! -f "/etc/fstab.backup" ]]
    then
        echo "/etc/fstab.backup file does not exist.." | tee -a $LOG
        echo "Copy /etc/fstab to /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.backup
        echo -e "/etc/fstab.backup created and backup" | tee -a $LOG
    else
        echo "/etc/fstab.backup EXIST.." | tee -a $LOG
        echo "Appending difference into /etc/fstab.backup" | tee -a $LOG
        diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
    fi

    diffstab=$(diff /etc/fstab /etc/fstab.backup)

    # echo -e '\nThe diffstab value="'$diffstab'"'

    if [[ $diffstab != "" ]]
    then
        echo "diffstab is NOT empty!?"

        # Commented on 25 March 2021 because I cannot see the step yet...
        # echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
        # sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
        # echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        # sed -i 's/^< //' /etc/fstab.backup

        echo "sed -i '/^[0-9]/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^[0-9]/d' /etc/fstab.backup
        echo "sed -i '/^<.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^<.*/d' /etc/fstab.backup
        echo "sed -i '/^---.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^---.*/d' /etc/fstab.backup
        echo "sed -i '/^>.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^>.*/d' /etc/fstab.backup
    else
        echo "diffstab is empty.." | tee -a $LOG
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab="'$diffstab'"' | tee -a $LOG
    fi

    echo "Edit file, fstab, in /etc " | tee -a $LOG
    echo -e 'Insert CLI: "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" in /etc/fstab' | tee -a $LOG
    echo -e 'Insert CLI: "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" in /etc/fstab' | tee -a $LOG
    echo -e "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" >> /etc/fstab
    echo -e "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" >> /etc/fstab
    echo "Update systemd.." | tee -a $LOG
    echo "Execute: systemctl daemon-reload" | tee -a $LOG
    systemctl daemon-reload

    echo "Mount /var/tmp and /tmp without rebooting system" | tee -a $LOG
    echo -e "Execute: mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/" | tee -a $LOG
    mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/ 2>&1 | tee -a $LOG
    
    # echo -e "Execute: mount -o remount,noexec,nosuid,nodev /tmp" | tee -a $LOG
    # mount -o remount,noexec,nosuid,nodev /tmp 2>&1 | tee -a $LOG

    checkExist=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')

    echo -e '$checkExist="'$checkExist'"' | tee -a $LOG

    # !!! HERE IS THE FUCKING MOUNT /TMP PROBLEM !!!
    # Try reboot will solve the missing files and folder in the /tmp
    # YES! All the folders come back

    if [[ ! -z $checkExist ]]
    then
        echo "Mounted. Need to umount first." | tee -a $LOG
        echo -e "Execute: umount /tmp" | tee -a $LOG
        umount /tmp 2>&1 | tee -a $LOG
        echo -e "Execute: mount /tmp" | tee -a $LOG
        mount /tmp 2>&1 | tee -a $LOG
        echo -e "Execute: mount -o remount /tmp" | tee -a $LOG
        mount -o remount /tmp | tee -a $LOG
    else
        echo "NOT mounted" | tee -a $LOG
        echo -e "Execute: mount /tmp" | tee -a $LOG
        mount /tmp 2>&1 | tee -a $LOG
        echo -e "Execute: mount -o remount /tmp" | tee -a $LOG
        mount -o remount /tmp | tee -a $LOG
    fi

    # After remediation
    dr1_1_10=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
    
    if [[ $dr1_1_10 == "[\s]*[,]?noexec " ]]
    then
        echo $EXPECTED $dr1_1_10 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.10\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.10")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[3]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_10'"' | tee -a $LOG
    fi
fi
####################################################################