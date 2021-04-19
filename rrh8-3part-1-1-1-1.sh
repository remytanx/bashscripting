#!/bin/bash

###################################################################################
# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]
echo -e "\n# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_1_1=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
echo 'Set Variable: $r1.1.1.1="'$r1_1_1_1'"' | tee -a $LOG

if [[ $r1_1_1_1 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz " ]] 
then
    # echo "1.1.1.1 $REXEC" 2>&1 | tee -a $log
    echo -e "1.1.1.1" $REXEC | tee -a $LOG

    # Remediation
    echo "Create file, cramfs.conf, in /etc/modprobe.d/ " | tee -a $LOG
    touch /etc/modprobe.d/cramfs.conf 2>&1 | tee -a $LOG
    echo 'Insert CLI: "install cramfs /bin/true" in /etc/modprobe.d/cramfs.conf' | tee -a $LOG
    echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
    echo 'Change mod to 644 to file "/etc/modprobe.d/cramfs.conf"' | tee -a $LOG
    chmod 644 /etc/modprobe.d/cramfs.conf 2>&1 | tee -a $LOG
    echo 'Remove module "cramfs"' | tee -a $LOG
    # 2>&1 = output system error message, STDERR, to display, which is STDOUT.
    # tee is write to file with [-a] option to append to file.
    rmmod cramfs 2>&1 | tee -a $LOG

    # After remediation
    dr1_1_1_1=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')

    if [[ $dr1_1_1_1 == "install /bin/true " ]]
    then
        echo $EXPECTED $dr1_1_1_1 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.1.1\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.1.1")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[0]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_1_1'"' | tee -a $LOG
    fi
fi
###################################################################################