import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting

# Data load
folder = "./out/"
d01 = np.genfromtxt(folder+"cond001.dat")
c01 = 40 
d02 = np.genfromtxt(folder+"cond002.dat")
c02 = 45 
d03 = np.genfromtxt(folder+"cond003.dat")
c03 = 50 
d04 = np.genfromtxt(folder+"cond004.dat")
c04 = 55 
d05 = np.genfromtxt(folder+"cond005.dat")
c05 = 60 
d06 = np.genfromtxt(folder+"cond006.dat")
c06 = 65 
d07 = np.genfromtxt(folder+"cond007.dat")
c07 = 70 
d08 = np.genfromtxt(folder+"cond008.dat")
c08 = 75 
d09 = np.genfromtxt(folder+"cond009.dat")
c09 = 80 
d10 = np.genfromtxt(folder+"cond010.dat")
c10 = 85 
d11 = np.genfromtxt(folder+"cond011.dat")
c11 = 90 
d12 = np.genfromtxt(folder+"cond012.dat")
c12 = 95 

# Plot parameters
fontl = 12
marksize = 3
wf = 0.2
pump_center = 40

fig, axlist = plt.subplots(1,1, figsize=(7,4), dpi=300)
fig.subplots_adjust(wspace=0.0, hspace=0.0)

#axlist.plot( d01[:,0] , d01[:,1],'s-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c01-pump_center))
#axlist.plot( d02[:,0] , d02[:,1],'o-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c02-pump_center))
#axlist.plot( d03[:,0] , d03[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c03-pump_center))
#axlist.plot( d04[:,0] , d04[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c04-pump_center))
#axlist.plot( d05[:,0] , d05[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c05-pump_center))
axlist.plot( d06[:,0] , d06[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c06-pump_center))
axlist.plot( d07[:,0] , d07[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c07-pump_center))
axlist.plot( d08[:,0] , d08[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c08-pump_center))
axlist.plot( d09[:,0] , d09[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c09-pump_center))
axlist.plot( d10[:,0] , d10[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c10-pump_center))
axlist.plot( d11[:,0] , d11[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c11-pump_center))
axlist.plot( d12[:,0] , d12[:,1],'*-', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c12-pump_center))

# A straight line.
axlist.plot((wf,wf),( -0.02,0.3), 'k-', color='b',linewidth=0.6, ls='--')

axlist.legend(loc='upper right',fontsize=0.8*fontl)
## Customization.
#Axis label
axlist.set_xlabel(r"$\mathrm{\omega} $ $[eV]$",  fontsize=fontl, labelpad = 2)
axlist.set_ylabel(r'$\mathrm{Re[\sigma]}$', fontsize= 1.4*fontl, labelpad = 2)
axlist.annotate(r"$\mathrm{\omega_0}$",xy=(0.18,0.9), xycoords="axes fraction", ha="left", va="top",rotation=0, fontsize=1.0*fontl,color='b')
 
#axlist.set_xticks([0.0, 1.0, 1.50, 2.0])
#axlist.set_yticks([-0.8, -0.6, -0.4, -0.2, 0.0, 0.2])
axlist.set_xlim(0.05, 0.6)
axlist.set_ylim(-0.00,0.2)
axlist.tick_params(axis='both', which='major', labelsize=1.0*fontl) 
        
fig.savefig('test.eps', bbox_inches='tight')
plt.close()

# Extra tricks
#ax = ax.ravel() # To convert 2D index of ax into 1D index.
#for i in [0, 3]:
#    ax[i].set_xlim(-50,50 )
plt.close(fig)
