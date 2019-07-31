rm t_cond* fft_analysis/w_cond*

#tmax is the simulation time.
#tmax=$(tail -1 ../../dens000.dat |awk '{print $1}')
tave_list="100 200 250"   # It can be "tlength < tave < tmax-tlength"
tlength=300

in='../../chi_time.dat'
infile='w.dat'

cp $in $infile

sed 's/^ *//' $infile| awk 'NF' >d.dat 	# to remove starting white spaces
mv d.dat $infile

for tave in $tave_list
do
    echo "Doing tave= " $tave
    # Extract data for constant t_ave and fixed time length along t_rel.
    awk -v tt=$tave -v tlength=$tlength -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if( (abs($1+$2-2*tt)<= 0.001) && ( abs($2-$1) <tlength) ) {print $0}}' $infile >ad_out.dat				# it prints data along t=-t' axis
    cp ad_out.dat t_cond_tave-$tave-lt-$tlength.dat

    #Plot script
    #gnuplot GnuPlot.gnu #convert -density 150 img1.eps -quality 90 -background white -flatten ad_W.png

    # FFT
    cd fft_analysis
    bash gout_fft.sh
    cp cond.dat w_cond_tave-$tave-lt-$tlength.dat
    cd ..
done

