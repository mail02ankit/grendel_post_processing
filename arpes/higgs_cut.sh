dk=0.015
dw=0.005

w=-0.05
k=1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k2.dat
k=-1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k1.dat
paste <(cat k1.dat) <(cat k2.dat) >d_higgs_w$w-k1k2.dat

##############
w=0.0
k=1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k2.dat
k=-1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k1.dat
paste <(cat k1.dat) <(cat k2.dat) >d_higgs_w$w-k1k2.dat

##############
w=+0.05
k=1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k2.dat
k=-1.57
awk -v OFS='\t' -v k=$k -v dk=$dk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=dw/2){print $0}}' ../../ARPES.dat > k1.dat
paste <(cat k1.dat) <(cat k2.dat) >d_higgs_w$w-k1k2.dat

rm k1.dat k2.dat
