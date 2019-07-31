counter=1
for i in $(ls -rt w_*)
do
    echo $i 00$counter
    cp $i chi_cond00$counter.dat
    (( counter = counter +1 ))
done
