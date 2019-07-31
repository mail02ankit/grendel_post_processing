import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting

# Data load
folder = "./decay_rates/"
d01 = np.genfromtxt(folder+"final-0.14-data.dat")
c01 = 0.14 
d02 = np.genfromtxt(folder+"final-0.18-data.dat")
c02 = 0.18 
d03 = np.genfromtxt(folder+"final-0.22-data.dat")
c03 = 0.22 
d04 = np.genfromtxt(folder+"final-0.26-data.dat")
c04 = 0.26 

# Plot parameters
fontl = 12
marksize = 3
wf = 0.2
pump_center = 40
Amax = 0.4

fig, axlist = plt.subplots(1,1, figsize=(7,4), dpi=300)
fig.subplots_adjust(wspace=0.0, hspace=0.0)

axlist.plot( d01[:,0] , d01[:,1],'s-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\omega}=$'+str(c01))
axlist.plot( d02[:,0] , d02[:,1],'o-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\omega}=$'+str(c02))
axlist.plot( d03[:,0] , d03[:,1],'o-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\omega}=$'+str(c03))
axlist.plot( d04[:,0] , d04[:,1],'o-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{\omega}=$'+str(c04))

# A straight line.
#axlist.plot((wf,wf),( -0.02,0.3), 'k-', color='b',linewidth=0.6, ls='--')

axlist.legend(loc='upper right',fontsize=0.8*fontl)
## Customization.
#Axis label
axlist.set_title(r'$\mathrm{A_{max}= 0.4}$')
#axlist.set_xlabel(r"$\mathrm{\omega} $ $[eV]$",  fontsize=fontl, labelpad = 2)
axlist.set_xlabel(r"$\mathrm{t_{delay}} $ $[1/eV]$",  fontsize=fontl, labelpad = 2)
axlist.set_ylabel(r'$\mathrm{Re[\sigma]}$', fontsize= 1.4*fontl, labelpad = 2)
axlist.annotate(r"$\mathrm{\omega_0}$",xy=(0.18,0.9), xycoords="axes fraction", ha="left", va="top",rotation=0, fontsize=1.0*fontl,color='b')
 
#axlist.set_xticks([0.0, 1.0, 1.50, 2.0])
#axlist.set_yticks([-0.8, -0.6, -0.4, -0.2, 0.0, 0.2])
axlist.set_xlim(60, 101)
axlist.set_ylim(0.08,0.15)
axlist.tick_params(axis='both', which='major', labelsize=1.0*fontl) 
        
fig.savefig('test.eps', bbox_inches='tight')
plt.close()

# Extra tricks
#ax = ax.ravel() # To convert 2D index of ax into 1D index.
#for i in [0, 3]:
#    ax[i].set_xlim(-50,50 )
plt.close(fig)
