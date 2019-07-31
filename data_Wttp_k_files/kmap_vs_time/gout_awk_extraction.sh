# Density plot data, 1d plot data.
# This script extract data from data/Wttp_k file for kx,ky for fixed t and t'.
rm -r *.mp4 *.png *.dat output/
mkdir output

awk '{print $1}' ../../../data/Wk_ttp_k000 |uniq >tlist.dat
tmax=$(tail -n 1 tlist.dat|awk '{print $1}')
awk 'BEGIN{n=1};{print n,$2,$3}{n=n+1}' ../../../field.dat >field.dat	#To convert real time into index.

icount=1
for it in $(cat tlist.dat)
do
	echo $it $tmax
	
	for filename in $(ls ../../../data/Wk_ttp_k*)
	do
		cp $filename w.dat 

		sed 's/^ *//' w.dat| awk 'NF' >d.dat 	# to remove starting white spaces
		rm w.dat 

		# along t=t'
		awk -v t=$it -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 - $2 )<= 0.001 && abs( $1 - t )<= 0.001){print $0;exit 1 }}' d.dat >>d_out.dat
		
		# along t=-t'
		awk -v t=$it -v tt=$tmax -v OFS='\t' 'function abs(xx){return (xx<0?-xx:xx);}; {if(abs( $1 - t )<= 0.001 &&  abs( $2 + $1 - tt )<= 0.001 ){print $0;exit 1}}' d.dat >>ad_out.dat

		rm d.dat
	done
        ilabel=$(printf "%04d" $icount)
	# Symmetry operations
	cp d_out.dat temp.dat
	awk '{print $1,$2,$4,$3,$5,$6,$7,$8,$9,$10,$11,$12;}' temp.dat >>d_out.dat
	cp ad_out.dat temp.dat
	awk '{print $1,$2,$4,$3,$5,$6,$7,$8,$9,$10,$11,$12;}' temp.dat >>ad_out.dat
	
	sort -n -k 3 -k 4 -u d_out.dat >temp.dat 
	awk -f pm3d.awk temp.dat >output/d_time_"$it".dat
	cp output/d_time_"$it".dat data.dat
	gnuplot -e "name='output/d_plotG_${ilabel}.png'" -e "tname='t=${ilabel}'" -e "ilabel='${it}'" gnuG.gnu
	gnuplot -e "name='output/d_plotF_${ilabel}.png'" -e "tname='t=${ilabel}'" -e "ilabel='${it}'" gnuF.gnu
	
	sort -n -k 3 -k 4 -u ad_out.dat > temp.dat
	awk -f pm3d.awk temp.dat >output/ad_time_"$it".dat
	cp output/ad_time_"$it".dat data.dat
	gnuplot -e "name='output/ad_plotG_${ilabel}.png'" -e "tname='t=${ilabel}'" -e "ilabel='${it}'" gnuG.gnu
	gnuplot -e "name='output/ad_plotF_${ilabel}.png'" -e "tname='t=${ilabel}'" -e "ilabel='${it}'" gnuF.gnu
	
	rm data.dat d_out.dat ad_out.dat temp.dat
	(( icount = icount + 1 ))
done
rm field.dat

./ffmpeg_static/ffmpeg -r 5 -i output/d_plotG_%04d.png -pix_fmt yuv420p movie_dG_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/d_plotF_%04d.png -pix_fmt yuv420p movie_dF_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/ad_plotG_%04d.png -pix_fmt yuv420p movie_adG_Dirac.mp4
./ffmpeg_static/ffmpeg -r 5 -i output/ad_plotF_%04d.png -pix_fmt yuv420p movie_adF_Dirac.mp4
