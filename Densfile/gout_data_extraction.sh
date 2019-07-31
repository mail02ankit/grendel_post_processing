# Density plot data, 1d plot data.

in='../../dens.dat'
infile='w.dat'

rm *.dat *.png
cp $in $infile

sed 's/^ *//' $infile| awk 'NF' >d.dat 	# to remove starting white spaces
mv d.dat $infile

awk -v OFS="\t" '{print $0}' $infile |awk 'NF' >out.dat			# It prints 4 columns and remove blank line from data.

#Plot script
gnuplot GnuPlot.gnu
convert -density 150 img.eps -quality 90 -background white -flatten out.png
rm img.eps $infile 
