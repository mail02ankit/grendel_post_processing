/*

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

void readJ(ifstream &ifile, d_vec *tlist, d_vec *jlist)
{
	double t1=0.0, f2=0.0, f3, f4=0.0, f5=0.0, f6=0.0, f7=0.0 ;	    // 7 columns in J file.
    while(ifile >> t1>> f2>> f3>> f4>> f5>> f6>> f7 )
	{
        tlist-> push_back(t1);
        jlist-> push_back(f2);
	}
}

void readE(ifstream &ifile, d_vec *tlist, d_vec *elist)
{
	double t1=0.0, f2=0.0, f3;	    // 3 columns in E file.
    while(ifile >> t1>> f2>> f3 )
	{
        tlist-> push_back(t1);
        elist-> push_back(f3);
	}
}

void writeF(ofstream &ofile, d_vec *tlist, d_vec *jlist)
{
	for( int it = 0; it< jlist->size()  ; it++ )
	{
        ofile << setw(16) << setprecision(16)<< " "
            << tlist->at(it)<< " " << jlist-> at(it) <<" "<< 0.0 << " "
            << endl;
    }
}

int main()
{
    // Record start time
    auto start = std::chrono::high_resolution_clock::now();

    int debug = 0;
    
    //---------- Read J0, J1 file: Remove # from the beginning.
    d_vec *tJ0, *J0, *tE0, *E0;
    tJ0 = new d_vec ;
    J0 = new d_vec ;
    ifstream ifile;
	ifile.open("J0.dat");
    readJ( ifile, tJ0, J0);
    ifile.close();

    ifile.open("E0.dat");
    tE0 = new d_vec ;
    E0 = new d_vec ;
    readE( ifile, tE0, E0 );
    ifile.close();
    
    d_vec *tJ1, *J1, *tE1, *E1;
    tJ1 = new d_vec ;
    J1 = new d_vec ;
	ifile.open("J1.dat");
    readJ( ifile, tJ1, J1 );
    ifile.close();

	ifile.open("E1.dat");
    tE1 = new d_vec ;
    E1 = new d_vec ;
    readE( ifile, tJ1, E1 );
    ifile.close();
    
    // ----------------------------

    // ----TO check if we read the right data in the right form.
    if(debug)
    {
        ofstream ofile ;
        ofile.open("outJ0.dat");
        writeF(ofile, tJ0, J0);
        ofile.close();
        
        ofile.open("outE0.dat");
        writeF(ofile, tE0, E0);
        ofile.close();
        
        ofile.open("outJ1.dat");
        writeF(ofile, tJ1, J1);
        ofile.close();
 
        ofile.open("outE1.dat");
        writeF(ofile, tE1, E1);
        ofile.close();
    }

    //------ Subtract 
    d_vec *tJ, *J, *tE, *E;
    tJ = new d_vec ;
    J = new d_vec ;
    tE = new d_vec ;
    E = new d_vec ;
    
    int itt=0;
	for( int it = 0; it< J0->size()  ; it++ )
	{ 
        if( tJ0->at(it) == tJ1->at(itt) && itt < tJ1->size() - 1 )
        {
            tJ->push_back( tJ0->at(it) );
            J->push_back( J1->at(itt) - J0->at(it) );
            
            tE->push_back( tJ0->at(it) );
            E->push_back( E1->at(itt) - E0->at(it) );
 
            itt++;
        }
    }
    ofstream ofile ;
	ofile.open("J.dat");
    writeF(ofile, tJ, J);
    ofile.close();
	
    ofile.open("E.dat");
    writeF(ofile, tE, E);
    ofile.close();


    delete tJ0, tJ1, J0, J1;
   
   // Record end time
    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;
    std::cout << "Elapsed time: " << elapsed.count() << " s\n";
}
