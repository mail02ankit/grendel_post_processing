rm *.png
#rm *.dat

g++ -fopenmp cfft.cpp

#WR-G-loc along t=-t'
awk -v OFS='\t' '{print $1-$2,$7,$8}' ../ad_out.dat >data.dat
./a.out

# Conductivity 
#awk '{print $1, $2/($1+0.000001), $3/($1+0.000001)}' out.dat >cond.dat
#module load python
#python chi_cond.py

#gnuplot GnuPlot.gnu
#montage img1.jpg img2.jpg img3.jpg img4.jpg -geometry +2+2 cond.jpg
#rm img*

