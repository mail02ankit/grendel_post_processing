{count=count+1;}{sum= sum+ $j;}
BEGIN{max=-100}{if($j>max){max=$j;};}
BEGIN{min=100}{if($j<min){min=$j;};}
END{print min,sum/count,max;}
