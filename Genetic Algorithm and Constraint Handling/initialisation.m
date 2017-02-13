function [population] = initialisation(matrix_a, popSize)

population = [];
% set a for loop which will fill the population 
for f=1:popSize

% number of rows
m = size(matrix_a,1);
% number of columns
n = size(matrix_a, 2);


% Initiate I to indicate all rows are not cover (I_i = 0)
I = zeros(1,m);
checked= zeros(1,m);
% x is the solution, i.e., x_i=1 means the i_th column is selcted, x_i=0,
% otherwise
x = zeros(1,n);

% It terminates when all rows are covered
while sum(checked)<m     
    % Find out which rows have not been covered
    uncovered_rows_idx = find(I==0);  
      % randomly select an uncovered row i
    i = uncovered_rows_idx(randi(length(uncovered_rows_idx)));
    checked(1,i)=1;
    % alpha_i is the indices of columns that cover row i
    alpha_i = find(matrix_a(i,:)==1);
    %  select column j \in \alpha_i randomly if not covered row already
   
    valid=[];
    for i=1:length(alpha_i)
                check = sum(matrix_a(:,alpha_i(i))'.*I);
          if check==0
              valid= [valid alpha_i(i)];   
         end                
    end
    
    if ~isempty(valid)
     lengthV = length(valid);
     random = randi(lengthV);

    
     x(1,valid(random)) = 1;
     % Set I to include the rows covered by column j
      I(1, matrix_a(:,valid(random))==1) = 1;
      checked(1, matrix_a(:,valid(random))==1) = 1;
      
    end
    
end  
population = [population;x];
end


end



