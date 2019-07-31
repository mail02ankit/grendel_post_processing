# General Settings
#set xtics font "Helvetica-Bold,14" 
#set ytics font "Helvetica-Bold,14"
#set border linewidth 2 
set terminal postscript eps enhanced color	

set key
#set ylabel 'kx' font "Helvetica-Bold,14"
#set xlabel 'ky' font "Helvetica-Bold,12"
set xlabel 't' 
set o 'img1.eps'
p'd_out.dat' u 1:5 w lp t'WG_< real' 
set o 'img2.eps'
p'd_out.dat' u 1:6 w lp t'WG_< imag' 
set o 'img3.eps'
p'd_out.dat' u 1:7 w lp t'WG_> real' 
set o 'img4.eps'
p'd_out.dat' u 1:8 w lp t'WG_> imag' 
set o 'img5.eps'
p'd_out.dat' u 1:9 w lp t'WF_< real' 
set o 'img6.eps'
p'd_out.dat' u 1:10 w lp t'WF_< imag' 
set o 'img7.eps'
p'd_out.dat' u 1:11 w lp t'WF_> real' 
set o 'img8.eps'
p'd_out.dat' u 1:12 w lp t'WF_> imag' 

set o 'img11.eps'
p'ad_out.dat' u 1:5 w lp t'WG_< real' 
set o 'img12.eps'
p'ad_out.dat' u 1:6 w lp t'WG_< imag' 
set o 'img13.eps'
p'ad_out.dat' u 1:7 w lp t'WG_> real' 
set o 'img14.eps'
p'ad_out.dat' u 1:8 w lp t'WG_> imag' 
set o 'img15.eps'
p'ad_out.dat' u 1:9 w lp t'WF_< real' 
set o 'img16.eps'
p'ad_out.dat' u 1:10 w lp t'WF_< imag' 
set o 'img17.eps'
p'ad_out.dat' u 1:11 w lp t'WF_> real' 
set o 'img18.eps'
p'ad_out.dat' u 1:12 w lp t'WF_> imag' 
