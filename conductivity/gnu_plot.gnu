# General Settings
set xtics 
set ytics 
#set grid

set terminal postscript eps enhanced color	

#Time domain
set ylabel 'Current' font "Helvetica-Bold,14"
set xlabel 't' font "Helvetica-Bold,12"
set o 'img.eps'
p[][]'out/J000.dat' u 1:2 w lp t'Pump current' 
!convert -density 150 img.eps -quality 90 -background white -flatten img1.png
!rm img.eps

set o 'img.eps'
p[100:][]'out/J000.dat' u 1:2 w lp t'Tail of pump current' 
!convert -density 150 img.eps -quality 90 -background white -flatten img2.png
!rm img.eps

set o 'img.eps'
set ylabel 'Current' font "Helvetica-Bold,14"
set xlabel 't' font "Helvetica-Bold,12"
p'out/J002.dat' u 1:2 w lp t'Probe current ' 
!convert -density 150 img.eps -quality 90 -background white -flatten img3.png
!rm img.eps

#
##FT
#set xlabel 'w' font "Helvetica-Bold,12"
#set o 'img.eps'
#p'out.dat' u 1:2 w lp t'Real' 
#!convert -density 150 img.eps -quality 90 -background white -flatten img3.png
#!rm img.eps
#
#set o 'img.eps'
#p'out.dat' u 1:3 w lp t'Imag' 
#!convert -density 150 img.eps -quality 90 -background white -flatten img4.png
#!rm img.eps

!montage img1.png img2.png img3.png img4.png -geometry +2+2 out.jpg
!rm img*
