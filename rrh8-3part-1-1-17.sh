#!/bin/bash

##################################################################
# 1.1.17 Ensure noexec option set on /dev/shm partition : [FAILED]
echo -e "\n# 1.1.17 Ensure noexec option set on /dev/shm partition : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_17=$(/bin/mount | /bin/grep 'on /dev/shm ')
echo 'Set Variable: $r1.1.17="'$r1_1_17'"' | tee -a $LOG

if [[ $r1_1_17 == "tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel)" ||  $r1_1_17 == "" ]] 
then
    echo -e "1.1.17" $REXEC | tee -a $LOG

    # Remediation
    echo "Backup original file" | tee -a $LOG

    if [[ ! -f "/etc/fstab.original" ]]
    then
        echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
        echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.original
    else
        echo "/etc/fstab.original EXIST.." | tee -a $LOG
    fi

    if [[ ! -f "/etc/fstab.backup" ]]
    then
        echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.backup
    else
        echo "/etc/fstab.backup EXIST.." | tee -a $LOG
        echo "Append difference into /etc/fstab.backup" | tee -a $LOG
        diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
    fi

    diffstab=$(diff /etc/fstab /etc/fstab.backup)

    if [[ diffstab != "" ]]
    then
        echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
        sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
        echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        sed -i 's/^< //' /etc/fstab.backup
    else
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
    fi

    echo "Edit file, fstab, in /etc " | tee -a $LOG
    echo -e 'Insert CLI: "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" in /etc/fstab' | tee -a $LOG
    echo -e "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" >> /etc/fstab
    echo "Update systemd.." | tee -a $LOG
    echo "systemctl daemon-reload" | tee -a $LOG
    systemctl daemon-reload
    
    echo "mount -o remount,noexec /dev/shm" | tee -a $LOG
    mount -o remount,noexec /dev/shm 2>&1 | tee -a $LOG
    
    # After remediation
    dr1_1_17=$(/bin/mount | /bin/grep 'on /dev/shm ')
    
    if [[ $dr1_1_17 == "[\s]*[,]?noexec " ]]
    then
        echo $EXPECTED $dr1_1_17 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.17\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.17")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[4]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_17'"' | tee -a $LOG
    fi
fi
####################################################################