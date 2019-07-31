import numpy as np  # for numerical algebra
# Plots
import matplotlib
matplotlib.use('Agg')   # To not display image, x11 error.
import matplotlib.pyplot as plt 
from scipy.interpolate import interp1d  # for symbolic calculation
from scipy.interpolate import Akima1DInterpolator

#Shell environment
import os
import sys
import subprocess       # to send python variables to shell.

def do_fft( x, y ):
    dx = x[2] - x[1]
    fk = np.fft.fftshift(np.fft.ifft(y))*len(x)*dx
    fkr = np.real(fk)
    fki = np.imag(fk)
    freq = np.fft.fftshift( np.fft.fftfreq( len(x),dx ) )*2*np.pi
    return freq, fkr, fki

def find_index( x, y ):
    for i in range(0,len(x),1):
        if x[i] == y:
            index = i
            break
    return index

# It first pad the data then interpolates.
def do_interpolate_pad(x0, y0, interpolation_times, extend_data_number):
    #### Padding - add zeros at the end.
    dx = x0[1] - x0[0]
    for i in range(extend_data_number):
        x0 = np.append(x0, x0[-1] + dx )
        y0 = np.append(y0, 0.0)
    #### Interpolation
    x1 = np.linspace(x0[0],x0[-1],interpolation_times*len(x0))    # interpolation_times* means twice the number of points.
    # y1 = interp1d(x0,y0,kind = 'cubic')
    y1 = Akima1DInterpolator(x0,y0 )
    return x1, y1(x1)

#Output folder
subprocess.call(['rm','-r','out/' ])
subprocess.call(['mkdir','out/' ])

# Read files
folder = '../../'
### pump
field0 = np.genfromtxt("../../field000.dat")
current0 = np.genfromtxt("../../equalt000.dat")
## Probe center
probe_center = np.genfromtxt("../../probe_center.dat")

######### Controls ####
time_length = 100 ## Fixed length of FT
interpolation_times = 1
pad_zeros = 200
py_fft = 0  ## Use cfft of py_fft
use_A = 0   ## Use A or E
#######################

####### To pick E or A (default E)
field_column = 2
if use_A == 1 :
    field_column = 1
#####

# Run loop over probes
center_index  = 0
#for index in [ '001']:
for index in [ '001', '002', '003', '004', '005', '006']:
    current_file =  ''.join( (folder,'equalt',index,'.dat') )     # File names generate.
    field_file =  ''.join( (folder,'field',index,'.dat') )
    field = np.genfromtxt( field_file )
    current = np.genfromtxt( current_file )
    print(current_file, field_file)
    
    #Find index to match the starting and end point of probe current to handle the unfinished runs.
    probe_current_length = len( current[:,0] )  #  Remember that the last data point of current is special because last point of the field is one time step more than the current field. 
    probe_current_end = current[ probe_current_length-1, 0 ]
    index_pump_current_end = find_index( current0[:,0], probe_current_end ) 
    probe_current_start = current[0, 0]
    index_pump_current_start = find_index( current0[:,0], probe_current_start ) 
    
    #Probe field, 1 for A field, 2 for E field.
    x0 = field[ index_pump_current_start:index_pump_current_end,0 ] - probe_center[ center_index, 1 ]
    y0 = field[ index_pump_current_start:index_pump_current_end, field_column] - field0[index_pump_current_start:index_pump_current_end, field_column ]
    #Probe current.
    x1 = current[0:probe_current_length-1, 0 ] -  probe_center[ center_index, 1 ]
    y1 = current[ 0:probe_current_length-1,1] - current0[ index_pump_current_start: index_pump_current_end , 1]
    
    print( "Format: [pp_start, pp_end, pump_start, pump_end]") 
    print( "Field raw: ", [field[0,0], field[-1,0],field0[0,0], field0[-1,0]]) 
    print( "Current raw: ", [current[0,0], current[-1,0], current0[0,0], current0[-1,0]]) 
    print( "Field chopped: ", [field[index_pump_current_start,0], field[index_pump_current_end,0],field0[index_pump_current_start,0], field0[index_pump_current_end,0]]) 
    print( "Current chopped: ", [ current[0,0], current[-1,0], current0[index_pump_current_start,0], current0[index_pump_current_end,0]] ) 
 
    ##### TO handle length of FT.
    dt = x0[1] - x0[0]
    length = min( len(x0), len(x1) ) - 2   # To handle incomplete runs.
    #probe_length_reference = x0[0] # Starting from the zero time.
    probe_length_reference = 0.0 #starting from the probe center.
    if ( x0[length] - probe_length_reference ) > time_length :
        index_length = np.where( (x0[:] > time_length + probe_length_reference - dt/2)  & (x0[:] < time_length + probe_length_reference + dt/2) ) 
        length = int(index_length[0])
    ##########################
    
    # Interpolation and padding. Check the input of do_interpolate_pad() above.
    x0,y0 = do_interpolate_pad( x0[0:length], y0[0:length], interpolation_times, pad_zeros )
    x1,y1 = do_interpolate_pad( x1[0:length], y1[0:length], interpolation_times, pad_zeros )
    ############
    
    py_fft = 0 
    if py_fft == 1 :
        # Using python fft.
        # Field 
        freq0, fkr0, fki0 = do_fft( x0, y0 )
        fk0 = np.vectorize(complex)( fkr0, fki0 )
        # Current
        freq1, fkr1, fki1 = do_fft( x1, y1)
        fk1 = np.vectorize(complex)( fkr1, fki1 )
    else:
        # Using c++
        # Field 
        imgzero = np.zeros( len(x0) ) 
        np.savetxt( 'data.dat', np.transpose( np.array([x0, y0, imgzero ]) ),delimiter = " ", fmt='%0.16f')
        subprocess.call(['bash','./subscripts/crun.sh' ])
        freq0, fkr0, fki0, fkabs0 = np.genfromtxt( 'out.dat', unpack=True )
        fk0 = np.vectorize(complex)( fkr0, fki0 )
        # Current
        np.savetxt( 'data.dat', np.transpose( np.array([x1, y1, imgzero ]) ),delimiter = " ", fmt='%0.16f')
        subprocess.call(['bash','./subscripts/crun.sh'])
        freq1, fkr1, fki1, fkabs1 = np.genfromtxt( 'out.dat', unpack=True)
        fk1 = np.vectorize(complex)( fkr1, fki1 )
    
    # Conductivity
    if use_A == 1:
        fk = fk1/(fk0*(freq0 + 0.0000+0.0000j )*1j)        # Adding a small constant to remove the zero division.
    else:
        fk = fk1/(fk0+ 0.0000+0.0000j)        # Adding a small constant to remove the zero division.

    fkr = np.real(fk)
    fki = np.imag(fk)
    freq = freq0

    # Plot data
    execfile('./subscripts/py_sub_plot.py')
    # save data
    imgzero = np.zeros( len(x0) ) 
    np.savetxt( ''.join( ('./out/E',index,'.dat') ), np.transpose( np.array([x0  , y0, imgzero]) ),delimiter = " ", fmt='%0.16f')
    np.savetxt( ''.join( ('./out/J',index,'.dat') ), np.transpose( np.array([x1 , y1, imgzero]) ),delimiter = " ", fmt='%0.16f')
    np.savetxt( ''.join( ('./out/cond',index,'.dat') ), np.transpose( np.array([freq, fkr, fki]) ), delimiter = " ", fmt='%0.16f' )
    np.savetxt( ''.join( ('./out/fft_E',index,'.dat') ), np.transpose( np.array([freq0, fkr0, fki0, np.abs(fk0) ]) ),delimiter = " ", fmt="%0.16f")
    np.savetxt( ''.join( ('./out/fft_J',index,'.dat') ), np.transpose( np.array([freq1, fkr1, fki1, np.abs(fk1) ]) ),delimiter = " ", fmt="%0.16f")
    #print(probe_center[ center_index, 1 ])
    center_index += 1
                
# Pump print
imgzero = np.zeros( len(field0[:,0]) ) 
np.savetxt( ''.join( ('./out/E','000','.dat') ), np.transpose( np.array([field0[:,0], field0[:,2], imgzero] ) ),delimiter = " ", fmt='%0.16f')
imgzero = np.zeros( len( current0[:,0] ) ) 
np.savetxt( ''.join( ('./out/J','000','.dat') ), np.transpose( np.array([current0[:,0], current0[:,1], imgzero ])),delimiter = " ", fmt='%0.16f')
