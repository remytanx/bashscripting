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
				echo "Yes"
				# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled - modprobe
				echo ""
				touch /etc/modprobe.d/cramfs.conf
				echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
				chmod 644 /etc/modprobe.d/cramfs.conf
				rmmod cramfs
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