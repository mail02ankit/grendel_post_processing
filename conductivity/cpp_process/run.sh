list_probe="001 002" 

##
rm -r out/;mkdir out/
sed 1d ../../../equalt000.dat > J0.dat  # sed to remove 1 line which got # in it.
cp ../../../field000.dat E0.dat
g++ -fopenmp c_extract.cpp
##

for iprobe in $list_probe
do
    echo "Doing: " $iprobe
    sed 1d ../../../equalt"$iprobe".dat > J1.dat
    cp ../../../field"$iprobe".dat E1.dat

    # Extract data
    ./a.out
    mv J.dat out/J"$iprobe".dat
    mv E.dat out/E"$iprobe".dat
done

rm E0.dat E1.dat J0.dat J1.dat
