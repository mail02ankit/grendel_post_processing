rm -r cuts
mkdir cuts

dk=0.015
dw=0.005

# Extract arpes data for w and k range so that we scan smaller file.
awk 'function abs(xx){return (xx<0?-xx:xx);}; {if( (abs($2-1.57)<= 0.5 || abs($2+1.57)<= 0.5) && abs($3-0.0) <=1.0 ){print $0}}' ../../ARPES.dat > resARPES.dat

ifile='resARPES.dat'

for w in -0.1 -0.075 -0.05 -0.025 0.0 0.025 0.05 0.075 0.1
do
    k=-1.57
    awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' $ifile > k1.dat
    paste <(cat k1.dat) > cuts/d_higgs_w$w-k1k2.dat
done

for k in -1.44 -1.46 -1.48 -1.50 -1.52 -1.54 -1.56 -1.58 -1.62
do
    w=-0.05
    awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' $ifile > k1.dat
    paste <(cat k1.dat) > cuts/d_higgs_k$k-k1k2.dat
done


rm k1.dat

