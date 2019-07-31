# Density plot data, 1d plot data.
rm *.dat *.png

tmax=$(tail -1 ../../dens000.dat |awk '{print $1}')
in='../../W000.dat'
infile='w.dat'

cp $in $infile

sed 's/^ *//' $infile| awk 'NF' >d.dat 	# to remove starting white spaces
mv d.dat $infile

awk -v tt=$tmax -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($1+$2-tt)<= 0.001){print $0}}' $infile >ad_out.dat				# it prints data along t=-t' axis
awk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($1-$2)<= 0.001){print $0}}' $infile >d_out.dat				# it prints data along t=t' axis

#Plot script
gnuplot GnuPlot.gnu
convert -density 150 img1.eps -quality 90 -background white -flatten ad_W.png
convert -density 150 img2.eps -quality 90 -background white -flatten ad_WR.png
convert -density 150 img3.eps -quality 90 -background white -flatten d_W.png
convert -density 150 img4.eps -quality 90 -background white -flatten d_WR.png

rm *.eps $infile 

