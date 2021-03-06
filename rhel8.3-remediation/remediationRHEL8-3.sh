#!/bin/bash
#AUTHOR REMY TAN#

# Global VAR
LOG='/tmp/rhel8-3-remediation.txt'
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
<<<<<<< HEAD
				echo -e "\nYes is chosen"
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
=======
				echo -e "\nYes is chosen. Proceed with remediation."

				# File exist validation check
				if [[ ! -f "$LOG" ]]
				then
					echo "File '${LOG}' not found. Creating file..."
					# Create a log file for done steps.
					echo "touch /tmp/rhel8-3-remediation.txt" | tee -a $LOG
					touch /tmp/rhel8-3-remediation.txt 2>&1 | tee -a $LOG
				fi

				###################################################################################
				# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]
				echo -e "\n# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_1_1=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1.1.1.1='$r1_1_1_1 | tee -a $LOG
				
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


				####################################################################################
				# 1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]
				echo -e "\n#1.1.1.3 Ensure mounting of squashfs filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_1_3=$(/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1.1.1.3='$r1_1_1_3 | tee -a $LOG

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


				################################################################################
				# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]
				echo -e "\n# 1.1.1.4 Ensure mounting of udf filesystems is disabled - modprobe : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_1_4=$(/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print ""fail""}')
				echo 'Set Variable: $r1.1.1.4='$r1_1_1_4 | tee -a $LOG
				
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
				################################################################################


				##################################################################
				# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]
				echo -e "\n# 1.1.10 Ensure noexec option set on /var/tmp partition : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_10=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
				echo 'Set Variable: $r1.1.10='$r1_1_10 | tee -a $LOG
				
				if [[ $r1_1_10 == "" ]] 
				then
					echo -e "1.1.10" $REXEC | tee -a $LOG

					# Remediation
					echo "Backup original file" | tee -a $LOG

					if [[ ! -f "/etc/fstab.original" ]]
					then
						echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
						echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.original
					else
						echo "/etc/fstab.original EXIST.." | tee -a $LOG
					fi

					if [[ ! -f "/etc/fstab.backup" ]]
					then
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.backup
					else
						echo "/etc/fstab.backup EXIST.." | tee -a $LOG
						echo "Append difference into /etc/fstab.backup" | tee -a $LOG
						diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
						
					fi

					diffstab=$(diff /etc/fstab /etc/fstab.backup)

					if [[ diffstab != "" ]]
					then
						echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						sed -i 's/^< //' /etc/fstab.backup
					else
						echo "unset diffstab" | tee -a $LOG
						unset diffstab
						echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
					fi

					echo "Edit file, fstab, in /etc " | tee -a $LOG
					echo -e 'Insert CLI: "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" in /etc/fstab' | tee -a $LOG
					echo -e 'Insert CLI: "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" in /etc/fstab' | tee -a $LOG
					echo -e "tmpfs\t/tmp\ttmpfs\tnoexec\t0\t0" >> /etc/fstab
					echo -e "/tmp\t/var/tmp\tnone\trw,noexec,nosuid,nodev,bind\t0\t0" >> /etc/fstab
					echo "Update systemd.." | tee -a $LOG
					echo "systemctl daemon-reload" | tee -a $LOG
					systemctl daemon-reload

					echo "Mount /var/tmp and /tmp without rebooting system" | tee -a $LOG
					echo -e "mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/" | tee -a $LOG
					mount -o rw,noexec,nosuid,nodev,bind /tmp/ /var/tmp/ 2>&1 | tee -a $LOG
					echo -e "mount -o remount,noexec,nosuid,nodev /tmp" | tee -a $LOG
					mount -o remount,noexec,nosuid,nodev /tmp 2>&1 | tee -a $LOG

					# After remediation
					dr1_1_10=$(/usr/bin/mount | /usr/bin/grep 'on /var/tmp ')
					
					if [[ $dr1_1_10 == "[\s]*[,]?noexec " ]]
					then
						echo $EXPECTED $dr1_1_10 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.10\n" | tee -a $LOG
						my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.10")
						# echo -e '\n$counter: '$counter"\n"
						# echo -e "${my_array[3]}"
						# ((counter++))
						echo 'Output: "'$dr1_1_10'"' | tee -a $LOG
					fi
				fi
				####################################################################


				##################################################################
				# 1.1.17 Ensure noexec option set on /dev/shm partition : [FAILED]
				echo -e "\n# 1.1.17 Ensure noexec option set on /dev/shm partition : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_17=$(/bin/mount | /bin/grep 'on /dev/shm ')
				echo 'Set Variable: $r1.1.17='$r1_1_17 | tee -a $LOG
				
				if [[ $r1_1_17 == "tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel)" ||  $r1_1_17 == "" ]] 
				then
					echo -e "1.1.17" $REXEC | tee -a $LOG

					# Remediation
					echo "Backup original file" | tee -a $LOG

					if [[ ! -f "/etc/fstab.original" ]]
					then
						echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
						echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.original
					else
						echo "/etc/fstab.original EXIST.." | tee -a $LOG
					fi

					if [[ ! -f "/etc/fstab.backup" ]]
					then
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.backup
					else
						echo "/etc/fstab.backup EXIST.." | tee -a $LOG
						echo "Append difference into /etc/fstab.backup" | tee -a $LOG
						diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
					fi

					diffstab=$(diff /etc/fstab /etc/fstab.backup)

					if [[ diffstab != "" ]]
					then
						echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						sed -i 's/^< //' /etc/fstab.backup
					else
						echo "unset diffstab" | tee -a $LOG
						unset diffstab
						echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
					fi

					echo "Edit file, fstab, in /etc " | tee -a $LOG
					echo -e 'Insert CLI: "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" in /etc/fstab' | tee -a $LOG
					echo -e "tmpfs\t/dev/shm\ttmpfs\tdefaults,nodev,nosuid,noexec\t0\t0" >> /etc/fstab
					echo "Update systemd.." | tee -a $LOG
					echo "systemctl daemon-reload" | tee -a $LOG
					systemctl daemon-reload
					
					echo "mount -o remount,noexec /dev/shm" | tee -a $LOG
					mount -o remount,noexec /dev/shm 2>&1 | tee -a $LOG
					
					# After remediation
					dr1_1_17=$(/bin/mount | /bin/grep 'on /dev/shm ')
					
					if [[ $dr1_1_17 == "[\s]*[,]?noexec " ]]
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
				####################################################################


				####################################################
				# 1.1.2 Ensure /tmp is configured - mount : [FAILED]
				echo -e "\n# 1.1.2 Ensure /tmp is configured - mount : [FAILED]" | tee -a $LOG

				# Check for the following output
				r1_1_2=$(/usr/bin/mount | /usr/bin/grep /tmp )
				echo 'Set Variable: $r1.1.2='$r1_1_2 | tee -a $LOG
				
				if [[ $r1_1_2 != "" ]] 
				then
					echo -e "1.1.2" $REXEC | tee -a $LOG

					# Remediation
					echo "Backup original file" | tee -a $LOG

					if [[ ! -f "/etc/fstab.original" ]]
					then
						echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
						echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.original
					else
						echo "/etc/fstab.original EXIST.." | tee -a $LOG
					fi

					if [[ ! -f "/etc/fstab.backup" ]]
					then
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.backup
					else
						echo "/etc/fstab.backup EXIST.." | tee -a $LOG
						echo "Append difference into /etc/fstab.backup" | tee -a $LOG
						echo "diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup" | tee -a $LOG
						diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
					fi

					diffstab=$(diff /etc/fstab /etc/fstab.backup)

					if [[ diffstab != "" ]]
					then
						echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						sed -i 's/^< //' /etc/fstab.backup
					else
						echo "unset diffstab" | tee -a $LOG
						unset diffstab
						echo 'Show Variable: diffstab='$diffstab | tee -a $LOG
					fi

					if [[ ! -f "/etc/systemd/system/local-fs.target.wants/tmp.mount" ]]
					then
						echo "File not found.." | tee -a $LOG
						echo "Running systemctl unmask tmp.mount" | tee -a $LOG
						systemctl unmask tmp.mount 2>&1 | tee -a $LOG
						echo "Running systemctl enable tmp.mount" | tee -a $LOG
						systemctl enable tmp.mount 2>&1 | tee -a $LOG
					else
						echo "File Exist.."
					fi

					TMPMOUNTTG=$(cat $LOG | grep "Failed to enable unit: Unit /run/systemd/generator/tmp.mount is transient or generated.")

					if [[ $TMPMOUNTTG != "" ]]
					then
						echo "There is no tmp.mount"
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab.original /etc/fstab
						# echo -e "\nsed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						# sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						# echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						# sed -i 's/^< //' /etc/fstab.backup
						echo "Restore Original fstab" | tee -a $LOG
						echo "yes | cp /etc/fstab.original /etc/fstab" | tee -a $LOG
						yes | cp /etc/fstab.original /etc/fstab
						echo "Update systemd.." | tee -a $LOG
						echo "systemctl daemon-reload" | tee -a $LOG
						systemctl daemon-reload

						# Here is to do the systemctl enable tmp.mount
						echo "Running systemctl enable tmp.mount" | tee -a $LOG
						systemctl enable tmp.mount 2>&1 | tee -a $LOG
						echo "Edit /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
						echo "sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
						sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount

						echo "Restore Backup fstab" | tee -a $LOG
						echo "yes | cp /etc/fstab.backup /etc/fstab" | tee -a $LOG
						yes | cp /etc/fstab.backup /etc/fstab
						echo "Update systemd.." | tee -a $LOG
						echo "systemctl daemon-reload" | tee -a $LOG
						systemctl daemon-reload
					else
						echo "List and verify the existence of tmp.mount" | tee -a $LOG
						echo "ls -lat /etc/systemd/system/local-fs.target.wants/" | tee -a $LOG
						ls -lat /etc/systemd/system/local-fs.target.wants/
					fi

					# After remediation
					dr1_1_2=$(/usr/bin/mount | /usr/bin/grep /tmp )
					
					if [[ $dr1_1_2 == ".*on[\s]+/tmp[\s]+type.*" ]]
					then
						echo $EXPECTED $dr1_1_2 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2\n" | tee -a $LOG
						my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2")
						# echo -e '\n$counter: '$counter"\n"
						# echo -e "${my_array[3]}"
						# ((counter++))
						echo 'Output: "'$dr1_1_2'"' | tee -a $LOG
					fi
				fi
				######################################################


				########################################################
				# 1.1.2 Ensure /tmp is configured - systemctl : [FAILED]
				echo -e "\n1.1.2 Ensure /tmp is configured - systemctl : [FAILED]" | tee -a $LOG

				# Check for the following output
				echo "unset r1_1_2 for reuse.." | tee -a $LOG
				unset r1_1_2
				echo 'Show Variable: $r1.1.2='$r1_1_2 | tee -a $LOG
				r1_1_2=$(/usr/bin/systemctl is-enabled tmp.mount)
				echo 'Set Variable: $r1.1.2='$r1_1_2 | tee -a $LOG
				
				if [[ $r1_1_2 != "" ]] 
				then
					echo -e "1.1.2" $REXEC | tee -a $LOG

					# Remediation
					echo "Backup original file" | tee -a $LOG

					if [[ ! -f "/etc/fstab.original" ]]
					then
						echo "Copy /etc/fstab to /etc/fstab.original" | tee -a $LOG
						echo "yes | cp /etc/fstab /etc/fstab.original" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.original
					else
						echo "/etc/fstab.original EXIST.." | tee -a $LOG
					fi

					if [[ ! -f "/etc/fstab.backup" ]]
					then
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab /etc/fstab.backup
					else
						echo "/etc/fstab.backup EXIST.." | tee -a $LOG
						echo "Append difference into /etc/fstab.backup" | tee -a $LOG
						echo "diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup" | tee -a $LOG
						diff /etc/fstab /etc/fstab.backup >> /etc/fstab.backup
						echo "sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						sed -i 's/^< //' /etc/fstab.backup
					fi

					if [[ ! -f "/etc/systemd/system/local-fs.target.wants/tmp.mount" ]]
					then
						echo "File not found.." | tee -a $LOG
						echo "Running systemctl unmask tmp.mount" | tee -a $LOG
						systemctl unmask tmp.mount 2>&1 | tee -a $LOG
						echo "Running systemctl enable tmp.mount" | tee -a $LOG
						systemctl enable tmp.mount 2>&1 | tee -a $LOG
					else
						echo "File Exist.."
					fi

					TMPMOUNTTG=$(cat $LOG | grep "Failed to enable unit: Unit /run/systemd/generator/tmp.mount is transient or generated.")

					if [[ $TMPMOUNTTG != "" ]]
					then
						echo "There is no tmp.mount"
						echo "yes | cp /etc/fstab /etc/fstab.backup" | tee -a $LOG
						yes | cp /etc/fstab.original /etc/fstab
						echo -e "\nsed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};\${x;p;}' /etc/fstab.backup" | tee -a $LOG
						sed -i -n '/tmpfs/{x;d;};1h;1!{x;p;};${x;p;}' /etc/fstab.backup
						echo "sed -i 's/^< //' /etc/fstab.backup" | tee -a $LOG
						sed -i 's/^< //' /etc/fstab.backup
						echo "Restore Original fstab" | tee -a $LOG
						echo "yes | cp /etc/fstab.original /etc/fstab" | tee -a $LOG
						yes | cp /etc/fstab.original /etc/fstab
						echo "Update systemd.." | tee -a $LOG
						echo "systemctl daemon-reload" | tee -a $LOG
						systemctl daemon-reload

						# Here is to do the systemctl enable tmp.mount
						echo "Running systemctl enable tmp.mount" | tee -a $LOG
						systemctl enable tmp.mount 2>&1 | tee -a $LOG
						echo "Edit /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
						echo "sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount" | tee -a $LOG
						sed -i 's/Options=mode=1777,strictatime,nosuid,nodev/Options=mode=1777,strictatime,noexec,nodev,nosuid/' /etc/systemd/system/local-fs.target.wants/tmp.mount

						echo "Restore Backup fstab" | tee -a $LOG
						echo "yes | cp /etc/fstab.backup /etc/fstab" | tee -a $LOG
						yes | cp /etc/fstab.backup /etc/fstab
						echo "Update systemd.." | tee -a $LOG
						echo "systemctl daemon-reload" | tee -a $LOG
						systemctl daemon-reload
					else
						echo "List and verify the existence of tmp.mount" | tee -a $LOG
						echo "ls -lat /etc/systemd/system/local-fs.target.wants/" | tee -a $LOG
						ls -lat /etc/systemd/system/local-fs.target.wants/
					fi

					# After remediation
					dr1_1_2=$(/usr/bin/mount | /usr/bin/grep /tmp )
					
					if [[ $dr1_1_2 == ".*on[\s]+/tmp[\s]+type.*" ]]
					then
						echo $EXPECTED $dr1_1_2 | tee -a $LOG
						echo $RAPP | tee -a $LOG
					else
						echo -e "\n!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2\n" | tee -a $LOG
						my_array+=("!!! REMEDIATION IS NOT SUCCESSFUL FOR # 1.1.2")
						# echo -e '\n$counter: '$counter"\n"
						# echo -e "${my_array[3]}"
						# ((counter++))
						echo 'Output: "'$dr1_1_2'"' | tee -a $LOG
					fi
				fi
				########################################################

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
>>>>>>> Trial-Run-1
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
