#!/bin/bash
#AUTHOR REMY TAN#

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
	read -p "Input Selection: " selection
	case $seleciton in
		Y )
			echo "Yes"
		;;
		N )
			echo "No"
		[Qq]* )
			exit ;;
	
