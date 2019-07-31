#!/bin/bash
# Written by Lex Kemper
#Update on 160912 by Ankit
                                                                                                                                                                             
## Controls
first_run=1
tstep=4					# Number of step you take to print a picture.
num_t0=$(wc ../../dens.dat |awk '{print $1-1}')	# Number of real t points.
############

if [ "$first_run" = "1" ]
then
    echo "First time run:"

    num_K=$(wc  ../../wigner.dat |awk -v tt=$num_t0 '{print $1/tt}')	# Number of k points. (without field K/4*(K/2+1), with field K/2*(K+1), here K=number of kpoints in td.inp)
    #num_t0=479	# Number of real t points.
    #num_K=1830	# Number of k points. (without field K/4*(K/2+1), with field K/2*(K+1), here K=number of kpoints in td.inp)

    awk 'BEGIN{n=1};{print n,$2,$3}{n=n+1}' ../../field.dat >field.dat	#To convert real time into index.
    rm -r output movie_wigner.mp4
    mkdir output
    cd output
    split -a 4 -l $num_K ../../../wigner.dat
    cd ..
else
    echo "Doing second time:"
    rm -r output/*.jpg kcut1.dat kcut2.dat kcut.dat
fi

icount=1
for i in $(seq 1 $tstep $num_t0)
do
	filename=$(ls -1 output/x* | awk "NR==${i}")
    ilabel=$(printf "%04d" $icount)
        
	echo $filename $ilabel pic=$i
	
	# Prepare the file for plotting
	#awk '{print $3,$4,$5,$6,$7,$8}' $filename| sort -n -k 1 -k 2 -u  > temp.dat	# If you want to print the density.
	paste $filename output/xaaaa | awk '{print $3,$4,$5-$13,$6-$14,$7-$15,$8-$16}'  |sort -n -k 1 -k 2 -u  > temp.dat	# If you want to plot the change in density.
	
    # Full zone by symmetry.
	#awk '{print $3,$4,$5,$6,$7,$8};{print $4,$3,$5,$6,$7,$8}' $filename| sort -n -k 1 -k 2 -u  > temp.dat	# If you want to print the density.
	#paste $filename output/xaaaa | awk '{print $3,$4,$5-$13,$6-$14,$7-$15,$8-$16};{print $4,$3,$5-$13,$6-$14,$7-15,$8-$16}'  |sort -n -k 1 -k 2 -u  > temp.dat	# If you want to plot the change in density.
	awk -f pm3d.awk temp.dat >toplot.dat
    
    ## Extract cuts along constant k
    awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-1.57)<= 0.04 && abs($3-$4)<= 0.001 ){print $0}}' $filename >kcut1.dat
    awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3+1.57)<= 0.04 && abs($3-$4)<= 0.001 ){print $0}}' $filename >kcut2.dat
    paste <(cat kcut1.dat) <(cat kcut2.dat) >>kcut.dat  #One file for all k points and all time points.
 
	# Gnuplot script
	cat << EOF > plotpng.gp

    set terminal jpeg enhanced size 2500,1600 font 'DejaVuBold,24'
	set output 'output/plot_${ilabel}.jpg'
	
	set size 1.0,1.0
	set multiplot layout 1,1 title "t=${ilabel}"

	set size 1.0,0.25
	set origin 0.0,0.0
	set title 'A-field'
	set arrow 1 from ${i},-0.3 to ${i},0.3 nohead lt -1
	plot 'field.dat' u 1:2 w l t ''

	unset arrow 1
	set xr[-pi:pi]
	set yr[-pi:pi]
	#set palette defined (0 0 0 0, 1 0 0 1, 3 0 1 0, 4 1 0 0, 6 1 1 1)
	set palette defined ( 0 "violet" , 1 "blue", 2 "cyan", 3 "green", 4 "yellow", 5 "orange", 6 "red" )
	set cbr[-0.005:0.005] # For diff
	
	set size square
	set pm3d map
	set size 0.48,.48
	set origin 0.0,0.2

	#set cbr[0.000622365:0.999378]
	set title 'Imag G_<'
	sp 'toplot.dat' u 1:2:3 t ''
	
	#set cbr[-0.0001:0.0001]
	set size 0.48,.48
	set origin 0.5,0.2
	set title 'Real G_<'
	sp 'toplot.dat' u 1:2:4 t ''
	
	#set cbr[-0.341961:0.00363445]
	set size 0.48,0.48
	set origin 0.0,0.58
	set title 'Imag F_<'
	sp 'toplot.dat' u 1:2:5 t ''
	
	#set cbr[-0.102364:0.102364]
	set size 0.48,.48
	set origin 0.5,0.58
	set title 'Real F_<'
	sp 'toplot.dat' u 1:2:6 t ''

	unset multiplot
EOF
gnuplot plotpng.gp
(( icount = icount + 1 ))
done
rm temp.dat toplot.dat plotpng.gp

~/local_libs/ffmpeg_static/ffmpeg -r 10 -i output/plot_%04d.jpg -pix_fmt yuv420p movie_wigner.mp4
