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
        echo -e "/etc/fstab.original created and backup" | tee -a $LOG
    else
        echo "/etc/fstab.original EXIST.." | tee -a $LOG
    fi

    if [[ ! -f "/etc/fstab.backup" ]]
    then
        echo "Copy /etc/fstab to /etc/fstab.backup" | tee -a $LOG
        echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.backup
        echo -e "/etc/fstab.backup created and backup" | tee -a $LOG
    else
        echo "/etc/fstab.backup EXIST.." | tee -a $LOG
        echo "Appending difference into /etc/fstab.backup" | tee -a $LOG
        diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup

        echo "Show FILE /etc/fstab.backup"
        cat /etc/fstab.backup
    fi

    diffstab=$(diff /etc/fstab /etc/fstab.backup)

    echo -e '\nThe diffstab value="\n'$diffstab'\n"' | tee -a $LOG

    if [[ $diffstab != "" ]]
    then
        echo "diffstab is NOT empty!?" | tee -a $LOG

        # echo "sed -i -n '/^< tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
        # sed -i -n '/^< tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
        # echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        # sed -i 's/^< //' /etc/fstab.backup

        # The fstab.backup is still normal with rhel-swap

        echo "sed -i '/^[0-9]/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^[0-9]/d' /etc/fstab.backup
        echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        sed -i 's/^< //' /etc/fstab.backup
    else
        echo "diffstab is empty.."
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
    fi

    echo "Edit file, fstab, in /etc " | tee -a $LOG
    echo -e 'Insert CLI: "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" in /etc/fstab' | tee -a $LOG
    echo -e "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" >> /etc/fstab
    echo "Update systemd.." | tee -a $LOG
    echo "Execute: systemctl daemon-reload" | tee -a $LOG
    systemctl daemon-reload
    
    # The fstab and fstab.backup is still normal with rhel-swap

    checkExist=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')

    echo -e '$checkExist="'$checkExist'"'

    if [[ ! -z $checkExist ]]
    then
        echo "Mounted. Need to umount first." | tee -a $LOG
        echo -e "Execute: umount /tmp" | tee -a $LOG
        umount /tmp 2>&1 | tee -a $LOG
        echo "Do: mount  /dev/shm" | tee -a $LOG
        mount /dev/shm 2>&1 | tee -a $LOG
    else
        echo "NOT mounted" | tee -a $LOG
        echo "Do: mount  /dev/shm" | tee -a $LOG
        mount /dev/shm 2>&1 | tee -a $LOG
    fi


    # echo "Do: mount  /dev/shm" | tee -a $LOG
    # mount /dev/shm 2>&1 | tee -a $LOG
    
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