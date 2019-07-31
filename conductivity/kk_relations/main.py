# 170830 :  This program calculates real and imaginary part of a retarded function using KK relation.
#   Note: It assumes that data is given only for positive frequencies.

import numpy as np      # for numerical algebra
# Plots
import matplotlib
matplotlib.use('Agg')   # To not display image, x11 error.
import matplotlib.pyplot as plt 

#Shell environment
import os
import sys
import subprocess               # to send python variables to shell.

#Output folder
subprocess.call(['rm','-r','out/' ])
subprocess.call(['mkdir','out/' ])

# Read files
folder = '../../'
### pump
data = np.genfromtxt("data.dat")

realToimg = 0 
dt = data[1,0] - data[0,0]
out = np.array([]).reshape(0,3)	# Initialize a blank array

for i in range( len(data[:,0]) ):
    fsum = 0.0
    for j in range( len(data[:,0]) ):   # Sum loop
        if data[j,0] != data[i,0] :     # Principal value.
            if realToimg :  # Real to img.
                fsum = fsum - (2*dt/np.pi) * data[i,0]*data[j,1]/( data[j,0]*data[j,0] - data[i,0]*data[i,0] ) # Even to odd
                #print( "real to img")
            else:   # Img to real.
                fsum = fsum + (2*dt/np.pi) * data[j,0]*data[j,1]/( data[j,0]*data[j,0] - data[i,0]*data[i,0] )  # Odd to even
                #print( "img to real")
    if realToimg :  # Real to img.
        out = np.vstack(( out, np.array( [data[i,0], data[i,1], fsum] ) ) )
    else :
        out = np.vstack(( out, np.array( [data[i,0], fsum, data[i,1]] ) ) )
    #print( data[i,0],fsum, data[i,1])

# save data
np.savetxt( ''.join( ('./out/out.dat') ), out,delimiter = " ",fmt='%0.8f')

