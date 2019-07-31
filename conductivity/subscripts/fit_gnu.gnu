set fit quiet
f(t)=a*exp(-g*t)+b
fit [70:90][]f(x-70) 'data.dat' u 1:2 via a,b,g
