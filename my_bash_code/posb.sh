#!/bin/bash

#Delete formatings from POSCAR

sed -i 's/T T T//g;s/F F F//g' POSCAR
sed -i '8d' POSCAR
