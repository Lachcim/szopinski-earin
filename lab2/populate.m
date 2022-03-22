% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function generates the initial population.

function population = populate(dim, d, popSize)
    rand32 = @() randi([0 intmax('uint32')], 'uint32');
    rand64 = @(x) typecast([rand32() rand32()], 'uint64');

    population = arrayfun(rand64, zeros(popSize, dim));

    bitmask = bitshift(intmax('uint64'), d - 63);
    population = arrayfun(@(x) typecast(bitand(x, bitmask), 'int64'), population);
end
