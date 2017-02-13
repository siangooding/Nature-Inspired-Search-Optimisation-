function [S] = HeuristicImpOp( matrix_a, S, column_cost)
%HEURISTICIMPOP Summary of this function goes here
%   Detailed explanation goes here




%Initialising w
W=S*matrix_a';
%Initialising T

T=find(S==1);

%DROP
while length(T)>0
 TSize = length(T);
random =(randi(TSize));
indicies = T(random);
T(random)=[];


answer = matrix_a(:,indicies);
   % we go through and see if any all of the variables are >2
  for i=1:length(answer)
      if answer(i)==1
      if W(i)>=2
          S(random)=0;
          W(i)=W(i)-1;
         
      end
      end
  end    
end


U=find(W)==0;

uncovered_rows_idx=U;
%ADD Procedure

while length(uncovered_rows_idx)>0
  % randomly select an uncovered row i
    random=(randi(length(uncovered_rows_idx)));
    i = uncovered_rows_idx(random);
    uncovered_rows_idx(random)=[];
    % alpha_i is the indices of columns that cover row i
    alpha_i = find(matrix_a(i,:)==1);
    %  select column j \in \alpha_i which covers row i with minimum cost
    [mincost, idx] = min(column_cost(alpha_i));
    % However, there are multiple column with the same minimum cost
    % If we use min function in matlab, we will always selet the first column with the minimum cost
    idx_array = find(column_cost(alpha_i) == mincost);
    num_same_mincost = length(idx_array);
    % To prevent this problem, we randomly select one column if there are multiple column with the same minimum cost
    if num_same_mincost > 1
      idx = idx_array(randi(num_same_mincost));
    end
    j = alpha_i(idx);
    % Set column j as part of the solution
    S(1,j) = 1;
    % Remove from uncovrered
    
        
   %here we incremenet w to show it is represented
    W(j)=W(j)+1;
    
    
end
    
   
    

end
