# General Settings
set pm3d map
set xr[-pi:pi]
set yr[-pi:pi]
#set palette defined (0 0 0 0, 1 0 0 1, 3 0 1 0, 4 1 0 0, 6 1 1 1)
set palette defined ( 0 "violet" , 1 "blue", 2 "cyan", 3 "green", 4 "yellow", 5 "orange", 6 "red" )
#set cbr[-0.5:0.5]
set size square
#set isosample 250, 250

set size 0.48,0.48
set origin 0.0,0.2
set title 'Real WG_<'
sp 'data.dat' u 3:4:5 t ''

set size 0.48,0.48
set origin 0.5,0.2
set title 'Imag WG_<'
sp 'data.dat' u 3:4:6 t ''

set size 0.48,0.48
set origin 0.0,0.58
set title 'Real WG_>'
sp 'data.dat' u 3:4:7 t ''

set size 0.48,.48
set origin 0.5,0.58
set title 'Imag WG_>'
sp 'data.dat' u 3:4:8 t ''

set key outside top
unset multiplot
