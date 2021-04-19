#!/bin/bash

##################################################################
# 1.2.1 Ensure Red Hat Subscription Manager connection is configured : [WARNING]
echo -e "\n## 1.2.1 Ensure Red Hat Subscription Manager connection is configured : [WARNING]" | tee -a $LOG

# Check for the following output
echo "Create a checkVar.txt file." | tee -a $LOG
touch /root/checkVar.txt

echo -e "Check for subscription-manager registration" | tee -a $LOG
/usr/bin/subscription-manager identity 2> /root/checkVar.txt

r1_2_1=$(cat /root/checkVar.txt)
echo 'Set Variable: $r1.2.1="'$r1_2_1'"' | tee -a $LOG

echo "Remove /root/checkVar.txt" | tee -a $LOG
rm -rf /root/checkVar.txt

if [[ $r1_2_1 == "This system is not yet registered. Try 'subscription-manager register --help' for more information." ]]
then
    echo -e "1.2.1" $REXEC | tee -a $LOG

    # Remediation
    echo "There will be no remediation as this is a Standalone Server." | tee -a $LOG

    # After remediation
    echo "Create a checkVar.txt file." | tee -a $LOG
    touch /root/checkVar.txt

    echo -e "Check for subscription-manager registration" | tee -a $LOG
    /usr/bin/subscription-manager identity 2> /root/checkVar.txt

    dr1_2_1=$(cat /root/checkVar.txt)
    echo 'Set Variable: $dr1.2.1="'$dr1_2_1'"' | tee -a $LOG

    if [[ $dr1_2_1 == "" ]]
    then
        echo $EXPECTED $dr1_2_1 | tee -a $LOG
        echo $RAPP | tee -a $LOG
    else
        echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.2.1\n" | tee -a $LOG
        my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.2.1")
        # echo -e '\n$counter: '$counter"\n"
        # echo -e "${my_array[4]}"
        # ((counter++))
        echo 'Output: "'$dr1_2_1'"' | tee -a $LOG
    fi

    echo "Remove /root/checkVar.txt" | tee -a $LOG
    rm -rf /root/checkVar.txt
fi