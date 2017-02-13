function [child1, child2] = crossover(parent1, parent2)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

  lengthP1 = length(parent1);
    
  crossoverpoint = randi(lengthP1);
  
  child1=[];
  child2=[];
  
  for i=1:crossoverpoint
      child1(i)= parent1(i);
      
  
  
      child2(i)= parent2(i);
      
      
  end
  
  parent1end = parent1(crossoverpoint:lengthP1);
  parent2end = parent2(crossoverpoint:lengthP1);
  
  child1 =strcat(child1,parent2end);
  child2 =strcat(child2,parent1end);
  

end

