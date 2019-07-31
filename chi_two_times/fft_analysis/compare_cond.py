import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting
from scipy.interpolate import Akima1DInterpolator
from scipy.interpolate import interp1d  # for symbolic calculation
from scipy.integrate import simps

# Data load
folder = "../../conductivity/out/"
d01 = np.genfromtxt(folder+"cond000.dat")
#### Conductivity from two time chi data

#### Interpolate data
si = ( np.abs( d01[:,0]-0.001 ) ).argmin()  # Start index based on xvalue condition
ei = ( np.abs( d01[:,0]-1.0 ) ).argmin()  # End index

intp_time = 1 
wnew = np.linspace( d01[si,0], d01[ei-1,0], intp_time*len(d01[si:ei,0]))    # interpolation_times* means twice the number of points.
sigma1 = interp1d( d01[si:ei,0] , d01[si:ei,1], kind = 'cubic')
sigma2 = interp1d( d01[si:ei,0] , d01[si:ei,2], kind = 'cubic')

### Normalize conductivity to compare with J=sigma E.
## Find index at phonon frequency.
idw = ( np.abs(wnew- 0.8) ).argmin()
print("Normalization wrt: w=", wnew[idw], " sigma1 = ", sigma1( wnew[idw] ) , " sigma2 = ", sigma2( wnew[idw] ) )

## No normaliztion 
je_cond1_norm = sigma1( wnew[idw] )  
je_cond2_norm = sigma2( wnew[idw] )   

# Save normalized cond data.
np.savetxt( 'condJE.dat', np.transpose( np.array( [ wnew, je_cond1_norm*sigma1(wnew)/sigma1( wnew[idw] ), je_cond2_norm*sigma2(wnew)/sigma2( wnew[idw] ), sigma1(wnew), sigma2(wnew) ] ) ),delimiter = " ", fmt='%0.16f')

## Or normalize using the sum rule
#dw = wnew[2] - wnew[1]
#sum_range = (wnew[:] >0) & ( wnew[:]< 1.2)
## Save normalized cond data.
#norm = simps(sigma1( wnew[sum_range] ), dx=dw)
#print( "Normalization  wrt: area=",norm)
#np.savetxt( 'condJE.dat', np.transpose( np.array( [ wnew, sigma1(wnew)/norm, sigma2(wnew)/norm, sigma1(wnew), sigma2(wnew) ] ) ),delimiter = " ", fmt='%0.16f')
####


