awk -v OFS='\t' '{print $3,$4,$5,$6,$7,$8}' ../../wigner.dat >data.dat
#awk -v OFS='\t' '{print $3,$4,$5,$6,$7,$8}' ../../wigner.dat >data.dat

for i in 1 2 3 4 5 6 
do
	echo "Column:" $i "min-average-max"
	awk -v j=$i -f awk.awk data.dat
done
