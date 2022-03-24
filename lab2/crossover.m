% EARIN LABORATORY 2
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file contains the crossover function.

function output = crossover(children, d, prob)
    output = children;

    for dimension = 1:size(children, 2)
        % skip with probability (1 - prob)
        if rand() >= prob; continue; end

        % get bit swap mask
        maskSize = randi([0, d + 1]);
        mask = uint64(2^(d + 1) - 1);
        mask = bitshift(mask, -maskSize);
        mask = typecast(mask, 'int64');

        % get bit grafts
        top = bitand(children(1, dimension), mask);
        bottom = bitand(children(2, dimension), mask);

        % zero bits in grafting area
        children(1, dimension) = bitand(children(1, dimension), bitcmp(mask));
        children(2, dimension) = bitand(children(2, dimension), bitcmp(mask));

        % implant bits to grafting area
        children(1, dimension) = bitor(children(1, dimension), bottom);
        children(2, dimension) = bitor(children(2, dimension), top);

        % adjust sign bits after graft
        output(1, dimension) = bitshift(bitshift(children(1, dimension), 63 - d), d - 63);
        output(2, dimension) = bitshift(bitshift(children(2, dimension), 63 - d), d - 63);
    end
end
