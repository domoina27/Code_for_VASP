#!/bin/bash

#Immobilizing z > 0.2 and 0.03 < x < 0.85

#generate a header from POSCAR
head -n 8 POSCAR > poscar_header

#generate a tail from POSCAR
line_t=$(wc -l < POSCAR) #count lines in POSCAR
tail -n $(expr $line_t - 8) POSCAR > poscar_tail

#Add selective dynamic to header
sed -i 's/Direct/S\nDirect/g' poscar_header   # replace Direct with S\nDirect

#Add sufixes to tail
echo Adding suffixes
touch poscar_tail2

file='poscar_tail'
limz=`echo 0.2 |bc`
limx1=`echo 0.04 |bc`
limx2=`echo 0.85 |bc`
n=1
while ISF= read -r line
do
   z=$(awk '{print $3}' poscar_tail |sed -n $(expr $n)p)
   x=$(awk '{print $1}' poscar_tail |sed -n $(expr $n)p)

   if [ $(echo "$z>$limz" |bc) -gt 0 ] && [ $(echo "$x>$limx1" |bc) -gt 0 ] && [ $(echo "$x<$limx2" |bc) -gt 0 ]
   then
      echo "$line     T T T" >> poscar_tail2
   else
      echo "$line   F F F" >> poscar_tail2
   fi
   n=$((n+1))
done<$file

#Remove POSCAR and combine header and tail
rm POSCAR
rm poscar_tail
cat poscar_header poscar_tail2 > POSCAR
rm poscar_header poscar_tail2
echo done!
