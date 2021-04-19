#!/bin/bash

#!/bin/bash

############################################################
# 1.1.9 Ensure nosuid option set on /var/tmp partition : [FAILED]
echo -e "\n# 1.1.9 Ensure nosuid option set on /var/tmp partition : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_9=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
echo 'Set Variable: $r1.1.9="'$r1_1_9'"' | tee -a $LOG

if [[ $r1_1_9 == "" ]] 
then
    echo -e "1.1.9" $REXEC | tee -a $LOG

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
    fi

    # I am adding the nodev fix here. 29 March 2021, RT
    # Here, it is to check if "nodev" exist.. Continue writing..

    echo "Create a changelog.txt file" | tee -a $LOG
    touch /root/changelog.txt

    sed -i "s/^/tmp\t/var/tmp\tnone\trw,noexec.*/\/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0/w /root/changelog.txt" "/etc/fstab"
    if [ -s /root/changelog.txt ]; then
        echo "# CHANGES MADE, DO SOME STUFF HERE"
        echo -e 'Edit and insert CLI: "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" in /etc/fstab' | tee -a $LOG
        # echo -e "tmpfs\t/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0" >> /etc/fstab
    else
        echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
    fi

    echo "Remove /root/changelog.txt" | tee -a $LOG
    rm -rf /root/changelog.txt

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
        echo "sed -i '/^---.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^---.*/d' /etc/fstab.backup
        echo "sed -i '/^>.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^>.*/d' /etc/fstab.backup
    else
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
        
        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload
    fi

    # After remediation
    # echo "unset dr1_1_9 for reuse.." | tee -a $LOG
    # unset dr1_1_9
    echo 'Show Variable: $dr1.1.9="'$dr1_1_9'"' | tee -a $LOG
    dr1_1_9=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
    
    if [[ $dr1_1_9 == "[\s]*[,]?nosuid" ]]
    then
        echo $EXPECTED $dr1_1_9 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.9\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.9")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[3]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_9'"' | tee -a $LOG
    fi
else
    echo 'Show Variable: $r1.1.9="'$r1_1_9'"' | tee -a $LOG
    echo "/var/tmp is already mounted. Verification needed for the mount." | tee -a $LOG
    echo -e "1.1.9" $REXEC | tee -a $LOG

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
    fi

    # I am adding the nodev fix here. 29 March 2021, RT
    # Here, it is to check if "nodev" exist.. Continue writing..

    echo "Create a changelog.txt file" | tee -a $LOG
    touch /root/changelog.txt

    sed -i "s/^/tmp\t/var/tmp\tnone\trw,noexec.*/\/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0/w /root/changelog.txt" "/etc/fstab"
    if [ -s /root/changelog.txt ]; then
        echo "# CHANGES MADE, DO SOME STUFF HERE"
        echo -e 'Edit and insert CLI: "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" in /etc/fstab' | tee -a $LOG
        # echo -e "tmpfs\t/tmp\ttmpfs\tdefaults,rw,nosuid,nodev,noexec,relatime\t0\t0" >> /etc/fstab
    else
        echo "# NO CHANGES MADE, DO SOME OTHER STUFF HERE"
    fi

    echo "Remove /root/changelog.txt" | tee -a $LOG
    rm -rf /root/changelog.txt

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
        echo "sed -i '/^---.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^---.*/d' /etc/fstab.backup
        echo "sed -i '/^>.*/d' /etc/fstab.backup" | tee -a $LOG
        sed -i '/^>.*/d' /etc/fstab.backup
    else
        echo "unset diffstab" | tee -a $LOG
        unset diffstab
        echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
        
        echo "Update systemd.." | tee -a $LOG
        echo "systemctl daemon-reload" | tee -a $LOG
        systemctl daemon-reload
    fi

    # After remediation
    # echo "unset dr1_1_9 for reuse.." | tee -a $LOG
    # unset dr1_1_9
    echo 'Show Variable: $dr1.1.9="'$dr1_1_9'"' | tee -a $LOG
    dr1_1_9=$(/usr/bin/mount | /usr/bin/grep 'on /tmp ')
    
    if [[ $dr1_1_9 == "[\s]*[,]?nosuid" ]]
    then
        echo $EXPECTED $dr1_1_9 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.9\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.9")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[3]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_9'"' | tee -a $LOG
    fi
fi
############################################################