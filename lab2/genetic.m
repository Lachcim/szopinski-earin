% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file contains the implementation of the genetic algorithm.

function population = genetic(dim, d, fitness, popSize, crossoverProb, mutationProb, maxIter)
    population = populate(dim, d, popSize);

    for i = 1:maxIter
        % pick two parents and spawn two identical children
        children = roulette(population, fitness);

        % simulate crossover and mutation in children
        children = crossover(children, d, crossoverProb);
        children = mutate(children, d, mutationProb);

        % cycle through population to achieve FIFO
        child1index = mod((i - 1) * 2, popSize) + 1;
        child2index = mod((i - 1) * 2 + 1, popSize) + 1;

        population(child1index, :) = children(1, :);
        population(child2index, :) = children(2, :);
    end
end
