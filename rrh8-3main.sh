#!/bin/bash
#AUTHOR REMY TAN#

# Global VAR
LOG='/root/rhel8-3-remediation.txt'
REXEC='Remediation executed.'
RAPP='Remediation applied.'
EXPECTED='expect: '
# SC1=$(>> $LOG)
# SC2=$(2>&1 | tee -a $LOG)
FLAG=true
unset my_array
# declare -A my_array
my_array=()
# counter=0
# FILE_FSTAB='/etc/fstab'
TMPMOUNTTG=""

echo "Hello World!"
display_menu(){
	while $FLAG;
	do
		echo -e "\n======================================="
		echo "Best effort Remediation for RHEL 8.3"
		echo "======================================="
		echo "WARNING: ONLY RUN THIS SCRIPT AFTER PERFORMED THE hardeningRhel7.sh"
		echo "LEGEND: # - MANUAL REMEDIATION ## - FAILED"
		echo "DO YOU WANT TO CONTINUE??"
		echo "(Y) Yes"
		echo "(N) No"
		echo "(q) Quit"
		read -p "Input Selection: " selection
		case $selection in
			[Yy]* )
				echo -e "\nYes is chosen. Proceed with remediation."

				# File exist validation check
				if [[ ! -f "$LOG" ]]
				then
					echo "File '${LOG}' not found. Creating file..."
					# Create a log file for done steps.
					echo "touch /root/rhel8-3-remediation.txt" | tee -a $LOG
					touch /root/rhel8-3-remediation.txt 2>&1 | tee -a $LOG
				fi

				# Commented on 25 March 2021 to troubleshoot the sed on 1-1-10

				. ./rrh8-3part-1-1-1-1.sh
                . ./rrh8-3part-1-1-1-3.sh
                . ./rrh8-3part-1-1-1-4.sh
                . ./rrh8-3part-1-1-10.sh
                . ./rrh8-3part-1-1-17.sh
                . ./rrh8-3part-1-1-2.sh
                . ./rrh8-3part-1-1-2ii.sh
				. ./rrh8-3part-1-1-3.sh
				. ./rrh8-3part-1-1-4.sh
				. ./rrh8-3part-1-1-5.sh
				. ./rrh8-3part-1-1-8.sh
				. ./rrh8-3part-1-1-9.sh
				. ./rrh8-3part-1-2-1.sh


			echo -e "\nList FAILED (my_array)\n"
			for i in "${my_array[@]}"; do echo "$i"; done
			# echo "${my_array[@]}"
			# echo "${my_array[0]}"
			# echo "${my_array[1]}"
			# echo "${my_array[2]}"
			# echo "${my_array[3]}"
			# echo -e '\n$counter: '$counter"\n"
			# ((counter++))
			# echo -e '\n$counter: '$counter"\n"
			echo -e "\nEnd Of Remediation..\n"
			;;
			[Nn]* )
				echo -e "\nNo is chosen. No action will be taken.\n"
			;;
			[Qq]* )
				echo -e "\nQuitting Script..."
				FLAG=false
				# exit ;;
		esac
	done
}

## Main Function Calls
display_menu
