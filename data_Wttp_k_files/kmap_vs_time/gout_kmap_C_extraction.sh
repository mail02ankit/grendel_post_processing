# This script extract data from data/Wttp_k file for kx,ky for fixed t and t'.
rm -r *.mp4 *.png *.dat output/
mkdir output

wc ../../../dens.dat |awk '{print $1-1}' >tmax	# Number of real t points to use in C program.
g++ -fopenmp cDataExtract.cpp
./a.out

sort -n -k 1 -k 3 -k 4 d_data.dat >data.dat
mv data.dat d_data.dat
sort -n -k 1 -k 3 -k 4 ad_data.dat >data.dat
mv data.dat ad_data.dat

# preparation for plotting.
tstep=2						# Number of step you take to print a picture.
awk 'BEGIN{n=1};{print n,$2,$3}{n=n+1}' ../../../field.dat >field.dat	#To convert real time into index.

num_t0=$(wc ../../../dens.dat |awk '{print $1}')	# Number of real t points.
num_K=$(wc  d_data.dat |awk -v tt=$num_t0 '{print $1/tt}')	# Number of k points. (without field K/4*(K/2+1), with field K/2*(K+1), here K=number of kpoints in td.inp)
#num_t0=479	# Number of real t points.
#num_K=1830	# Number of k points. (without field K/4*(K/2+1), with field K/2*(K+1), here K=number of kpoints in td.inp)

cd output
split -a 4 -l $num_K ../d_data.dat d-
split -a 4 -l $num_K ../ad_data.dat ad-
cd ..

#along t=t'
icount=1
for i in $(seq 1 $tstep $num_t0)
do
	filename=$(ls -1 output/d-* | awk "NR==${i}")
        ilabel=$(printf "%04d" $icount)
        
	echo $filename $ilabel pic=$i
	
	# Prepare the file for plotting
	awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}; {print $1,$2,$4,$3,$5,$6,$7,$8,$9,$10,$11,$12};' $filename| sort -n -k 3 -k 4 -u   > temp.dat	# If you want to print the density.
	
	awk -f pm3d.awk temp.dat >data.dat

	# Gnuplot script
	cat << EOF > plotpng.gp
	set terminal png
	set output 'output/d_plotF_${ilabel}.png'
	
	set size 1.0,1.0
	set multiplot layout 3,2 title "t=${i}"

	set size 1.0,0.25
	set origin 0.0,0.0
	set title 'A-field'
	set arrow 1 from ${i},-0.3 to ${i},0.3 nohead lt -1
	plot 'field.dat' u 1:2 w l t ''
	unset arrow 1
	
	load 'gnuF.gnu'
	clear
	reset
	set output 'output/d_plotG_${ilabel}.png'
	
	set size 1.0,1.0
	set multiplot layout 3,2 title "t=${i}"

	set size 1.0,0.25
	set origin 0.0,0.0
	set title 'A-field'
	set arrow 1 from ${i},-0.3 to ${i},0.3 nohead lt -1
	plot 'field.dat' u 1:2 w l t ''
	unset arrow 1
	
	load 'gnuG.gnu'
EOF
	gnuplot plotpng.gp

	rm data.dat temp.dat
	(( icount = icount + 1 ))
done
# along t=-t'
icount=1
num_t0=$(wc ../../../dens.dat |awk '{print $1/2}')	# We have haft t point for other diagonal..
for i in $(seq 1 $tstep $num_t0)
do
	filename=$(ls -1 output/ad-* | awk "NR==${i}")
        ilabel=$(printf "%04d" $icount)
        
	echo $filename $ilabel pic=$i
	
	# Prepare the file for plotting
	awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}; {print $1,$2,$4,$3,$5,$6,$7,$8,$9,$10,$11,$12};' $filename| sort -n -k 3 -k 4 -u   > temp.dat	# If you want to print the density.
	
	awk -f pm3d.awk temp.dat >data.dat
	cat << EOF > plotpng.gp
	set terminal png
	set output 'output/ad_plotF_${ilabel}.png'
	
	set size 1.0,1.0
	set multiplot layout 3,2 title "t=${i}"

	set size 1.0,0.25
	set origin 0.0,0.0
	set title 'A-field'
	set arrow 1 from ${i},-0.3 to ${i},0.3 nohead lt -1
	plot 'field.dat' u 1:2 w l t ''
	unset arrow 1
	
	load 'gnuF.gnu'
	clear
	reset
	set output 'output/ad_plotG_${ilabel}.png'
	
	set size 1.0,1.0
	set multiplot layout 3,2 title "t=${i}"

	set size 1.0,0.25
	set origin 0.0,0.0
	set title 'A-field'
	set arrow 1 from ${i},-0.3 to ${i},0.3 nohead lt -1
	plot 'field.dat' u 1:2 w l t ''
	unset arrow 1
	
	load 'gnuG.gnu'
EOF
	gnuplot plotpng.gp
	
	rm data.dat temp.dat
	(( icount = icount + 1 ))
done
rm field.dat a.out plotpng.gp

./ffmpeg_static/ffmpeg -r 5 -i output/d_plotG_%04d.png -pix_fmt yuv420p movie_dG_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/d_plotF_%04d.png -pix_fmt yuv420p movie_dF_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/ad_plotG_%04d.png -pix_fmt yuv420p movie_adG_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/ad_plotF_%04d.png -pix_fmt yuv420p movie_adF_Dirac.mp4
