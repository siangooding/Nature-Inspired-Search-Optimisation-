function [fitness] = calculatefitness(individual)


%take binary string as input
%cost and constraint matrix and penality factors 
%output transform function
X=0;
totalCost=0;
indlength = length(individual);

    for i=1:indlength
        %works out total cost of journey
        if (individual(i)==1)
            totalCost = totalCost + column_cost(i); 
        % make a matrix of all the selected routes feasibility
            A = [A, set_matrix(:,individual(i))]; 
        end
      
    end
    
          
        for j=1:17
            for i=1:indlength
                if(individual(i)=1)
                    sum(A(j,:)~=0);
                end
            sum= sum+0;
                
            end
            
        end
    
    
 
fitness = totalCost;

