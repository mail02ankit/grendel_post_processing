/*
	This program do FFT for a given data file.
	UPdate - 160905 Final thought and from now I will do FS analysis.
*/

#include <iostream>
#include <iomanip>
#include <cmath>
#include <fstream>

#include <omp.h>
#include <complex>
#include <vector>

using namespace std;

typedef complex<double> cdouble;
typedef vector<cdouble> cd_vec;
typedef vector<double>  d_vec;

int main()
{
	double tt=0.0, ftr=0.0, fti=0.0;	
	int nt = 0;		
		
	d_vec t;
	cd_vec ft;

	// Time domain values.
	fstream infile;
	infile.open("data.dat",ios::in);
	while (infile >> tt>> ftr>> fti )
	{
		t.push_back( tt );
		ft.push_back( cdouble( ftr, fti ) );
		nt += 1;
	}
	infile.close();
	double dt = t[1] - t[0];

	//----Just to check If file read is good. Compare this file to data.dat.
	infile.open("in.dat",ios::out);
	for( int it = 0; it < nt; it++ )
	{
		infile << t[it] << "\t" << real(ft[it]) <<"\t" << imag(ft[it]) <<endl;
	}
	infile.close();
	
	//---FT starts here.
	int nnw = nt/2;
	int nw = 2*nnw + 1;	//--To have zero frequency.
	double dw =  2*M_PI/(nt*dt) ;;
	double w0 = - (nw-1)*dw/2;
	
	d_vec w;
	cd_vec Fw;

	// FFT from t to w.
	fstream ofile;
	ofile.open("out.dat",ios::out);
	for( int iw = 0; iw < nw; iw++ )
	{
		double ww = w0 + iw*dw; 
		w.push_back( ww );
		
		cdouble sum = 0.0 + 0.0*1i;
		for(int it = 0; it < nt; it++)
		{
			cdouble z = 0.0 - t[it]*w[iw]*1i;
			sum += ft[it]*exp(-z)*(1.0/nt) ;
		}
		ofile<< w[iw]<<"\t" <<real(sum)<< "\t"<< imag(sum)<<"\t"<<abs(sum) <<endl;
	}
	ofile.close();
}
