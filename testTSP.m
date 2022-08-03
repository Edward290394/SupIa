
% valores de entrada 
k=[  0   136  47  101  52  99 ;
     136  0   89  237  188  235 ;
     47  89  0   148  99  146 ;
     101  237  148  0   116   176 ;
     52  188  99  116   0   61 ;
     99  235  146  176  61  0  ];
 
 size=6;

 [x,c]=tsp(1000,k,size);

    sigma=0;
    for i=1:length(c)-1
      sigma=sigma+k(c(i),c(i+1));
    end
    disp('camino optimo')
    disp(c);
    disp('Peso Del Camino Optimo');
    disp(sigma)
   