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
				echo "\nYes is chosen"
				# Create a log file for done steps.
				touch /tmp/rhel8-3-remediation.txt
				# Create and assign local environment variable
				log='/tmp/rhel8-3-remediation.txt'
				# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe
				echo "# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe" >> $log

				# Before remediation

				# STDOUT
				echo "Before remediation result:"
				echo "Actual Value:"
				echo "The command '/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}''"
				echo "returned :"
				echo "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz"

				# Write to file
				echo "Before remediation result:" >> $log
				echo "Actual Value:" >> $log
				echo "The command '/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}''" >> $log
				echo "returned :" >> $log
				echo "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz" >> $log
				echo "Below is command executed with the returned value" | tee -a $log
				/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}' 2>&1 | tee -a $log
				echo "End of execution" | tee -a $log

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
				echo "After remediation" | tee -a $log
				echo "Policy Value:" | tee -a $log
				echo "cmd: /usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}'" | tee -a $log
				echo "expect: install /bin/true" | tee -a $log
				echo "system: Linux" | tee -a $log
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
