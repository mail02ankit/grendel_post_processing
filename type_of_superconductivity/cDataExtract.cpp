/*
	This program read  from a given data file.
	161101- Fixed the summation error. Now sum matches with dens.dat. Also added the Mod of F< value.
*/

#include <iostream>
#include <iomanip>
#include <cmath>
#include <fstream>
#include <cstdlib>

#include <omp.h>
#include <complex>
#include <vector>

using namespace std;

typedef complex<double> cdouble;
typedef vector<cdouble> cd_vec;
typedef vector<double>  d_vec;

int main()
{
	fstream ofile1, ofile2;
	ofile1.open("summed_data.dat",ios::out);
	
	double tmax=0.0;

	//omp_set_num_threads(10);
	//#pragma omp parallel for
	{	
		double it=0.0, ik=0.0, kx=0.0, ky=0.0, realG=0.0, imagG=0.0, realF=0.0, imagF=0.0;	
		cdouble sumS=cdouble(0.0,0.0), sumD1=cdouble(0.0,0.0), sumD2=cdouble(0.0,0.0), sumPx=cdouble(0.0,0.0), sumPy=cdouble(0.0,0.0), sumP2=cdouble(0.0,0.0), total_sum=cdouble(0.0,0.0);
		double total_Fl_abs=0.0;
		int nk = 0;
		
		fstream infile;
		infile.open("data.dat",ios::in);
		double t0 = 1.0;
		while (infile >> it >> ik >> kx >> ky >> realG >> imagG >> realF >> imagF)
		{	
			if( fabs( it - t0) > 0.001 )
			{
				//ofile1 << it <<'\t'<< sumSx/nk) <<'\t'<< sumSy/nk<< '\t'<<sumD1x/nk <<'\t'<< sumD1y/nk <<'\t'<< sumD2x/nk <<'\t'<< sumD2y/nk<<'\t'<< sumPx/nk <<'\t'<< sumPy/nk <<'\t'<< total_sumx/nk <<'\t' << total_sumy/nk<< '\t' << total_Fl_abs/nk<< endl;
				ofile1 << it <<'\t'<<real(sumS)*(1.0/nk) <<'\t'<< imag(sumS)*(1.0/nk)<< '\t'
				<<real(sumD1)*(1.0/nk) <<'\t'<< imag(sumD2)*(1.0/nk) <<'\t'<< real(sumD2)*(1.0/nk) <<'\t'<< imag(sumD2)*(1.0/nk)<<'\t'
				<< real(sumPx)*(1.0/nk) <<'\t'<< imag(sumPx)*(1.0/nk) <<'\t'<< real(sumPy)*(1.0/nk) <<'\t' << imag(sumPy)*(1.0/nk)<< '\t'
				<<real(sumP2)*(1.0/nk) <<'\t' << imag(sumP2)*(1.0/nk)<< '\t'<< real(total_sum)*(1.0/nk) <<'\t' << imag(total_sum)*(1.0/nk)
				<< '\t' << total_Fl_abs*(1.0/nk)<< endl;
				
				cout<< it <<'\t'<< nk<<endl;
				sumS=cdouble(0.0,0.0), sumD1=cdouble(0.0,0.0), sumD2=cdouble(0.0,0.0), sumPx=cdouble(0.0,0.0), sumPy=cdouble(0.0,0.0), sumP2=cdouble(0.0,0.0), total_sum=cdouble(0.0,0.0), total_Fl_abs=0.0;
				nk = 0;
				//cout<<endl;
			}

			// x is the real component, y is the imaginary part.
			sumS += cdouble(realF + realF*(cos(kx) + cos(ky))/sqrt(2), imagF + imagF*(cos(kx) + cos(ky))/sqrt(2) );

			sumD1 += cdouble( realF*(cos(kx) - cos(ky))/sqrt(2) , imagF*(cos(kx) - cos(ky))/sqrt(2) );
	
			sumD2 += cdouble( realF*(sin(kx)*sin(ky)), imagF*(sin(kx)*sin(ky)) );
			
			sumPx += cdouble( realF*sin(kx) , imagF*sin(kx) );
			
			sumPy += cdouble( realF*sin(ky) , imagF*sin(ky) );
			
			sumP2 += cdouble( realF*(sin(kx) + sin( ky))/sqrt(2) , imagF*(sin(ky) + sin(kx))/sqrt(2) );

			total_sum += cdouble(realF,imagF );

			total_Fl_abs += abs( cdouble(realF,imagF) );
			
			//cout<< it <<'\t'<< ik <<'\t'<< kx<<'\t'<<ky<<'\t'<<realG<<'\t'<<imagG<<'\t'<<realF<<'\t'<<imagF<<endl;
			nk += 1;
			t0 = it;
		}
		infile.close();
	}
	ofile1.close();
	ofile2.close();
}
