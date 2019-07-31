# General Settings
set xtics font "Helvetica-Bold,14" 
set ytics font "Helvetica-Bold,14"
set border linewidth 2 
set terminal postscript eps enhanced color	

#Band structure color plots
#set o 'img1.eps'
#set title 'Band Structure e1'
#set xlabel 'Kx' font "Helvetica-Bold,12"
#set ylabel 'Ky' font "Helvetica-Bold,14"
#p[-pi:pi][-pi:pi]'dataBandStru.dat' u 1:2:3 w p palette
#set title 'Band Structure e2'
#set o 'img2.eps'
#p[-pi:pi][-pi:pi]'dataBandStru.dat' u 1:2:4 w p palette

#------Fermi Surface plots--------
#set key
#set title 'Fermi Surface'
#set o 'img.eps'
#set ylabel 'Ky' font "Helvetica-Bold,14"
#set xlabel 'Kx' font "Helvetica-Bold,12"
#set title 'Fermi Surface'
##p[-pi:pi][-pi:pi]'dataBandStru.dat' u 1:2:((($3 <-2.0 +0.1 && $3 >-2.0-0.1) || ($4<-2.0+0.1 && $4 >-2.0-0.1))) w p palette 
#p[-pi:pi][-pi:pi]'dataBandStru.dat' u 1:2:($5+$6) w p palette 
##p[-pi:pi][-9:9]'GreenFunc.dat' u 2:1:4 w p palette 

# Density of states plots
#set o 'img.eps'
#set title 'DoS- two bands together,Ddelta 0.005, dk =0.01,dw=0.01'
#set title 'DoS- e1 band,Ddelta 0.005, dk =0.01,dw=0.01'
#set xlabel 'w' font "Helvetica-Bold,12"
#set ylabel 'Dos' font "Helvetica-Bold,14"
#p'dataDensityOfStates.dat' u 1:2 w lp

# Suseptibilty plots
#set o 'img.eps'
#set title 'LS,Ddelta 0.005, dk =0.01,w=0.0'
#set xlabel 'Qx' font "Helvetica-Bold,12"
#set ylabel 'Qy' font "Helvetica-Bold,14"
#p[-pi:pi][-pi:pi]'dataLindhard.dat' u 1:2:3 w p pt 7 palette 

# Number of electrons  
#set o 'img.eps'
#set title 'Number of electron,Ddelta 0.005, dk =0.01,dw=0.01'
#set xlabel 'w' font "Helvetica-Bold,12"
#set ylabel 'N' font "Helvetica-Bold,14"
#p'dataNumberOfelectron.dat' u 1:2 w lp,0.8 w lp

#Symmetry lines plots
#set nokey
#set ylabel 'Energy' font "Helvetica-Bold,14"
#set xlabel '' font "Helvetica-Bold,12"
#set title 'Band Structure: EigenVector(1), Gap1, Q1'
#set xtics ('{/Symbol G}' 1, 'X' 315,'{/Symbol M}' 630, '{/Symbol G}' 944,);
#y(x) = 0
#set arrow from 315, graph 0 to 315, graph 1 nohead	# To draw a vertical line
#set arrow from 630, graph 0 to 630, graph 1 nohead
##p'< cat eh1.dat eh2.dat eh3.dat' u 0:3 w l ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:4 w l ,y(x) ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:5 w l, '<cat eh1.dat eh2.dat eh3.dat ' u 0:6 w l ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:7 w l,'<cat eh1.dat eh2.dat eh3.dat ' u 0:8 w l,'<cat eh1.dat eh2.dat eh3.dat ' u 0:9 w l ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:9 w l
#p'<cat eh1.dat eh2.dat eh3.dat ' u 0:6 w l, '<cat eh1.dat eh2.dat eh3.dat ' u 0:7 w l ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:8 w l,'<cat eh1.dat eh2.dat eh3.dat ' u 0:9 w l,'<cat eh1.dat eh2.dat eh3.dat ' u 0:10 w l ,'<cat eh1.dat eh2.dat eh3.dat ' u 0:11 w l

#---------Multiple eigen values Plot--------
#set key
#set pm3d map 
#set palette rgb 21,22,23;
#set isosample 250,250
#
#set ylabel 'Ky' font "Helvetica-Bold,14"
#set xlabel 'Kx' font "Helvetica-Bold,12"
#set border linewidth 2 
#
#set terminal postscript eps enhanced color	
#
#set o 'img.eps'
#set multiplot layout 3,3 title 'Eigen values'
#set title'e1(k)'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:3 
#set title'e2(k)'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:4 
#set title'eig1'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:5 
#set title'eig2'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:6 
#set title'eig3'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:7 
#set title'eig4'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:8 
#set title'eig5'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:9 
#set title'eig6'
#sp[-pi:pi][-pi:pi][]'data.dat' u 1:2:10 

#--------Again--------
set key
#set palette defined ( 0 "black","22", "33")

set ylabel 'Y' font "Helvetica-Bold,14"
set xlabel 't' font "Helvetica-Bold,12"
##set title 'Fermi Surface, Mu=0.0'
##set title 'G(1,1), Mu=0.0'
#set border linewidth 2
unset multiplot
set o 'img1.eps'
set multiplot layout 2,2 title 't=-t'
p'ad_out.dat' u 1:3 w lp t'W> (G) real' 
p'ad_out.dat' u 1:4 w lp t'W> (G) imag' 
p'ad_out.dat' u 1:5 w lp t'W< (G) real' 
p'ad_out.dat' u 1:6 w lp t'W< (G) imag' 

unset multiplot
set o 'img2.eps'
set multiplot layout 2,2 title 't=-t'
p'ad_out.dat' u 1:7 w lp t'WR (G) real' 
p'ad_out.dat' u 1:8 w lp t'WR (G) imag' 
#p'ad_out.dat' u 1:9 w lp t'WR (F) real' 
#p'ad_out.dat' u 1:10 w lp t'WR (F) imag' 

unset multiplot
set o 'img3.eps'
set multiplot layout 2,2 title 't=t'
p'd_out.dat' u 1:3 w lp t'W> (G) real' 
p'd_out.dat' u 1:4 w lp t'W> (G) imag' 
p'd_out.dat' u 1:5 w lp t'W< (G) real' 
p'd_out.dat' u 1:6 w lp t'W< (G) imag' 

unset multiplot
set o 'img4.eps'
set multiplot layout 2,2 title 't=t'
p'd_out.dat' u 1:7 w lp t'WR (G) real' 
p'd_out.dat' u 1:8 w lp t'WR (G) imag' 
#p'd_out.dat' u 1:9 w lp t'WR (F) real' 
#p'd_out.dat' u 1:10 w lp t'WR (F) imag' 

#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:6 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:7 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:8 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:9 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:10 w p palette 
#p[-pi:pi][-pi:pi]'EigenValue.dat' u 2:3:11 w p palette 
