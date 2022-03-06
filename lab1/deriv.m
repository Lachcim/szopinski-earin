% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function calulates the n-th derivative of func at x.

function y = deriv(func, x, n)
    % base case: zeroth derivative
    if n == 0
        y = func(x);
        return
    end
    
    % recurse to find the nth derivative
    step = sqrt(eps);
    y = (deriv(func, x + step, n - 1) - deriv(func, x - step, n - 1)) / (2 * step);
end
