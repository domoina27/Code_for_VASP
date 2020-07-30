#!/bin/bash


sed -i 's/Direct/S\nDirect/g' POSCAR   # replace Direct with S\nDirect
sleep 2s  #sleep for 2 seconds
line_t=$(wc -l < POSCAR)
sed -n -e 11,$(expr $line_t)p POSCAR | awk '{print $3}' # read column 3 from line 11 to 116


file='table'
lim=`echo 0.1 |bc`
n=1
while ISF= read -r line
do
   z=$(awk '{print $3}' table |sed -n $(expr $n)p)
   if [ $(echo "$z>$lim" |bc) -gt 0 ]
       then
            echo $z is greater than 0.1
       else
            echo "$z is smaller than 0.1"
   fi
   n=$((n+1))
done<$file

