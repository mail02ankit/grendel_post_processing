# General Settings
set xtics font "Helvetica-Bold,14" 
set ytics font "Helvetica-Bold,14"
set border linewidth 2 
set terminal postscript eps enhanced color	

set key
#set palette defined ( 0 "black","22", "33")

set ylabel 'Y' font "Helvetica-Bold,14"
set xlabel 't' font "Helvetica-Bold,12"
##set title 'Fermi Surface, Mu=0.0'
##set title 'G(1,1), Mu=0.0'
#set border linewidth 2 
set o 'img.eps'
#set nokey
set multiplot layout 2,2 title 't=t'
p'out.dat' u 1:3 w lp t'G_{loc} real','../../field.dat' u 1:2 w l ax x2y2 t'field'
p'out.dat' u 1:2 w lp t'G_{loc} imag','../../field.dat' u 1:2 w l ax x2y2 t'field'
p'out.dat' u 1:5 w lp t'F_{loc} real','../../field.dat' u 1:2 w l ax x2y2 t'field'
p'out.dat' u 1:4 w lp t'F_{loc} imag','../../field.dat' u 1:2 w l ax x2y2 t'field'

#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:6 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:7 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:8 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:9 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:10 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:11 w p palette 
