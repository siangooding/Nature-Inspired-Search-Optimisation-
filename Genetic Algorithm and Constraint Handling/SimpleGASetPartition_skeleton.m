function [best_fitness,best_ind] = SimpleGASetPartition(set_matrix, column_cost, MaxIter)
%Input Arguments:
%   fname       - the name of the evaluation .m function
%   NDim        - dimension of the evalation function
%   MaxIter     - maximum iteration
% Simple GA for Set Partitioning (Air Crew Scheduling) problem
% Copyright (C) 2014-2016 Shan He, the University of Birmingham
%% Parameters
column_size = size(set_matrix,2)
num_bit = column_size;
% Let's say we want 100 individuals
PopSize = 200;
max_iter = MaxIter;
termination_flag = false;
best_fitness = [];
avg_fitness = [];
t = 0;
% Generate initial solution
%genotypes = rand(PopSize,num_bit)>(10/num_bit);
%% Generate init population
genotypes = initialisation(set_matrix,PopSize);
fitness = [];
%% Evaluate phenotypes
temp1 = genotypes .* repmat(column_cost, PopSize, 1);
fitness = sum(temp1');
temp2 =  (set_matrix*genotypes')';
constraint = sum(((temp2-1).^2)');

%[fitness, sorted_idx] = sort(fitness);
[fitness,sorted_idx] = stochastic_ranking_sort(fitness, constraint);
genotypes = genotypes(sorted_idx,:);
while termination_flag == false
    
    
    %% selection
    num_parent = PopSize * 0.3;
    parents = genotypes(1:num_parent,:);
    offerspring = parents;
    
    %% apply crossover
    % Randomly select two individuals as parents
    idx  = randi([1 num_parent],2, 1);
    % Randomly select a bit as cross point
    cross_point =  randi([1 num_bit]);
    % Swap the bits beyond the cross point
    offerspring(idx(1,:), cross_point+1:end) = parents(idx(2,:), cross_point+1:end);
    offerspring(idx(2,:), cross_point+1:end) = parents(idx(1,:), cross_point+1:end);
    
    
    %% apply mutation
    for j=1:num_parent
        % Randomly select a bit
        mutation_bit = randi([1 num_bit]);
        % flip it
        offerspring(j, mutation_bit) = ~parents(j, mutation_bit);
    end
    
    for i = 1: size(offerspring)
        offerspring(i) = HeuristicImpOp(set_matrix,offerspring(i), column_cost);
    end
    
    %% Evaluation fitness
    genotypes = [genotypes; offerspring];
    size_pop = size(genotypes,1);
    temp1 = genotypes .* repmat(column_cost, size_pop, 1);
    fitness = sum(temp1');
    temp2 =  (set_matrix*genotypes')';
    constraint = sum(((temp2-1).^2)');
    fitness = fitness + 10000*constraint;
    
  
    %% Replace the worst individuals
    [fitness, sorted_idx] = stochastic_ranking_sort(fitness, constraint);
    genotypes = genotypes(sorted_idx,:);
    genotypes = genotypes(1:PopSize,:);
    
    
    
    %% Results statistics
    best_fitness = [best_fitness fitness(1)];
    avg_fitness = [avg_fitness mean(fitness)];
   
    plot(avg_fitness(1:t),'r--');xlabel('iteration'); ylabel('Average f(x)');
    %text(0.5,0.95,['Best = ', num2str(fitness(1))],'Units','normalized');
    drawnow;
    
    %% Terminate?
    t=t+1;
    if(t>max_iter)
        termination_flag = true;
    end
    
    
    
end
best_ind = genotypes(1,:)
min_cost = sum(column_cost.*best_ind)
temp2 =  (set_matrix*best_ind')';
best_constraint = sum(((temp2-1).^2)');
disp(['The minimum cost found by the GA is laala: ', num2str(min_cost)]);
disp(['The sum of volations of the constraints is: ', num2str(best_constraint)]);

     
end