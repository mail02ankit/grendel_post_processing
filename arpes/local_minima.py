import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
from scipy.misc import derivative
from scipy.optimize import fsolve
from scipy.optimize import brentq 

# This function uses splines, derivative to find local minima of a vector.
def local_extrema(_x,_y, do_plot):
    # Create spline using the data
    _spline_f = interp1d(_x, _y, kind = 'cubic' )

    ##### Find roots of the derivative.
    _dy = np.gradient(_y) # Numerical differentiation of the data.
    _spline_df = interp1d( _x, _dy, kind = 'cubic' ) # Spline for the derivative.
    
    # Find intervals  where derivative changes sign. It is required for the brentq routine.
    _ia = 0
    _root_df = np.array([]).reshape(0,1)
    for _iy in range( len(_dy) ):
        if _dy[_ia] * _dy[_iy] < 0:
            _ib = _iy 
            _root_df = np.append( _root_df,  brentq( _spline_df, _x[_ia], _x[_ib], xtol=1e-8) ) # Search a root [a,b] interval.
            _ia = _ib

    ## Plots
    if do_plot :
        fig, ax = plt.subplots(1,2, figsize = (8,4))
        ax = ax.ravel()
        ax[0].plot( _x, _y,'*',label='Raw' )
        ax[0].plot( _x, _spline_f(_x),'-',label='Spline' )
        ax[0].plot( _root_df, _spline_f(_root_df), 'o',label='Extrema' )
        
        ax[1].plot( _x, _dy,'*',label='Raw' )
        ax[1].plot( _x, _spline_df(_x),'-',label='Spline' )
 
        for ip in [0,1]:
            ax[0].set_title("F(x)")
            ax[1].set_title("F'(x)")
            ax[ip].legend(loc='upper left', frameon=True)
            #ax[ip].set_xlim(-0.8,0.1)
            ax[ip].grid()
        
        fig.savefig('test.eps', bbox_inches='tight')
        fig.savefig('test.jpg', bbox_inches='tight')

    return _root_df, _spline_f(_root_df)

# Read data
data = np.genfromtxt("./data.dat")
x = data[:,2]
y = data[:,3]
t = data[0,0]   # Delay time is fixed here.

# Find extrmas
xminima, yminima = local_extrema(x,y,1)
tlist = np.array( [ t for i in range(len(xminima) ) ] ) 
# out data.
np.savetxt( 'edc_minima_out.dat', np.transpose( np.array([ tlist, xminima, yminima ]) ), delimiter = " ", fmt='%0.16f')


