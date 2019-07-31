awk '{if ($1> 0.001 && $1 <1.7) {print $1,$3}}' cond000.dat >data.dat
