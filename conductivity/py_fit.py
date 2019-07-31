import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting
from scipy.optimize import curve_fit   
# Data load
folder = "./decay_rates/"
data = np.genfromtxt(folder+"final-0.24-data.dat")

# Plot parameters
fontl = 12
marksize = 3

def fitfunc(x,a,b,c):
    return a*np.exp(-x*b)+c   

def expo_fit(x,y,ax):        
    p0 = [y[1],0.01,y[-1]]        
    (popt, pcov) = curve_fit(fitfunc,x,y,p0=p0 ,maxfev=20000 )           
    #print( "Parameters:", popt)
    #print( "Errors:", np.sqrt(np.diag(pcov)))
    return popt, np.sqrt(np.diag(pcov))

start = 3    
end = (len( data[:,0] ) - 1) - 0
x = data[start:end,0] - data[start,0]
y = data[start:end,1]
#print( data[-1,0], data[end,0])

fig, axlist = plt.subplots(1,1, figsize=(7,4), dpi=300)
fig.subplots_adjust(wspace=0.0, hspace=0.0)

(param, std_error) = expo_fit(x,y,axlist)
print( "Parameters:", param)
print( "Errors:", 100*std_error/param)

#axlist.plot(data[:,0],data[:,1],'s',linewidth=2,label='Data')
axlist.plot( x, fitfunc( x, param[0], param[1], param[2] ),'-',label='Fit',linewidth=2) 
axlist.plot(x,y,'s',linewidth=2,label='Data')

#axlist.plot( d01[:,0] , d01[:,1],'s-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c01-pump_center))

# A straight line.
#axlist.plot((wf,wf),( -0.02,0.3), 'k-', color='b',linewidth=0.6, ls='--')

axlist.legend(loc='upper right',fontsize=0.8*fontl)
## Customization.
#Axis label
axlist.set_xlabel(r"$\mathrm{\omega} $ $[eV]$",  fontsize=fontl, labelpad = 2)
axlist.set_ylabel(r'$\mathrm{Re[\sigma]}$', fontsize= 1.4*fontl, labelpad = 2)
#axlist.annotate(r"$\mathrm{\omega_0}$",xy=(0.18,0.9), xycoords="axes fraction", ha="left", va="top",rotation=0, fontsize=1.0*fontl,color='b')
 
#axlist.set_xticks([0.0, 1.0, 1.50, 2.0])
#axlist.set_yticks([-0.8, -0.6, -0.4, -0.2, 0.0, 0.2])
#axlist.set_xlim(0.05, 0.6)
#axlist.set_ylim(-0.00,0.2)
axlist.tick_params(axis='both', which='major', labelsize=1.0*fontl) 
        
fig.savefig('test.eps', bbox_inches='tight')
plt.close()

# Extra tricks
#ax = ax.ravel() # To convert 2D index of ax into 1D index.
#for i in [0, 3]:
#    ax[i].set_xlim(-50,50 )
plt.close(fig)
