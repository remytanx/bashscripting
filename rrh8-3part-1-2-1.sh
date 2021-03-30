#!/bin/bash

##################################################################
# 1.2.1 Ensure Red Hat Subscription Manager connection is configured : [WARNING]
echo -e "\n## 1.2.1 Ensure Red Hat Subscription Manager connection is configured : [WARNING]" | tee -a $LOG

# Check for the following output
r1_2_1=$(/usr/bin/subscription-manager identity)
echo 'Set Variable: $r1.2.1="'$r1_2_1'"' | tee -a $LOG

if [[ $r1_2_1 == "This system is not yet registered. Try 'subscription-manager register --help' for more information." ]]
then
    echo -e "1.2.1" $REXEC | tee -a $LOG

    # Remediation
    echo "There will be no remediation as this is a Standalone Server." | tee -a $LOG

    # After remediation
    dr1_2_1=$(/usr/bin/subscription-manager identity)
    
    if [[ $dr1_2_1 == "" ]]
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