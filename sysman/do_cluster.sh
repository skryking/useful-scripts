#!/bin/bash
for host in `cat hostlist`; do
echo $host
echo "----------------------"
if ping -c 1 $host > /dev/null
then
ssh -l root $host $@
else
echo "System dead"
fi
echo " "
done
