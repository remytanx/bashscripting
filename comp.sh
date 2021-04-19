#~/bin/bash
str1="Hello"
str2="World!"
str3="Hello"

echo -e '\n$str1: ' $str1
echo -e '$str2: ' $str2
echo -e '$str3: ' $str3 '\n'


if [[ $str1 == $str3 ]];
then
	echo "match"
else
	echo -e '\n!match'
	echo -e '$str1:' $str1
	echo -e '$str2:' $str2
	echo -e '$str3:' $str3 '\n'
fi

if [[ "$str1" == "$str3" ]];
then
	echo "match"
else
	echo -e '\n!match'
	echo -e '$str1:' $str1
	echo -e '$str2:' $str2
	echo -e '$str3:' $str3 '\n'
fi

if [[ "$str1" == "$str2" ]];
then
	echo "match"
else
	echo -e '\n!match'
	echo -e '$str1:' $str1
	echo -e '$str2:' $str2
	echo -e '$str3:' $str3 '\n'
fi

if [[ $str1 == $str2 ]];
then
	echo "match"
else
	echo -e '\n!match'
	echo -e '$str1:' $str1
	echo -e '$str2:' $str2
	echo -e '$str3:' $str3 '\n'
fi


cli=$(/usr/sbin/modprobe -n -v cramfs | /usr/bin/awk '{print} END {if (NR == 0)print fail}')

echo -e '\n$cli: ' $cli

rpy="insmod /lib/modules/4.18.0-240.el8.x86_64/kernel/fs/cramfs/cramfs.ko.xz "

echo -e '$rpy: ' $rpy

if [[ $cli == $rpy ]];
then
	echo "match"
else
	echo -e '\n!match'
	echo -e '$cli: "'$cli'"'
	echo -e '$rpy: "'$rpy'"'
fi
