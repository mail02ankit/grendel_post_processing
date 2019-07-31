rm W_tave*
counter=1
for i in $(ls -rt w_*)
do
    echo $i 00$counter
    cp $i W_tave00$counter.dat
    (( counter = counter +1 ))
done
