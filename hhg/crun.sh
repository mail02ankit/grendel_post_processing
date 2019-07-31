g++ -fopenmp ../cfft.cpp

# FFT of current
cp ../../equalt.dat ifile.dat
awk '{print $1,$2,0.0}' ifile.dat >data0.dat
sed 1d data0.dat >data.dat; rm data0.dat   # Delete the first line.

./a.out

cp out.dat  fft_j.dat

# FFT of fiest
cp ../../field.dat ifile.dat
awk '{print $1,$2,0.0}' ifile.dat >data.dat

./a.out

cp out.dat  fft_e.dat

#
rm ifile.dat in.dat out.dat




