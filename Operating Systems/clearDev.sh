#!/bin/bash

# Delete enp* and Wired connection #
nmcli connection delete enp1s0
nmcli connection delete enp2s0
nmcli connection delete enp3s0f0
nmcli connection delete enp3s0f1
nmcli connection delete enp3s0f2
nmcli connection delete enp3s0f3
nmcli connection delete 'Wired connection 1'
nmcli connection delete 'Wired connection 2'
nmcli connection delete 'Wired connection 3'
nmcli connection delete 'Wired connection 4'
nmcli connection delete 'Wired connection 5'
nmcli connection delete 'Wired connection 6'
nmcli connection show
