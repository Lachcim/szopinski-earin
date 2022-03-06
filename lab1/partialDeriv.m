% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This function calulates the n-th partial derivative with respect to the p-th argument of func at x.

function y = partialDeriv(func, p, x, n)
    % base case: zeroth derivative
    if n == 0
        y = func(x);
        return
    end
    
    % get delta as square root of machine epsilon
    delta = sqrt(eps) * func(x);

    % get x +- delta
    afterX = x;
    afterX(p) = x(p) + delta;
    beforeX = x;
    beforeX(p) = x(p) - delta;

    % recurse to find the nth derivative
    y = (partialDeriv(func, p, afterX, n - 1) - partialDeriv(func, p, beforeX, n - 1)) / (2 * delta);
end
