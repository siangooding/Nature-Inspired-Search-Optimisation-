function [ geogConversion ] = convertGeog(cities)
%UNTITLED3 Summary of this function goes here
%   This will convert an array of random cities into geographical points

lengthCities=length(cities);

PI = 3.141592;

for i=1:lengthCities
  
    
    
    x = cities(1,i);
    y = cities(2,i);
    
    deg = round(x);
    min = x - deg;
    geogConversion(1,i)= PI * (deg + 5.0 * min /3.0) / 180.0;
    
     
    deg = round(y);
    min = y - deg;
    geogConversion(2,i)= PI * (deg + 5.0 * min /3.0) / 180.0;
    
    
end
     
   
    

end

