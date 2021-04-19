#/bin/bash

##############################################################################
# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]
echo -e "\n# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

# Check for the following output
r1_1_1_4=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
echo 'Set Variable: $r1.1.1.4="'$r1_1_1_4'"' | tee -a $LOG

if [[ $r1_1_1_4 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/lib/crc-itu-t.ko.xz 
insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/udf/udf.ko.xz " ]] 
then
    echo -e "1.1.1.4" $REXEC | tee -a $LOG

    # Remediation
    echo "Create file, udf.conf, in /etc/modprobe.d/ " | tee -a $LOG
    touch /etc/modprobe.d/udf.conf 2>&1 | tee -a $LOG
    echo 'Insert CLI: "install udf /bin/true" in /etc/modprobe.d/udf.conf' | tee -a $LOG
    echo "install udf /bin/true" > /etc/modprobe.d/udf.conf
    echo 'Change mod to 644 to file "/etc/modprobe.d/udf.conf"' | tee -a $LOG
    chmod 644 /etc/modprobe.d/udf.conf 2>&1 | tee -a $LOG
    echo 'Remove module "udf"' | tee -a $LOG
    # 2>&1 = output system error message, STDERR, to display, which is STDOUT.
    # tee is write to file with [-a] option to append to file.
    rmmod udf 2>&1 | tee -a $LOG

    # After remediation
    dr1_1_1_4=$(/usr/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
    
    if [[ $dr1_1_1_4 == "install /bin/true " ]]
    then
        echo $EXPECTED $dr1_1_1_4 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL for # 1.1.1.4\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL for # 1.1.1.4")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[2]}"
        # ((counter++))
        echo 'Output: "'$dr1_1_1_4'"' | tee -a $LOG
    fi
fi
##############################################################################