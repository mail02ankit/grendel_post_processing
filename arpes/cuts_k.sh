k=1.53
w=0.0
dk=0.01
dw=0.001

infile='../../ARPES.dat'
#awk -v k=$k -v w=$w -v dk=$dk -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=w/2){print $0}}' $infile
awk -v k=$k -v w=$w -v dk=$dk -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=w/2){print $0}}' $infile > k1.dat


#
k=-1.53
awk -v k=$k -v w=$w -v dk=$dk -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($2-k)<= dk/2 && abs($3-w)<=w/2){print $0}}' $infile > k2.dat


