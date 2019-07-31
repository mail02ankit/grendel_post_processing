/*
	This program do FFT for a given data file.
	UPdate - 160905 Final thought and from now I will do FS analysis.
    update- 170423 -  Fixed to normalization.
    update- 170502 -  Fixed to normalization gain .It should be other way around.
    update 170511 - Added exponentially decay part to remove harmonics.
    update 180909 - Added padding.
    update 181109 - Added a routine to remove linear component from the time signal.
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
    double decay = 0.005;
    int do_tw = 1;

    // To remove linear portion of data.
    int do_linear_remove = 1;

    // Do padding.
    int do_padding = 0;
    int n_padding = 200;
		
	d_vec t;
	cd_vec ft;
    
    int nthreads = omp_get_max_threads( );

    cout<< "Number of openmp threads: "<< nthreads<< endl;
    //cout<< "t to w (yes 1, no 0):";
    //cin >> do_tw;
    //cout<< "Decay multiplier( exp(-a*t) ), a=";
    //cin >> decay;

	// Time domain values.
	fstream infile;
	infile.open("data.dat",ios::in);
	while (infile >> tt>> ftr>> fti )
	{
		t.push_back( tt );
		ft.push_back( cdouble( ftr, fti ) );
	}
	infile.close();
	double dt = t[1] - t[0];
 
    // Remove linear portion from the data (To enhance non-zero frequency amplitude)
    if( do_linear_remove )
    {
        cdouble slope = ( ft[t.size()-1] - ft [0] )/( t[t.size()-1] - t[0] );
        cdouble f0 = ft[0]; // Because we reset ft[0] in the loop.
        for( int ip=0; ip< t.size(); ip++ )
        {
            // y - ( m(x-x1) + y1 )
            ft[ip] = ft[ip] - ( slope*( t[ip] - t[0] ) + f0 );
        }
    }

    // Pad the data (by default with zeros)
    if( do_padding )
    {
        for( int ip=0; ip< n_padding; ip++ )
        {
            tt = t[t.size()-1] + dt;
            t.push_back( tt );  // Pad linear extrapolation in x data.
            ft.push_back( cdouble( 0.0, 0.0 ) );// Pad zeros in y data.
        }
    }
   
	//----Just to check If file read is good. Compare this file to data.dat.
	infile.open("in.dat",ios::out);
	for( int it = 0; it < t.size(); it++ )
	{
        double converge = exp( -decay*fabs( t[it] ) );
		infile << t[it] << "\t" 
                << real(ft[it]) <<"\t" << imag(ft[it])<< "\t"
                << converge*real(ft[it]) <<"\t" << converge*imag(ft[it])<< "\t"
                <<endl;
	}
	infile.close();
	
	//---FT starts here.
    int nt = t.size();
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
		
		double rsum = 0.0, isum = 0.0;
        omp_set_num_threads( nthreads );
        #pragma omp parallel for reduction(+:rsum,isum)
		for(int it = 0; it < nt; it++)
		{
            double converge = exp( -decay*fabs( t[it] ) );
            if( do_tw )
            {
                cdouble z = 0.0 + t[it]*w[iw]*1i;   // + if going from x to k 
                rsum += real( converge*ft[it]*exp(z)*dt ) ;
                isum += imag( converge*ft[it]*exp(z)*dt) ;
            }else
            {
                cdouble z = 0.0 - t[it]*w[iw]*1i;   // + if going from k to x 
                rsum += real( converge*ft[it]*exp(z)*dt/(2*M_PI) ) ;
                isum += imag( converge*ft[it]*exp(z)*dt/(2*M_PI) ) ;
            }
		}
        cdouble sum = cdouble( rsum, isum );
		ofile<< w[iw]<<"\t" <<real(sum)<< "\t"<< imag(sum)<<"\t"<<abs(sum) <<endl;
	}
	ofile.close();
}
