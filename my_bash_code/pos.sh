#!/bin/bash

# example : pos POSCAR 0.1

FILE=${1?Error: no name given}

myfloat=${2?Error: no name given}

echo "Creating header and tail"

#generate a header from POSCAR
head -n 8 $FILE > poscar_header

#generate a tail from POSCAR
line_t=$(wc -l < $FILE) #count lines in POSCAR
tail -n $(expr $line_t - 8) POSCAR > poscar_tail

#Add selective dynamic to header
sed -i 's/Direct/S\nDirect/g' poscar_header   # replace Direct with S\nDirect

#Add sufixes to tail
echo Adding suffixes
touch poscar_tail2

file='poscar_tail'
lim=`echo $myfloat |bc`
n=1
while ISF= read -r line
do
   z=$(awk '{print $3}' poscar_tail |sed -n $(expr $n)p)
   if [ $(echo "$z>$lim" |bc) -gt 0 ]
   then
      echo "$line     T T T" >> poscar_tail2
   else
      echo "$line   F F F" >> poscar_tail2
   fi
   n=$((n+1))
done<$file

#Remove POSCAR and combine header and tail
rm $FILE
rm poscar_tail
cat poscar_header poscar_tail2 > POSCAR
rm poscar_header poscar_tail2
echo done!
