# General Settings
set xtics 
set ytics 
set grid
set terminal jpeg enhanced size 1368,768 font 'DejaVuSansCondensed-Bold,14'
set terminal postscript eps enhanced color	

set ylabel 'Y'
#Time domain
set xlabel 't'
set o 'img1.jpg'
p'in.dat' u 1:2 w lp t'Real' 
#!convert -density 150 img.eps -quality 90 -background white -flatten img1.png
#!rm img.eps

set o 'img2.jpg'
p'in.dat' u 1:3 w lp t'Imag' 

#FT
set xlabel 'w' font "Helvetica-Bold,12"
set o 'img3.jpg'
p'out.dat' u 1:($2/$1) w lp t'FT-Real' 

set o 'img4.jpg'
p'out.dat' u 1:($3/$1) w lp t'FT-Imag' 
