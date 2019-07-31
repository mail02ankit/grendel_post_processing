# Density plot data, 1d plot data.
rm *.dat *.png

in='../../../wigner.dat'
infile='w.dat'

cp $in $infile

sed 's/^ *//' $infile| awk 'NF' >d.dat 	# to remove starting white spaces
mv d.dat $infile

awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3 - $4)<= 0.001){print $0}}' $infile >temp.dat				# it prints data along kx=ky axis
awk -f pm3d.awk temp.dat >d_out.dat
#awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($4)<= 0.001){print $0}}' $infile >fd_out.dat				# it prints data along ky=0.0 axis

#Plot script
gnuplot GnuPlot.gnu

rm temp.dat $infile 
