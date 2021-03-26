#!/bin/bash

####################################################
# 1.1.2 Ensure /tmp is configured - systemctl : [FAILED]
echo -e "\n# 1.1.2 Ensure /tmp is configured - systemctl : [FAILED]" | tee -a $LOG

# Check for the following output
echo "unset r1_1_2 for reuse.." | tee -a $LOG
unset r1_1_2
echo 'Show Variable: $r1.1.2="'$r1_1_2'"' | tee -a $LOG
r1_1_2=$(/usr/bin/systemctl is-enabled tmp.mount)
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
        echo "Copy /etc/fstab to /etc/fstab.backup" | tee -a $LOG
        echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab /etc/fstab.backup
    else
        echo "/etc/fstab.backup EXIST.." | tee -a $LOG
        echo "Append difference into /etc/fstab.backup" | tee -a $LOG
        echo "diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup" | tee -a $LOG
        diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
    fi

    diffstab=$(diff /etc/fstab /etc/fstab.backup)

    if [[ $diffstab != "" ]]
    then
        echo -e 'diffstab is not empty!!'

        # echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
        # sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
        # echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        # sed -i 's/^< //' /etc/fstab.backup

        echo "sed -i '/^[0-9]/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^[0-9]/d' /etc/fstab.backup
        echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
        sed -i 's/^< //' /etc/fstab.backup
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
        echo "There is no tmp.mount"
        echo "Copy /etc/fstab.original /etc/fstab" | tee -a $LOG
        echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
        yes | cp /etc/fstab.original /etc/fstab
        echo "Restore Original fstab" | tee -a $LOG
        echo "Copy /etc/fstab.original /etc/fstab" | tee -a $LOG
        echo "yes | cp /etc/fstab.original /etc/fstab" | tee -a $LOG
        yes | cp /etc/fstab.original /etc/fstab
        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload

        # Here is to do the systemctl enable tmp.mount
        echo "Running systemctl enable tmp.mount" | tee -a $LOG
        systemctl enable tmp.mount 2>&1 | tee -a $LOG
        echo "Edit /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
        echo "sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
        sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount

        echo "Restore Backup fstab" | tee -a $LOG
        echo "Copy /etc/fstab.backup /etc/fstab" | tee -a $LOG
        echo "yes | cp /etc/fstab.backup /etc/fstab" | tee -a $LOG
        yes | cp /etc/fstab.backup /etc/fstab
        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload

        checkExist=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')

        echo -e '$checkExist="'$checkExist'"'

        if [[ ! -z $checkExist ]]
        then
            echo "Mounted. Need to umount first." | tee -a $LOG
            echo -e "Execute: umount /tmp" | tee -a $LOG
            umount /tmp 2>&1 | tee -a $LOG
            echo -e "Execute: mount /tmp" | tee -a $LOG
            mount /tmp 2>&1 | tee -a $LOG
        else
            echo "NOT mounted" | tee -a $LOG
            echo -e "Execute: mount /tmp" | tee -a $LOG
            mount /tmp 2>&1 | tee -a $LOG
        fi

    else
        echo "List and verify the existence of tmp.mount" | tee -a $LOG
        echo "ls -lat /etc/systemd/system/local-fs.target.wants/" | tee -a $LOG
        ls -lat /etc/systemd/system/local-fs.target.wants/
    fi

    # After remediation
    echo "unset dr1_1_2 for reuse.." | tee -a $LOG
    unset dr1_1_2
    echo 'Show Variable: $dr1.1.2="'$dr1_1_2'"' | tee -a $LOG
    dr1_1_2=$(/usr/bin/systemctl is-enabled tmp.mount)
    
    if [[ $dr1_1_2 == "enabled" ]]
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