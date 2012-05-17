#!/usr/bin/env bash
email="youraddress@email.com"

tmp="/tmp/check-security-update.$$"

yum="/usr/bin/yum"

$yum check-update --security >& $tmp

yumstatus="$?"

hostname=$(/bin/hostname)

case $yumstatus in
0)
#no updates
exit 0
;;
*)
date=$(date)
number=$(cat $tmp | egrep '(.i386|.i686|.x86_64|.noarch|.src)'|wc -l)
updates=$(cat $tmp|egrep '(.i386|.i686|.x86_64|.noarch|.src)')
echo "
There are $number of security updates available on host $hostname at $date

The available updates are:
$updates
"|/bin/mail -s "Update: $number security updates available for $hostname" $email
;;
esac

#cleanup
rm -f /tmp/check-security-update.*
