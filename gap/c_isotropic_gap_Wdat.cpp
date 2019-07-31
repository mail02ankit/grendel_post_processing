/*
    * 171023 I added this program in gredel_postprocessing git to calculate gap for conductivity runs.

	This program reads W.dat type files.
    * If data is saved only for the diagonal part of the 2D square.
    * Give input only tmax and dt.
    * 170508    - Ready
*/

#include <iostream>
#include <iomanip>
#include <cmath>
#include <fstream>
#include <chrono>  // for high_resolution_clock

#include <omp.h>
#include <complex>
#include <vector>

using namespace std;

typedef complex<double> cdouble;
typedef vector<cdouble> cd_vec;
typedef vector<double>  d_vec;

int main()
{
    // Record start time
    auto start = std::chrono::high_resolution_clock::now();
    
    // Use td.inp file 
    double dt = 0.2;        // Change dt here.
    double tmax = 146;   // change tmax .
    int num_t = tmax/dt;   
 
    double *tlist;
    cdouble *f1, *f2;
   
    int nmax =  num_t*( num_t+1 )/2.0 ;
    tlist = new double[ nmax ] ;
    f1 = new cdouble[ nmax ];
    f2 = new cdouble[ nmax ];
   
    int nthreads = omp_get_max_threads( );
    cout<< "Number of openmp threads: "<< nthreads<< endl;

	// Time domain values.
	fstream infile;
	infile.open("../../W000.dat",ios::in);

	double t1=0.0, t2=0.0, if1=0.0, rf1=0.0, if2=0.0, rf2=0.0, temp01=0.0 ;	
    int nt = 0, it=0, itp=0;
    
    while( (infile >> t1>> t2>> temp01 >>temp01>> temp01>> temp01>>rf1>> if1>> rf2>> if2 ) && nt <= nmax )
	{
        it = (int) ( 0.5*(-1 + sqrt(8*nt + 1) ) );
        itp = nt - 0.5*it*(it+1);
        
        tlist[it] = it*dt;
        f1[ nt ] =  cdouble( rf1, if1 );
        f2[ nt ] =  cdouble( rf2, if2 );
        //cout << it<< " "<< itp<< " "
         //   << tlist[it] << " "<< nt << " "
          //  << endl;
        nt ++;
	}
	infile.close();
    
    // ----TO check if we read the right data in the right form.
    fstream ofile;
	ofile.open("outW.dat",ios::out);
	for( int it = 0; it<  num_t; it++ )
	for( int itp = 0; itp<= it; itp++ )
	{
        int i = 0.5*it*(it+1) + itp;
        ofile << tlist[it]<< " "<< tlist[itp] << " "
             << f1[i].real() << " "<< f1[i].imag()<< " "
             << f2[i].real() << " "<< f2[i].imag()<< " "
            << endl;
	}
	ofile.close();

	// ----------Gap calculation for different lengths.
    int t_sum_length_start = 50;
    int dt_sum_length = 50;
    double decay_exp = 0.02;
	
	for( int itsum = 0; itsum<9; itsum++ )
    {
        int t_sum_length = t_sum_length_start + itsum * dt_sum_length; 
        
        cout << "Doing tsum_length:" <<t_sum_length << endl;
   
        char gap_filename[256];
        sprintf( gap_filename, "gap%03d.dat", t_sum_length);
        ofstream gap_file;
        gap_file.open( gap_filename );
        
   //     #pragma omp paraller for
        for(int ittp=0; ittp < num_t; ittp++)
        {
            cdouble gapG = cdouble( 0.0, 0.0 ) ;
            cdouble gapF = cdouble( 0.0, 0.0 ) ;
            
            int nt_count = 0;
            for( int it = 0; ittp + it < num_t && ittp - it > 0 ; it++ )
            {
                double shape  = exp( -decay_exp*( tlist[ittp+it] - tlist[ittp-it] ) );
                if( nt_count <= t_sum_length )
                {
                    int index_first = 0.5*(ittp+it)*( (ittp+it)+1 ) + (ittp-it);
                    int index_second = 0.5*(ittp+it)*( (ittp+it)+1 ) + (ittp-it);

                    gapG += shape*f1[ index_first ]; 
                    gapF += shape*f2[ index_first ]; 
                    //gap += shape*( f2(ittp+it, ittp-it ) - Wlist[ik]->lesser->at(ittp+it , ittp-it) )*kmap[ik].weight;        // Do extra algo.
                    nt_count ++;
                }
            }
//            #pragma omp critical 
 //           {
                if( nt_count == t_sum_length+1)
                {
                    gapG = gapG*dt ;
                    gapF = gapF*dt ;
                    gap_file << tlist[ittp] <<"\t" << gapG.real() <<'\t'<< gapG.imag() << '\t'
                         << gapF.real() <<'\t'<< gapF.imag() << '\t'
                            <<endl;
                }
  //          }
        }
    	gap_file.close();
    }

    // Record end time
    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;
    std::cout << "Elapsed time: " << elapsed.count() << " s\n";
}
