#!/bin/bash

#Delete formatings from POSCAR

file=${1?Error: no name given}

sed -i 's/T T T//g;s/F F F//g' $file
sed -i 's/0.00000000E+00  0.00000000E+00  0.00000000E+00//g' $file
sed -i '8d' $file
