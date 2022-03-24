% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file contains the mutation function.

function output = mutate(children, d, prob)
    output = children;

    for child = 1:2
        for dimension = 1:size(children, 2)
            % skip with probability (1 - prob)
            if rand() >= prob; continue; end

            % get mutator
            mutator = uint64(1);
            mutator = bitshift(mutator, randi([0, d]));
            mutator = typecast(mutator, 'int64');

            % mutate
            children(child, dimension) = bitxor(children(child, dimension), mutator);

            % adjust sign bits after graft
            output(child, dimension) = bitshift(bitshift(children(child, dimension), 63 - d), d - 63);
        end
    end
end
