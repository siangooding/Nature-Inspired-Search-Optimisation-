function d = geogDistance(cities)

d = 0;
   RRR = 6378.388;

for n = 1 : length(cities)
    if n < length(cities)
          
     
        q1 = cos(cities(2,n) - cities(2, n+1));
        q2 = cos(cities(1,n) - cities(1, n+1));
        q3 = cos(cities(1,n) + cities(1, n+1));
        dij = (round( RRR * acos( 0.5*((1.0+q1)*q2 - (1.0-q1)*q3) ) + 1.0));
        
        d = d + dij;
        
       
    else    
              
         
        q1 = cos(cities(2,n) - cities(2,1));
        q2 = cos(cities(1,n) - cities(1,1));
        q3 = cos(cities(1,n) + cities(1,1));
        dij = (round( RRR * acos( 0.5*((1.0+q1)*q2 - (1.0-q1)*q3) ) + 1.0));
        
        d = d + dij;
        
        
    end
end

