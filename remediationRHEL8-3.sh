#!/bin/bash
#AUTHOR REMY TAN#
echo "Hello World!"
display_menu(){
	while true;
	do
		echo "======================================="
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
				echo -e "\nYes is chosen. Proceed with remediation.\n"
				
				# Create and assign local environment variable
				log='/tmp/rhel8-3-remediation.txt'
				
				# File exist validation check
				if [[ ! -f "$log" ]]
				then
					echo "File '${log}' not found. Creating file..."
					# Create a log file for done steps.
					touch /tmp/rhel8-3-remediation.txt
				fi

				# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe
				echo "# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe" >> $log

				# Check for rhe following output
				r1111=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}') 2>&1 | tee -a $log 
				
				if [[ $r1111 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz" ]] 
				then
					echo "1.1.1.1 Remediation executed." 2>&1 | tee -a $log

					# Remediation
					echo "Create file, cramfs.conf, in /etc/modprobe.d/ " >> $log
					touch /etc/modprobe.d/cramfs.conf
					echo 'Insert CLI: "install cramfs /bin/true" in /etc/modprobe.d/cramfs.conf' >> $log
					echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
					echo 'Change mod to 644 to file "/etc/modprobe.d/cramfs.conf"' >> $log
					chmod 644 /etc/modprobe.d/cramfs.conf
					echo 'Remove module "cramfs"' >> $log
					# 2>&1 = output system error message, STDERR, to display, which is STDOUT.
					# tee is write to file with [-a] option to append to file.
					rmmod cramfs 2>&1 | tee -a $log

					# After remediation
					dr1111=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}') | tee -a $log

					if [[ $dr1111 == "install /bin/true" ]]
					then
						echo "Remediation applied." | tee -a $log
					fi
				fi
			;;
			[Nn]* )
				echo "No"
			;;
			[Qq]* )
				exit ;;
		esac
	done
}

## Main Function Calls
display_menu
