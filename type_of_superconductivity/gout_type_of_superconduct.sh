#!/bin/bash
#Update on 161101 by Ankit
# This script uses wigner.dat file to calculate different orbital components of superconducting gap.

awk 'BEGIN{n=1};{print n,$2,$3}{n=n+1}' ../../field.dat >field.dat
cp ../../wigner.dat data.dat

awk -v OFS='\t' '{print $1,$2,$3,$4,$5,$6,$7,$8};{print $1,$2,$4,$3,$5,$6,$7,$8}' data.dat| sort -n -k 1 -k 3 -k 4 -u  > temp.dat	# If you want to print the density.
mv temp.dat data.dat

g++ -fopenmp cDataExtract.cpp
./a.out
