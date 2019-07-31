dw=0.041
rm -r decay_rates rates.dat
mkdir decay_rates

#for w in 0.12 0.16 0.20 0.24 0.28 0.32 0.36
for w in 0.10 0.14 0.18 0.22 0.26 0.30
do
    echo $w
    outfile=final-$w-data.dat
    awk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($1-w)<= dw/2){print $0}}' out/cond* > out.dat
    wc out.dat
    #Make delay times as x-axis.
    paste out.dat ../../probe_center.dat |awk '{print $5,$2,$3,$1}' >data.dat
    cp data.dat decay_rates/$outfile

    # Gnuplot fitting.
    gnuplot subscripts/fit_gnu.gnu
    # This is just some weird way to grep parameters from the fit file.
    tail -n 9 fit.log |head -n 1|awk -v w=$w '{print w,$3,$6}' >> rates.dat
    rm data.dat out.dat fit.log
done

