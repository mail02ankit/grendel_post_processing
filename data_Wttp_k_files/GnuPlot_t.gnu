# General Settings
set xtics font "Helvetica-Bold,14" 
set ytics font "Helvetica-Bold,14"
set border linewidth 2 
set terminal postscript eps enhanced color	
#--------Again--------
set key
#set palette defined ( 0 "black","22", "33")

set ylabel 'Y' font "Helvetica-Bold,14"
set xlabel 'k' font "Helvetica-Bold,12"
##set title 'Fermi Surface, Mu=0.0'
##set title 'G(1,1), Mu=0.0'
#set border linewidth 2 
set o 'img.eps'
#set nokey
set multiplot layout 2,2 title "at fixed t, t' and kx=ky"
p'out.dat' u 3:5 w lp t'WG_< real' 
p'out.dat' u 3:6 w lp t'WG_< imag' 
p'out.dat' u 3:7 w lp t'WG_> real' 
p'out.dat' u 3:8 w lp t'WG_> imag' 

unset multiplot

set o 'img1.eps'
set multiplot layout 2,2 title "at fixed t, t' and kx=ky"
p'out.dat' u 3:9 w lp t'WF_< real' 
p'out.dat' u 3:10 w lp t'WF_< imag' 
p'out.dat' u 3:11 w lp t'WF_> real' 
p'out.dat' u 3:12 w lp t'WF_> imag' 
