rm t_W* fft_analysis/w_W*

#tmax is the simulation time.
#tmax=$(tail -1 ../../dens000.dat |awk '{print $1}')
tave_list="55 59 63 67 71 75 79 90 95 100 105 110 115 120"   # It can be "tlength < tave < tmax-tlength"
tlength=140

in='../../W000.dat'
infile='w.dat'

cp $in $infile

sed 's/^ *//' $infile| awk 'NF' >d.dat 	# to remove starting white spaces
mv d.dat $infile

for tave in $tave_list
do
    echo "Doing tave= " $tave
    # Extract data for constant t_ave and fixed time length along t_rel.
    awk -v tt=$tave -v tlength=$tlength -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if( (abs($1+$2-2*tt)<= 0.001) && ( abs($2-$1) <tlength) ) {print $0}}' $infile >ad_out.dat				# it prints data along t=-t' axis
    cp ad_out.dat t_W_tave-$tave-lt-$tlength.dat

    #Plot script
    #gnuplot GnuPlot.gnu #convert -density 150 img1.eps -quality 90 -background white -flatten ad_W.png

    # FFT
    cd fft_analysis
    bash gout_fft.sh
    cp out.dat w_W_tave-$tave-lt-$tlength.dat
    cd ..
done

