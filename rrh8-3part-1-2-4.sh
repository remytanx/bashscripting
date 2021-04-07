#!/bin/bash

##################################################################
# 1.2.4 Ensure gpgcheck is globally activated"" : [FAILED]
echo -e "\n## 1.2.4 Ensure gpgcheck is globally activated : [FAILED]" | tee -a $LOG

# Check for the following output
echo "Create a checkVar.txt file." | tee -a $LOG
touch /root/checkVar.txt

echo -e "Check for gpgcheck=1" | tee -a $LOG
grep -r 'gpgcheck=1' /etc/yum.repos.d/ | tee -a /root/checkVar.txt
grep -r 'gpgcheck=1' /etc/yum.conf | tee -a /root/checkVar.txt

r1_2_4=$(cat /root/checkVar.txt)
echo 'Set Variable: $r1.2.4="'$r1_2_4'"' | tee -a $LOG

echo "Remove /root/checkVar.txt" | tee -a $LOG 
rm -rf /root/checkVar.txt

if [[ -z $r1_2_4 ]]
then
    echo -e "1.2.4" $REXEC | tee -a $LOG

    # Remediation
    echo "e" | tee -a $LOG

    # After remediation
    echo "Create a checkVar.txt file." | tee -a $LOG
    touch /root/checkVar.txt

    echo -e "Check for subscription-manager registration" | tee -a $LOG
    /usr/bin/subscription-manager identity 2> /root/checkVar.txt

    dr1_2_4=$(cat /root/checkVar.txt)
    echo 'Set Variable: $dr1.2.4="'$dr1_2_4'"' | tee -a $LOG

    if [[ $dr1_2_4 == "" ]]
    then
        echo $EXPECTED $dr1_2_4 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.2.4\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.2.4")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[4]}"
        # ((counter++))
        echo 'Output: "'$dr1_2_4'"' | tee -a $LOG
    fi

    echo "Remove /root/checkVar.txt" | tee -a $LOG
    rm -rf /root/checkVar.txt
fi