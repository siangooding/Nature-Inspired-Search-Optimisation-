function total_distance = randomsearch(inputcities,max_iter)
% randomsearch

% Randomised search algorithm for TSP problem
%The input arguments are
% inputcities         - The cordinates for n cities are represented as 2
%                       rows and n columns and is passed as an argument for
%                       the randomised search algorithm.
% max_iter           - max_iter is the stopping criteria  

global iterations;
% Initialize the iteration number.
iterations = 1;

num_cities = length(inputcities);

% Objective function: the total distance for the routes.
inputcities = convertGeog(inputcities);
previous_distance = geogDistance(inputcities);
best = previous_distance; 
results = zeros(max_iter,1);
results(1) = previous_distance;
plot(results);
while iterations < max_iter
    random_solution = randperm(num_cities);
    temp_cities = inputcities(:, random_solution);
    current_distance = geogDistance(temp_cities);
    if current_distance < previous_distance
        if current_distance < best
            best = current_distance;
        end
        inputcities = temp_cities;
        previous_distance = current_distance;
    end
    iterations = iterations + 1;
    results(iterations) = current_distance;
    
    %plot(results(1:iterations),'r--');xlabel('iteration'); ylabel('f(x)');
   % text(0.5,0.95,['Best = ', num2str(current_distance)],'Units','normalized');
   % drawnow;
    
end

total_distance = best;
