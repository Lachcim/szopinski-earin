% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function picks two parents using the roulette wheel method.

function parents = roulette(population, fitness)
    fitnesses = zeros(size(population, 1), 1);

    for i = 1:size(fitnesses)
        fitnesses(i) = fitness(population(i, :));
    end

    slices = fitnesses - min(fitnesses);
    slices = slices ./ sum(slices);

    parents = zeros(2, size(population, 2));

    for parent = 1:2
        threshold = rand();
        partialSum = 0;

        for i = 1:size(slices)
            partialSum = partialSum + slices(i);

            if partialSum >= threshold
                parents(parent, :) = population(i, :);
                break
            end
        end
    end
end
