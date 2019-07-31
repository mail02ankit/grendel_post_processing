g++ cfft.cpp

#WR-G< along t=-t'
awk -v OFS='\t' '{print $1-$2,$5,$6}' ../ad_out.dat >data.dat
./a.out
gnuplot GnuPlot.gnu
montage img1.png img2.png img3.png img4.png -geometry +2+2 ad-wg-l.png
rm img*

#WR-G> along t=-t'
awk -v OFS='\t' '{print $1-$2,$7,$8}' ../ad_out.dat >data.dat
./a.out
gnuplot GnuPlot.gnu
montage img1.png img2.png img3.png img4.png -geometry +2+2 ad-wg-g.png
rm img*

#WR-F< along t=-t'
awk -v OFS='\t' '{print $1-$2,$9,$10}' ../ad_out.dat >data.dat
./a.out
gnuplot GnuPlot.gnu
montage img1.png img2.png img3.png img4.png -geometry +2+2 ad-wf-l.png
rm img*

#WR-F> along t=-t'
awk -v OFS='\t' '{print $1-$2,$11,$12}' ../ad_out.dat >data.dat
./a.out
gnuplot GnuPlot.gnu
montage img1.png img2.png img3.png img4.png -geometry +2+2 ad-wf-g.png
rm img*

