#!/bin/bash

## Controls
first_run=1
do_edc=1
fileinput='../../ARPES.dat'
center=120
#splitlength=205825     # ARPES ( nk*(nw+1) + 1).
splitlength=`awk 'NR==1{print $1-1}' ../../*meta`
############
module load python

if [ "$first_run" = "1" ]
then
    rm -rf output >& /dev/null
    mkdir output >& /dev/null
    echo "First time run:"

    #awk 'BEGIN{n=1};{print n,$2,$3}{n=n+1}' ../../field.dat >field.dat #To convert real time into index.
    cp  ../../field.dat field.dat   #To convert real time into index.
    awk '{print $1}' $fileinput|sort -n -k 1 -u > t0list.dat 

    cd output
    echo 'Splitting file into chunks of size ', $splitlength $fileinput
    split -a 4 -l $splitlength ../$fileinput
    cd ..
else
    echo "Doing second time:"
fi

if [ "$do_edc" = "1" ]
then
    rm edck1.dat edck2.dat
fi
rm output/*.jpg kcut1.dat kcut2.dat kcut.dat

i=0
for t0 in `cat t0list.dat`
do
    (( i = i + 1 ))
    filename=`ls -1 output/x* | awk "NR==${i}"`
    echo $filename
    
    delay=$( awk -v a=$t0 -v b=$center "BEGIN{print a-b}")
    
    #ARPES
    cp $filename toplot.dat
    
    ## Eq-difference ARPES: you have to first run the spectral weight part and copy ouput/xaaaa file to eq-arpes.dat, Change color range as well.
    ### For old ARPES.dat format.
    #awk '{if($2==""){print ""}else{print $0}}' eq-arpes.dat >temp1.dat
    #awk '{if($2==""){print ""}else{print $0}}' $filename >  temp2.dat
    #paste temp1.dat temp2.dat | awk '{if($2==""){print "";}else{print $1,$2,$3,$10-$4,$11-$5,$6;}}' >toplot.dat
    ### For new ARPES.dat
    #paste $filename eq-arpes.dat | awk '{if($2==""){print "";}else{print $1,$2,$3,$10-$4,$11-$5,$6;}}' >toplot.dat

    ilabel=`printf "%04d" $i`
    ## Extract cuts along constant k
    awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-1.57)<= 0.008 ){print $0}}' $filename >kcut1.dat
    awk -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2+1.57)<= 0.008 ){print $0}}' $filename >kcut2.dat
    paste <(cat kcut1.dat) <(cat kcut2.dat) >>kcut.dat  #One file for all k points and all time points.

    if [ "$do_edc" = "1" ]
    then
        # EDC maxima extraction.
        cp kcut1.dat data.dat
        python local_minima.py
        cat edc_minima_out.dat >>edck1.dat
        mv test.jpg output/edck1_${ilabel}.jpg

        cp kcut2.dat data.dat
        python local_minima.py
        cat edc_minima_out.dat >>edck2.dat
        mv test.jpg output/edck2_${ilabel}.jpg
    fi
    
    cat << EOF > plotjpg.gp
    
    set terminal jpeg enhanced size 1280,720 font 'DejaVuBold,20'
    set output 'output/plot_${ilabel}.jpg'

    set size 1.0,1.0
    set multiplot layout 1,1 title ""

    # Bottom plot: field.
    set size 1.0,0.3
    set origin 0.0,0.0
    #set title 'A-field'
    set arrow 1 from ${t0},-0.1 to ${t0},0.2 nohead lt -1
    unset ytics
    plot 'field.dat' u 1:2 w l t ''
 
    ### K cut plot
    set title 'EDC'
    #set size square
    set size 0.5,0.70
    set origin 0.5,0.3
    set ytics
    set key left top
    set xr[-0.3:0.1]
    set yr[0.0:0.32]
    set grid y
    plot "kcut1.dat"  u 3:4 t'+kf' w l ,"kcut2.dat"  u 3:4 t'-kf' w l

    # ARPES plot
    unset arrow 1

    # ARPES
    set palette defined(0 "white",  2 "blue", 4 "salmon", 6 "yellow",8 "red", 10 "white")
    set cbr[0.0:0.25]   #Default range for APRES.dat

    # Diff ARPES
    #set palette defined(-1 "blue", 0 "white", 1 "red")
    #set cbr[-0.1:0.1]  #Default range for diff APRES.dat
    
    #set palette rgb 21,22,23
    #set palette rgbformulae 7,5,15
    #set palette defined(-0.009 "white", 0.0 "aquamarine", 0.05 "khaki", 0.1 "spring-green", 0.2 "green", 0.3 "yellow", 0.33 "white")   // does not work on edision
    #set palette defined(0 "white", 4.0 "blue", 8 "orange", 10 "yellow")
    
    set xr[-2.5:2.5]
    set yr[-0.3:0.05]
    #set zr[-0.007:0.23]
    set ytics
    set ytics ( -0.2 , -0.8, 0, 0.2, 0.8)
    
    set title 'A(k,w,t0 = ${delay} [1/eV])'
    set xlabel 'k'
    set ylabel 'w'
    set view map
    #unset colorbox

    unset key
    set grid y
    
    #set size square
    set pm3d map
    set size 0.5,0.85
    set origin 0.0,0.2

    #splot "< awk '{print \$2,\$3,\$4}' ${filename}" w pm3d
    splot "< awk '{print \$2,\$3,\$4}' toplot.dat" w pm3d

    unset multiplot
EOF

gnuplot plotjpg.gp

done

~/local_libs/ffmpeg_static/ffmpeg -r 8 -i output/plot_%04d.jpg -qscale 5 movie_arpes.mp4
#ffmpeg -r 8 -i output/plot_%04d.jpg -qscale 5 movie_arpes.mp4
#rm plotjpg.gp toplot.dat kcut1.dat kcut2.dat  >& /dev/null
rm plotjpg.gp toplot.dat  >& /dev/null

