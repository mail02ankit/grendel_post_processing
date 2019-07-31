import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting
from scipy.interpolate import Akima1DInterpolator
from scipy.interpolate import interp1d  # for symbolic calculation
from scipy.integrate import simps

# Data load
folder = "./"
data = np.genfromtxt(folder+"out.dat")
#### Conductivity from two time chi data
d01 = np.array( [] ).reshape(0,3)
for it in range( len(data[:,0]) ):
    # Remove division by zero.
    if data[it,0] != 0.0:
        d01 = np.vstack(( d01, np.array( [data[it,0], data[it,1]/data[it,0], data[it,2]/data[it,0]] ) ))
    else:
        eta = 0.0001
        d01 = np.vstack(( d01, np.array( [data[it,0], data[it,1]/(data[it,0]+eta), data[it,2]/(data[it,0]+eta)] ) ))

#### Interpolate data
#si = ( np.abs( d01[:,0]-0.0001 ) ).argmin()  # Start index based on xvalue condition
#ei = ( np.abs( d01[:,0]-1.4 ) ).argmin()  # End index
si = 0  # Start index based on xvalue condition
ei = -1  # End index


intp_time = 1 
wnew = np.linspace( d01[si,0], d01[ei-1,0], intp_time*len(d01[si:ei,0]))    # interpolation_times* means twice the number of points.
sigma1 = interp1d( d01[si:ei,0] , d01[si:ei,1], kind = 'cubic')
sigma2 = interp1d( d01[si:ei,0] , d01[si:ei,2], kind = 'cubic')

### Normalize conductivity to compare with J=sigma E.
## Find index at phonon frequency.
idw = ( np.abs(wnew- 0.8) ).argmin()
print("Normalization wrt: w=", wnew[idw], " sigma1 = ", sigma1( wnew[idw] ) , " sigma2 = ", sigma2( wnew[idw] ) )

# To get same value at idw as JE conductivity. Look for this value from JE conductivity
je_cond1_norm = 0.04936483598564118   
je_cond2_norm = 0.1582813687156831
## No normaliztion 
#je_cond1_norm = sigma1( wnew[idw] )  
#je_cond2_norm = sigma2( wnew[idw] )   

# Save normalized cond data.
np.savetxt( 'cond.dat', np.transpose( np.array( [ wnew, je_cond1_norm*sigma1(wnew)/sigma1( wnew[idw] ), je_cond2_norm*sigma2(wnew)/sigma2( wnew[idw] ), sigma1(wnew), sigma2(wnew) ] ) ),delimiter = " ", fmt='%0.16f')

## Or normalize using the sum rule
#dw = wnew[1] - wnew[2]
#sum_range = (wnew[:] >0) & ( wnew[:]< 1.2)
## Save normalized cond data.
#norm = simps(sigma1( wnew[sum_range] ), dx=dw)
#print( "Normalization  wrt: area=",norm)
#np.savetxt( 'cond.dat', np.transpose( np.array( [ wnew, sigma1(wnew)/norm, sigma2(wnew)/norm, sigma1(wnew), sigma2(wnew) ] ) ),delimiter = " ", fmt='%0.16f')
####

#### Plots
# Plot parameters
fontl = 12
marksize = 3

fig, axlist = plt.subplots(1,2, figsize=(8,4), dpi=300)
axlist = axlist.ravel() # To convert 2D index of ax into 1D index.
fig.subplots_adjust(wspace=0.4, hspace=0.0)

axlist[0].plot( d01[:,0] , d01[:,1],'-o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\sigma_1}$')
axlist[1].plot( d01[:,0] , d01[:,2],'-o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\sigma_2}$')

# A straight line.
#axlist.plot((wf,wf),( -0.02,0.3), 'k-', color='b',linewidth=0.6, ls='--')

for ip in [0,1]:
    axlist[ip].legend(loc='upper right',fontsize=0.8*fontl)
    ## Customization.
    #Axis label
    axlist[ip].set_xlabel(r"$\mathrm{\omega} $ $[eV]$",  fontsize=fontl, labelpad = 2)
    axlist[1].set_ylabel(r'$\mathrm{Im}$', fontsize= 1.4*fontl, labelpad = 2)
    axlist[0].set_ylabel(r'$\mathrm{Re}$', fontsize= 1.4*fontl, labelpad = 2)
    #axlist[ip].annotate(r"$\mathrm{\omega_0}$",xy=(0.18,0.9), xycoords="axes fraction", ha="left", va="top",rotation=0, fontsize=1.0*fontl,color='b')
     
    #axlist[ip].set_xticks([0.0, 1.0, 1.50, 2.0])
    #axlist[ip].set_yticks([-0.8, -0.6, -0.4, -0.2, 0.0, 0.2])
    axlist[ip].set_xlim(0.00,  1.2)
    #axlist[i[].set_ylim(-0.02,0.3)
    axlist[ip].xaxis.grid()
    axlist[ip].tick_params(axis='both', which='major', labelsize=1.0*fontl) 
            
#fig.savefig('plot.eps', bbox_inches='tight')
fig.savefig('cond.jpg', bbox_inches='tight')
plt.close()
plt.close(fig)
#####################
