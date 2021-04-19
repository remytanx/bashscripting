#!/bin/bash

####################################################
# 1.1.2 Ensure /tmp is configured - mount : [FAILED]
echo -e "\n# 1.1.2 Ensure /tmp is configured - mount : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_2=$(/usr/bin/mount | /usr/bin/grep /tmp )
echo 'Set Variable: $r1.1.2="'$r1_1_2'"' | tee -a $LOG

if [[ $r1_1_2 != "" ]] 
then
    echo -e "1.1.2" $REXEC | tee -a $LOG

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
        echo "diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup" | tee -a $LOG
        diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup

        # The fstab and fstab.backup is still normal with rhel-swap
    fi

    diffstab=$(diff /etc/fstab /etc/fstab.backup)

    echo -e '\n!!! The diffstab value:"'$diffstab'"'

    if [[ diffstab != "" ]]
    then
        echo -e 'diffstab is not empty!!'
        # The fstab and fstab.backup is still normal with rhel-swap
        # The following sed will remove the /dev/shm in /etc/fstab file causing everything to go weird
        
        # echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
        # sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
        # echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        # sed -i 's/^< //' /etc/fstab.backup

        echo "sed -i '/^[0-9]/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^[0-9]/d' /etc/fstab.backup
        echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        sed -i 's/^< //' /etc/fstab.backup
        echo "sed -i '/^---.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^---.*/d' /etc/fstab.backup
        echo "sed -i '/^>.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^>.*/d' /etc/fstab.backup

        # echo -e "\n!!!!! /ETC/FSTAB"
        # cat /etc/fstab
        # echo -e "\n!!!!! /ETC/FSTAB.BACKUP"
        # cat /etc/fstab.backup
    else
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
    fi

    if [[ ! -f "/etc/systemd/system/local-fs.target.wants/tmp.mount" ]]
    then
        echo "File not found.." | tee -a $LOG
        echo "Running systemctl unmask tmp.mount" | tee -a $LOG
        systemctl unmask tmp.mount 2>&1 | tee -a $LOG
        echo "Running systemctl enable tmp.mount" | tee -a $LOG
        systemctl enable tmp.mount 2>&1 | tee -a $LOG
        TMPMOUNTTG=$(cat $LOG | grep "Failed to enable unit: Unit /run/systemd/generator/tmp.mount is transient or generated.")
    else
        echo "File Exist.."
        unset TMPMOUNTTG
    fi

    if [[ $TMPMOUNTTG != "" ]]
    then
        # echo "!!!!! /ETC/FSTAB"
        # cat /etc/fstab
        # echo "!!!!! /ETC/FSTAB.BACKUP"
        # cat /etc/fstab.backup
        echo "There is no tmp.mount"
        echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.backup
        # yes | cp /etc/fstab.original /etc/fstab
        echo -e "\nRestore Original fstab" | tee -a $LOG
        echo "yes | cp /etc/fstab.original /etc/fstab" | tee -a $LOG
        yes | cp /etc/fstab.original /etc/fstab
        # cat /etc/fstab
        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload

        # Here is to do the systemctl unmask and enable tmp.mount
        # Do the disable of tmp.mount first
        echo "Running systemctl disable tmp.mount" | tee -a $LOG
        systemctl disable tmp.mount 2>&1 | tee -a $LOG
        echo "Running systemctl unmask tmp.mount" | tee -a $LOG
        systemctl unmask tmp.mount 2>&1 | tee -a $LOG
        echo "Running systemctl enable tmp.mount" | tee -a $LOG
        systemctl enable tmp.mount 2>&1 | tee -a $LOG
        echo "Edit /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
        echo "sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /usr/lib/systemd/system/tmp.mount" | tee -a $LOG
        sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /usr/lib/systemd/system/tmp.mount

        # cat /etc/fstab.backup

        # Here is the place where the fstab.backup is screwed.
        # Commented on 26 March 2021 above screw up is done.
        # Found on 29 March 2021 that in /etc/fstab, a newline of /tmp is appended in /etc/fstab instead of replacing. RT
        echo "Restore Backup fstab" | tee -a $LOG
        echo "Copy /etc/fstab.backup /etc/fstab" | tee -a $LOG
        echo "yes | cp /etc/fstab.backup /etc/fstab" | tee -a $LOG
        yes | cp /etc/fstab.backup /etc/fstab
        echo "Edit file, fstab, in /etc " | tee -a $LOG

        # Here is where I will use sed to find and replace the tmpfs\t/tmp\ttmpfs line.. 29 March 2021

        echo "Create a changelog.txt file" | tee -a $LOG
        touch /root/changelog.txt

        sed -i "s/^tmpfs\t\/tmp\ttmpfs.*/tmpfs\t\/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0/w /root/changelog.txt" "/etc/fstab"
        if [ -s /root/changelog.txt ]; then
            echo "# CHANGES MADE, DO SOME STUFF HERE"
            echo -e 'Edit and insert CLI: "tmpfs\t/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0" in /etc/fstab' | tee -a $LOG
            # echo -e "tmpfs\t/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0" >> /etc/fstab
        else
            echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
        fi

        echo "Remove /root/changelog.txt" | tee -a $LOG
        rm -rf /root/changelog.txt

        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload

        # echo "Mount /var/tmp and /tmp without rebooting system" | tee -a $LOG
        # echo -e "Execute: mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/" | tee -a $LOG
        # mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/ 2>&1 | tee -a $LOG
        # echo -e "Execute: mount -o remount,defaults,rw,nosuid,nodev,noexec,relatime /tmp" | tee -a $LOG
        # mount -o remount,defaults,rw,nosuid,nodev,noexec,relatime /tmp 2>&1 | tee -a $LOG

        checkExist=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')

        echo -e '$checkExist="'$checkExist'"'

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


        # echo -e "Execute: mount /tmp" | tee -a $LOG
        # mount /tmp 2>&1 | tee -a $LOG        
    else
        echo "List and verify the existence of tmp.mount" | tee -a $LOG
        echo "ls -lat /etc/systemd/system/local-fs.target.wants/" | tee -a $LOG
        ls -lat /etc/systemd/system/local-fs.target.wants/
    fi

    # After remediation
    dr1_1_2=$(/usr/bin/mount | /usr/bin/grep /tmp )
    
    if [[ $dr1_1_2 == ".*on[\s]+/tmp[\s]+type.*" ]]
    then
        echo $EXPECTED $dr1_1_2 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[3]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_2'"' | tee -a $LOG
    fi
fi
######################################################