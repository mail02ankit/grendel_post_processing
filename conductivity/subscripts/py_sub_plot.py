import numpy as np	# for numerical algebra
import matplotlib.pyplot as plt	# For plotting

# Plots
fig, ax = plt.subplots(3,3,figsize=(15, 15))
ax = ax.ravel() # To convert 2D index of ax into 1D index.

#ax.set_xlabel(r'$\mathrm{k_x = k_y}\ $', fontsize=12)

# data1
ax[0].plot(x0,y0, '-x')
ax[0].title.set_text('Field')
ax[1].plot(freq0,fkr0, '-*', color='r', label='Real')
ax[1].plot(freq0,fki0, '-*', color='g',label='Imag')
ax[2].plot(freq0,abs(fk0), '-*', label='Abs')
# data2
ax[3].plot(x1,y1, '-x', label='Current')
ax[4].plot(freq1,fkr1, '-*',color='r', label='Real')
ax[4].plot(freq1,fki1, '-*',color='g', label='imag')
ax[5].plot(freq1,abs(fk1), '-*', label='Abs')
#data3
ax[6].plot(freq,fkr, '-*', label='Real')
ax[7].plot(freq,fki, '-*', label='Imag ')
ax[8].plot(field0[:,0] , field0[:,2] , '-*', label='Pump')

# axis
for i in [0, 3]:
    ax[i].set_xlim(-50,50 )
    ax[i].grid()
    ax[0].title.set_text('E')
    ax[3].title.set_text('Current')
for i in [1, 4]:
    ax[i].set_xlim(-4,4 )
    ax[i].grid()
    ax[i].title.set_text('FT real, imag')
for i in [2, 5]:
    ax[i].set_xlim(-4,4 )
    ax[i].grid()
    ax[i].title.set_text('FT Abs')
for i in [6, 7]:
    ax[i].set_xlim(-1,1 )
    ax[i].set_ylim(-0.5,0.5 )
    ax[i].grid()
    ax[6].title.set_text(' Conductivity -real')
    ax[7].title.set_text(' Conductivity -imag')
ax[8].title.set_text(' Pump')
ax[8].grid()

fig.savefig(''.join( ('./out/fig_cond',index,'.pdf') ), bbox_inches='tight')
#plt.close(fig)
