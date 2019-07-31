# General Settings
#set xtics font "Helvetica-Bold,14" 
#set ytics font "Helvetica-Bold,14"
set xtics 
set ytics 
set grid

set terminal postscript eps enhanced color	

set ylabel 'Y' font "Helvetica-Bold,14"

#Time domain
set xlabel 't' font "Helvetica-Bold,12"
set o 'img.eps'
p'in.dat' u 1:2 w lp t'Real' 
!convert -density 150 img.eps -quality 90 -background white -flatten img1.png
!rm img.eps

set o 'img.eps'
p'in.dat' u 1:3 w lp t'Imag' 
!convert -density 150 img.eps -quality 90 -background white -flatten img2.png
!rm img.eps

#FT
set xlabel 'w' font "Helvetica-Bold,12"
set o 'img.eps'
p'out.dat' u 1:2 w lp t'Real' 
!convert -density 150 img.eps -quality 90 -background white -flatten img3.png
!rm img.eps

set o 'img.eps'
p'out.dat' u 1:3 w lp t'Imag' 
!convert -density 150 img.eps -quality 90 -background white -flatten img4.png
!rm img.eps
