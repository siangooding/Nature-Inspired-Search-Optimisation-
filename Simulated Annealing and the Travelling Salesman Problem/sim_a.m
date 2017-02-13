function [best_distance] = sim_a(inputcities)

num_cities = length(inputcities);

% Generate a random initial solution

best_route = randperm(num_cities);
best_cities_coordinates = inputcities(:,best_route);
best_cities_coordinates = convertGeog(best_cities_coordinates);
best_distance = geogDistance(best_cities_coordinates);

%set t = 0 and then increment at end of loop
%iteration is termination criteria
t=0;
iteration=1000;
T=100;
while (t<iteration)
   
    for i = 2 : num_cities-1
        for k = i+1 : num_cities - 1
        
            % Execute the swapping function
            newroute = twooptSwap(best_route, i, k);
            new_cities_coordinates = inputcities(:,newroute);
            new_cities_coordinates = convertGeog(new_cities_coordinates);
            new_distance = geogDistance(new_cities_coordinates);
            
            if  new_distance < best_distance || (rand()<(min(1,(exp(-(new_distance-best_distance)/T)))))
                %here we accept a worse route when random number generated
                %less than sim function
                
                best_distance = new_distance;
                best_route = newroute;
          
               
                break;
            end
        end
    end
    
    t=1+t;
    T=T*0.999;
end
end

%% Swap two cities
function new_route = twooptSwap(route, i, k)
temp = route(i);
route(i) = route(k);
route(k) = temp;
new_route = route;
end

