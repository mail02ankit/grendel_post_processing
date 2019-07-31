import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting

# Data load
folder = "./wigner/"
d01 = np.genfromtxt(folder+"kcut.dat")
c01 = 37 

# Plot parameters
fontl = 12
marksize = 3
wf = 0.2
pump_center = 40

fig, axlist = plt.subplots(1,2, figsize=(8,4), dpi=300)
axlist = axlist.ravel() # To convert 2D index of ax into 1D index.
fig.subplots_adjust(wspace=0.4, hspace=0.0)

#axlist[0].plot( d01[:,0] , d01[:,6],'o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{t_{delay}}=$'+str(c01-pump_center))
axlist[0].plot( d01[:,0] , d01[:,4],'o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{G^<(k=pi/2)}$')
axlist[0].plot( d01[:,0] , d01[:,12],'o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{G^<(k=-pi/2)}$')

axlist[1].plot( d01[:,0] , d01[:,5],'o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{G^<(k=pi/2)}$')
axlist[1].plot( d01[:,0] , d01[:,13],'o', markersize=marksize, fillstyle='none', lw=1, label=r'$\mathrm{G^<(k=-pi/2)}$')

# A straight line.
#axlist.plot((wf,wf),( -0.02,0.3), 'k-', color='b',linewidth=0.6, ls='--')

for ip in [0,1]:
    axlist[ip].legend(loc='upper right',fontsize=0.8*fontl)
    ## Customization.
    #Axis label
    axlist[ip].set_xlabel(r"$\mathrm{t} $ $[1/eV]$",  fontsize=fontl, labelpad = 2)
    axlist[0].set_ylabel(r'$\mathrm{Im}$', fontsize= 1.4*fontl, labelpad = 2)
    axlist[1].set_ylabel(r'$\mathrm{Re}$', fontsize= 1.4*fontl, labelpad = 2)
    #axlist[ip].annotate(r"$\mathrm{\omega_0}$",xy=(0.18,0.9), xycoords="axes fraction", ha="left", va="top",rotation=0, fontsize=1.0*fontl,color='b')
     
    #axlist[ip].set_xticks([0.0, 1.0, 1.50, 2.0])
    #axlist[ip].set_yticks([-0.8, -0.6, -0.4, -0.2, 0.0, 0.2])
    #axlist[ip].set_xlim(0.05,  1.0)
    #axlist[i[].set_ylim(-0.02,0.3)
    axlist[ip].xaxis.grid()
    axlist[ip].tick_params(axis='both', which='major', labelsize=1.0*fontl) 
            
#fig.savefig('test.eps', bbox_inches='tight')
fig.savefig('test.jpg', bbox_inches='tight')
plt.close()
plt.close(fig)
