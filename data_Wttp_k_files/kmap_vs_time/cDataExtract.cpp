/*
	This program read  from a given data file.
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
	ofile1.open("d_data.dat",ios::out);
	ofile2.open("ad_data.dat",ios::out);
	
	
	double tmax=0.0;
	fstream infile;
	infile.open("tmax",ios::in);
	while (infile >>tmax ){}
	infile.close();
	cout <<"tmax "<<tmax<<endl;

	omp_set_num_threads(30);
	#pragma omp parallel for
	for( int i=0; i<8000; i++)
	{
		char filename[256];
		double t1=0.0, t2=0.0, x1=0.0, x2=0.0, x3=0.0, x4=0.0, x5=0.0, x6=0.0, x7=0.0, x8=0.0, x9=0.0, x10=0.0;	
		int nt = 0;
		sprintf(filename,"../../../data/Wk_ttp_k%03d",i);
		
		//cout<<filename <<endl;
		fstream infile;
		infile.open(filename,ios::in);
		while (infile >>t1>>t2>>x1>>x2>>x3>>x4>>x5>>x6>>x7>>x8>>x9>>x10 )
		{
			//cout<< t1<<t2<<endl;
			// Along time t=t'
			if( fabs(t1 - t2) <=0.0001 )
			{
				#pragma omp critical
				{
					ofile1<< t1 <<' '<< t2<< ' '<<x1<< ' '<<x2
					<< ' '<<x3<< ' '<<x4<< ' '<<x5<< ' '<<x6
					<< ' '<<x7<< ' '<< x8<< ' '<< x9<< ' '<< x10<< endl;
				}
			}
			// Along time t=-t'
			if( fabs(t1 + t2 -tmax ) <=0.0001 )
			{
				#pragma omp critical
				{	
					ofile2<< t1 <<' '<< t2<< ' '<<x1<< ' '<<x2
					<< ' '<<x3<< ' '<<x4<< ' '<<x5<< ' '<<x6
					<< ' '<<x7<< ' '<< x8<< ' '<< x9<< ' '<< x10<< endl;
				}
			}

			nt += 1;
		}
		infile.close();
	}
	ofile1.close();
	ofile2.close();
}
