# One plot for all quantities.
set xtics #font "DejaVuBold,16" 
set ytics #font "DejaVuBold,16"
set border linewidth 2 
set terminal jpeg enhanced size 2500,2000 font 'DejaVuBold,24'
set key
#set palette defined ( 0 "black","22", "33")

# Tics color
set y2tics textcolor rgb 'red'
set ytics textcolor rgb 'blue'
# Tics format
#set format x "%10.3f"
set format y "%10.3f"
set format y2 "%10.3f"
set ytics nomirror

set o 'out.jpg'
set multiplot layout 2,1 title 'Out'

set ylabel '' #font "DejaVuBold,16"
set xlabel 'w' #font "DejaVuBold,16"
##set title 'Fermi Surface, Mu=0.0'
p[0.001:1.5][]'../../conductivity/out/cond000.dat' u 1:2 t'JE' w lp lc rgb 'blue' ax x1y1,'cond.dat' u 1:2 t'Chi' ax x1y2 w lp lc rgb 'red'
unset y2tics
p[0.001:2][0:10]'condJE.dat' u 1:2 t'JE-normalized' w lp lc rgb 'blue','cond.dat' u 1:2 t'Chi-normalized' w lp lc rgb 'red'
#pause -1

