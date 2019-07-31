# Density plot data, 1d plot data.
# This script extract data from data/Wttp_k file for kx,ky for fixed t and t'.
rm *.png
rm out.dat d.dat w.dat

t1=0
t2=0

k1=-2.00277
k2=-2.00277

for filename in $(ls ../../data/Wk_ttp_k*)
do
	cp $filename w.dat 

	sed 's/^ *//' w.dat| awk 'NF' >d.dat 	# to remove starting white spaces
	rm w.dat 

	echo $filename $t1 $t2

	# If you print for fixed t, t'. It gives f(kx,ky).
	#awk -v t=$t1 -v tt=$t2 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 -t )<= 0.001 && abs( $2 -tt )<= 0.001){print $0; exit 1}}' d.dat >>out.dat
	
	# For fixed t,t' and kx, ky# WTF you are thinking. It will give only single point.
	awk -v t=$t1 -v tt=$t2 -v k=$k1 -v kk=$k2 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 -t )<= 0.001 && abs( $2 -tt )<= 0.001 && abs( $3 - k ) <= 0.001 && abs( $4 - kk ) <= 0.001){print $0; exit 1}}' d.dat #>>out.dat
	
	rm d.dat
done

#Plot script
sort -n -k 3 -k 4 -u out.dat >temp.dat
mv temp.dat out.dat
gnuplot GnuPlot_t.gnu
convert -density 150 img.eps -quality 90 -background white -flatten out.png
rm *.eps  
