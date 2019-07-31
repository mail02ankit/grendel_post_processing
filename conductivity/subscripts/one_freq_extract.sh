w=0.14
dw=0.04

awk -v w=$w -v dw=$dw 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($1-w)<= dw/2){print $0}}' out/cond* > out.dat
wc out.dat
#Make X axis delay time.
paste out.dat ../../probe_center.dat |awk '{print $5,$2,$3,$1}' >final.dat
rm out.dat

