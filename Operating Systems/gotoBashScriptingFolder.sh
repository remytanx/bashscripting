#!/bin/bash

clear

touch checkhgfs
df -h > checkhgfs

mountCheck=""
mountCheck=$(cat checkhgfs | grep vmhgfs)
echo $mountCheck

emptyFolderCheck=""

if [[ "$(ls -A /mnt/hgfs/Shared\ Folder)" ]]
then
	echo "Folder NOT empty"
	emptyFolderCheck="Not Empty"
else
	echo "Folder is Empty"
	emptyFolderCheck="Empty"
fi


if [[ -z $mountCheck || $emptyCheck == "Empty" ]]
then
	echo "There is no mount.."
	rm -rf /mnt/hgfs/Shared\ Folder/
	mkdir /mnt/hgfs/Shared\ Folder/
	vmhgfs-fuse .host:/Shared\ Folder/bashscripting /mnt/hgfs/Shared\ Folder -o subtype=vmhgfs-fuse,allow_other
	echo "Go To bashscripting Folder.."
	cd /mnt/hgfs/Shared\ Folder/
else
	echo "There is mount.."
	umount /mnt/hgfs/Shared\ Folder/
	rm -rf /mnt/hgfs/Shared\ Folder/
	mkdir /mnt/hgfs/Shared\ Folder/
	vmhgfs-fuse .host:/Shared\ Folder/bashscripting /mnt/hgfs/Shared\ Folder -o subtype=vmhgfs-fuse,allow_other
	echo "Go To bashscripting Folder.."
	cd /mnt/hgfs/Shared\ Folder/
fi

rm -rf ~/checkhgfs
unset mountCheck
unset emptyCheck
