% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function calulates the n-th gradient of func at x.

function y = gradient(func, x, n)
    y = zeros(length(x), 1);
    
    for p = 1:length(x)
        y(p) = partialDeriv(func, p, x, n);
    end
end
