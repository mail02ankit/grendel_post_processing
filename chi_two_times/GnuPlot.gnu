# General Settings
#set xtics font "Helvetica-Bold,14" 
#set ytics font "Helvetica-Bold,14"
#set border linewidth 2 
#set terminal postscript eps enhanced color	
set terminal jpeg enhanced size 1368,768 font 'DejaVuSansCondensed-Bold,14'

set key

set ylabel 'Y' 
set xlabel't'
##set title 'Fermi Surface, Mu=0.0'
unset multiplot
set o 'img.jpg'
set multiplot layout 2,2 title 't=-t'
p'ad_out.dat' u ($2-$1):3 w lp t'chi-real' 
p'ad_out.dat' u ($2-$1):4 w lp t'chi-imag' 

