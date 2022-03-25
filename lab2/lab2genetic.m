% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file contains the input prompt and output analysis code.

% collect function parameters
while 1
    c = input('Specify scalar c: ');
    if isscalar(c); break; end
end

while 1
    b = input('Specify vector b: ');
    if isvector(b)
        if size(b, 1) == 1
            b = b';
        end
        break
    end
end

lenB = num2str(length(b));
while 1
    A = input(strcat("Specify ", lenB, "x", lenB, " matrix A: "));
    if all(size(A) == [length(b), length(b)])
        break
    end
end

% get problem dimensionality
while 1
    dim = input('Specify dimensionality: ');
    if dim > 0 && dim == round(dim); break; end
end

% get the range of searched integers
while 1
    d = input('Specify range (parameter d): ');
    if d >= 1; break; end
end

% get the population size
while 1
    popSize = input('Specify population size: ');
    if popSize >= 1 && popSize == round(popSize); break; end
end

% get the crossover probability
while 1
    crossoverProb = input('Specify crossover probability: ');
    if crossoverProb >= 0 && crossoverProb <= 1; break; end
end

% get the mutation probability
while 1
    mutationProb = input('Specify mutation probability: ');
    if mutationProb >= 0 && mutationProb <= 1; break; end
end

% get the number of iterations
while 1
    maxIter = input('Specify the number of iterations: ');
    if maxIter >= 1 && maxIter == round(maxIter); break; end
end

% run the genetic algorithm
fitness = @(x) x' * A * x + b' * x + c;
results = genetic(dim, d, fitness, popSize, crossoverProb, mutationProb, maxIter);

disp(results);
