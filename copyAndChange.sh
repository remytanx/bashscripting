#!/bin/bash

cp /mnt/usb/rhel8usb.repo /etc/yum.repos.d/
cp /mnt/usb/grub /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub
reboot
