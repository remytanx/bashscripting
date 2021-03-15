#!/bin/bash
#AUTHOR REMY TAN#

# Global VAR
LOG='/tmp/rhel8-3-remediation.txt'
REXEC='Remediation executed.'
RAPP='Remediation applied.'
EXPECTED='expect: '
# sc1=$(tee -a $LOG)
SC2=$(2>&1 | tee -a $LOG)
FLAG=true

echo "Hello World!"
display_menu(){
	while $FLAG;
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
				echo -e "\nYes is chosen. Proceed with remediation."

				# File exist validation check
				if [[ ! -f "$LOG" ]]
				then
					echo "File '${LOG}' not found. Creating file..."
					# Create a log file for done steps.
					touch /tmp/rhel8-3-remediation.txt
				fi


				# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]
				echo -e "\n# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1111=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1111='$r1111 | tee -a $LOG
				
				if [[ $r1111 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz " ]] 
				then
					# echo "1.1.1.1 $REXEC" 2>&1 | tee -a $log
					echo -e "1.1.1.1" $REXEC | tee -a $LOG

					# Remediation
					echo "Create file, cramfs.conf, in /etc/modprobe.d/ " | tee -a $LOG
					touch /etc/modprobe.d/cramfs.conf
					echo 'Insert CLI: "install cramfs /bin/true" in /etc/modprobe.d/cramfs.conf' | tee -a $LOG
					echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
					echo 'Change mod to 644 to file "/etc/modprobe.d/cramfs.conf"' | tee -a $LOG
					chmod 644 /etc/modprobe.d/cramfs.conf
					echo 'Remove module "cramfs"' | tee -a $LOG
					# 2>&1 = output system error message, STDERR, to display, which is STDOUT.
					# tee is write to file with [-a] option to append to file.
					rmmod cramfs $SC2

					# After remediation
					dr1111=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')

					if [[ $dr1111 == "install /bin/true " ]]
					then
						echo $EXPECTED $dr1111 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo "Remediation is not successful" | tee -a $LOG
						echo 'Output: "'$dr1111'"' | tee -a $LOG
					fi
				fi


				# 1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]
				echo -e "\n#1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1113=$(/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1113='$r1113 | tee -a $LOG

				if [[ $r1113 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/squashfs/squashfs.ko.xz " ]]
				then
					echo -e "1.1.1.3" $REXEC | tee -a $LOG

					# Remediation
					echo "Create file, squashfs.conf, /etc/modprobe.d/ " | tee -a $LOG
					touch /etc/modprobe.d/squashfs.conf
					echo 'Insert CLI: "install squashfs.conf /bin/true" in /etc/modprobe.d/squashfs.conf' | tee -a $LOG
					echo "install squashfs /bin/true" > /etc/modprobe.d/squashfs.conf
					echo 'Change mod to 644 to file "/etc/modprobe.d/squashfs.conf"' | tee -a $LOG
					chmod 644 /etc/modprobe.d/squashfs.conf
					echo 'Remove module "squashfs"' | tee -a $LOG
					rmmod squashfs $SC2

					# After remediation
					dr1113=$(/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')

					if [[ $dr1113 == "install /bin/true " ]]
					then
						echo $EXPECTED $dr1113 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo "Remediation is not successful" | tee -a $LOG
						echo 'Output: "'$dr1113'"' | tee -a $LOG
					fi
				fi


				# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]
				echo -e "\n# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1114=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1114='$r1114 | tee -a $LOG
				
				if [[ $r1114 == "insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/lib/crc-itu-t.ko.xz 
insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/udf/udf.ko.xz " ]] 
				then
					echo -e "1.1.1.4" $REXEC | tee -a $LOG

					# Remediation
					echo "Create file, udf.conf, in /etc/modprobe.d/ " | tee -a $LOG
					touch /etc/modprobe.d/udf.conf
					echo 'Insert CLI: "install udf /bin/true" in /etc/modprobe.d/udf.conf' | tee -a $LOG
					echo "install udf /bin/true" > /etc/modprobe.d/udf.conf
					echo 'Change mod to 644 to file "/etc/modprobe.d/udf.conf"' | tee -a $LOG
					chmod 644 /etc/modprobe.d/udf.conf
					echo 'Remove module "udf"' | tee -a $LOG
					# 2>&1 = output system error message, STDERR, to display, which is STDOUT.
					# tee is write to file with [-a] option to append to file.
					rmmod udf $SC2

					# After remediation
					dr1114=$(/usr/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
					
					if [[ $dr1114 == "install /bin/true " ]]
					then
						echo $EXPECTED $dr1114 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo "Remediation is not successful" | tee -a $LOG
						echo 'Output: "'$dr1114'"' | tee -a $LOG
					fi
				fi


				# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]
				echo -e "\n# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1110=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
				echo 'Set Variable: $r1110='$r1110 | tee -a $LOG
				
				if [[ $r1110 == "" ]] 
				then
					echo -e "1.1.10" $REXEC | tee -a $LOG

					# Remediation
					echo "Backup original file" | tee -a $LOG
					cp /etc/fstab /etc/fstab.original | tee -a $LOG
					echo "Edit file, fstab, in /etc " | tee -a $LOG
					echo -e 'Insert CLI: "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" in /etc/fstab' | tee -a $LOG
					echo -e 'Insert CLI: "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" in /etc/fstab' | tee -a $LOG
					echo -e "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" >> /etc/fstab
					echo -e "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" >> /etc/fstab
					echo -e "mount -o remount,noexec /var/tmp" | tee -a $LOG
					
					# After remediation
					dr1110=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
					
					if [[ $dr1110 == "[\s]*[,]?noexec " ]]
					then
						echo $EXPECTED $dr1110 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo "Remediation is not successful" | tee -a $LOG
						echo 'Output: "'$dr1110'"' | tee -a $LOG
					fi
				fi


			;;
			[Nn]* )
				echo -e "\nNo is chosen. No action will be taken.\n"
			;;
			[Qq]* )
				echo -e "\nQuitting Script..."
				flag=false
				# exit ;;
		esac
	done
}

## Main Function Calls
display_menu
