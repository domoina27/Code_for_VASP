!/bin/bash


sed -i 's/Direct/S\nDirect/g' POSCAR   # replace Direct with S\nDirect
sleep 2s  #sleep for 2 seconds
line_t=$(wc -l < POSCAR)
sed -n -e 11,$(expr $line_t)p POSCAR | awk '{print $3}' # read column 3 from line 11 to 116


filename='table'
limit=`echo 0.1 + 0.001 |bc`
n=1
while read Line; do
z=$(awk '{print $3}' table |sed -n $(expr $n)p )
Z=`echo $z + 0.000001|bc`
if [ $Z>$limit ] 
        then
                echo "Line $n is larger than $limit"
                echo "$Z"
        else
                echo "Line $n is smaller than $limit"
                echo $Z
        fi
n=$((n+1))
done < $filename
