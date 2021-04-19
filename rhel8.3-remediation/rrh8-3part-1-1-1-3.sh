#/bin/bash

####################################################################################
# 1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]
echo -e "\n#1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_1_3=$(/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
echo 'Set Variable: $r1.1.1.3="'$r1_1_1_3'"' | tee -a $LOG

if [[ $r1_1_1_3 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/squashfs/squashfs.ko.xz " ]]
then
    echo -e "1.1.1.3" $REXEC | tee -a $LOG

    # Remediation
    echo "Create file, squashfs.conf, /etc/modprobe.d/ " | tee -a $LOG
    touch /etc/modprobe.d/squashfs.conf 2>&1 | tee -a $LOG
    echo 'Insert CLI: "install squashfs.conf /bin/true" in /etc/modprobe.d/squashfs.conf' | tee -a $LOG
    echo "install squashfs /bin/true" > /etc/modprobe.d/squashfs.conf
    echo 'Change mod to 644 to file "/etc/modprobe.d/squashfs.conf"' | tee -a $LOG
    chmod 644 /etc/modprobe.d/squashfs.conf 2>&1 | tee -a $LOG
    echo 'Remove module "squashfs"' | tee -a $LOG
    rmmod squashfs 2>&1 | tee -a $LOG

    # After remediation
    dr1_1_1_3=$(/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')

    if [[ $dr1_1_1_3 == "install /bin/true " ]]
    then
        echo $EXPECTED $dr1_1_1_3 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.1.3\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.1.3")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[1]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_1_3'"' | tee -a $LOG
    fi
fi
####################################################################################