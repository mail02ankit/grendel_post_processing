kx=3.11
ky=0.01
dk=0.0785

infile='../../wigner.dat'
#awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > out.dat

kx=1.57
ky=1.57
awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > k1.dat

kx=3.14
ky=0.01
awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > k2.dat

kx=1.57
ky=-1.57
awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > k3.dat

kx=0.01
ky=-3.14
awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > k4.dat

kx=-1.57
ky=-1.57
awk -v kx=$kx -v ky=$ky -v dk=$dk 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs($3-kx)<= dk/2 && abs($4-ky)<=dk/2){print $0}}' $infile > k5.dat


