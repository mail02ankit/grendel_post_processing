# General Settings
set terminal postscript eps enhanced color	

set key outside
#set palette defined ( 0 "black","22", "33")

set ylabel 'kx=ky' font "Helvetica-Bold,12"
set xlabel 't' font "Helvetica-Bold,12"
#set border linewidth 2
set o 'img.eps'
set pm3d map
set palette defined ( 0 "violet" , 1 "blue", 2 "cyan", 3 "green", 4 "yellow", 5 "orange", 6 "red" )
#set cbr[-0.005:0.005]

set size 1.0,1.0
set multiplot layout 2,2 title 'Local G,F'

set yr[-pi:pi]
set size 0.53,0.53
set origin 0.0,0.0
set title 'G< imag' 
sp'd_out.dat' u 1:3:5 t''

set size 0.5,0.5
set origin 0.5,0.0
set title 'F< imag' 
sp'd_out.dat' u 1:3:6 t''

set size 0.5,0.5
set origin 0.0,0.5
set title 'F< imag' 
sp'd_out.dat' u 1:3:7 t''
unset multiplot

!convert -density 150 img.eps -quality 90 -background white -flatten ad_W.png
!rm img.eps

