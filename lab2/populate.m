% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function generates the initial population.

function population = populate(dim, d, popSize)
    rand32 = @() randi([0 intmax('uint32')], 'uint32');
    rand64 = @(x) typecast([rand32() rand32()], 'int64');

    population = arrayfun(rand64, zeros(popSize, dim));

    population = bitshift(population, 63 - d);
    population = bitshift(population, d - 63);
end
