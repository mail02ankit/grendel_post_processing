# This script extract data from data/Wttp_k file for fixed kx,ky along two diagonal in t,t' plane..
rm *.png
rm d_out.dat ad_out.dat d.dat w.dat

filename="../../data/Wk_ttp_k026"
tmax=199

cp $filename w.dat 

sed 's/^ *//' w.dat| awk 'NF' >d.dat 	# to remove starting white spaces
rm w.dat 

echo $filename 

# It prints for diagonal line in t,t' plane.
awk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 - $2 )<= 0.001 ){print $0}}' d.dat >d_out.dat

# It prints for anit-diagonal line in t,t' plane.
awk -v tt=$tmax 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 + $2 - tt )<= 0.001){print $0}}' d.dat >ad_out.dat

rm d.dat

#Plot script

gnuplot GnuPlot_k.gnu
convert -density 150 img1.eps -quality 90 -background white -flatten 01aaa.png
convert -density 150 img2.eps -quality 90 -background white -flatten 02aaa.png
convert -density 150 img3.eps -quality 90 -background white -flatten 03aaa.png
convert -density 150 img4.eps -quality 90 -background white -flatten 04aaa.png
convert -density 150 img5.eps -quality 90 -background white -flatten 05aaa.png
convert -density 150 img6.eps -quality 90 -background white -flatten 06aaa.png
convert -density 150 img7.eps -quality 90 -background white -flatten 07aaa.png
convert -density 150 img8.eps -quality 90 -background white -flatten 08aaa.png
montage  01aaa.png 02aaa.png 03aaa.png 04aaa.png -geometry +2+2 d-g.png
montage  05aaa.png 06aaa.png 07aaa.png 08aaa.png -geometry +2+2 d-f.png

#Adiagonal
convert -density 150 img11.eps -quality 90 -background white -flatten 01aaa.png
convert -density 150 img12.eps -quality 90 -background white -flatten 02aaa.png
convert -density 150 img13.eps -quality 90 -background white -flatten 03aaa.png
convert -density 150 img14.eps -quality 90 -background white -flatten 04aaa.png
convert -density 150 img15.eps -quality 90 -background white -flatten 05aaa.png
convert -density 150 img16.eps -quality 90 -background white -flatten 06aaa.png
convert -density 150 img17.eps -quality 90 -background white -flatten 07aaa.png
convert -density 150 img18.eps -quality 90 -background white -flatten 08aaa.png
montage  01aaa.png 02aaa.png 03aaa.png 04aaa.png -geometry +2+2 ad-g.png
montage  05aaa.png 06aaa.png 07aaa.png 08aaa.png -geometry +2+2 ad-f.png

rm *.eps 
rm 0*
