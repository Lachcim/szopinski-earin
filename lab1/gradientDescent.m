% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file implements the gradient descent method.

function xAsterisk = gradientDescent(func, startingPoint, stopCond, stopCondArg)
    stepCount = 0;
    startTime = clock();

    nanColumn = NaN * ones(length(startingPoint), 1);
    prevX = [nanColumn, startingPoint];
    prevGrad = [nanColumn, gradient(func, startingPoint, 1)];

    while 1
        if stopCond == StopCondition.DesiredValue && y <= stopCondArg; break; end

        % apply gradient descent formula
        xAsterisk = prevX(:, 2) - 0.001 * prevGrad(:, 2);

        stepCount = stepCount + 1;
        prevX = [prevX(:, 2), xAsterisk];
        prevGrad = [prevGrad(:, 2), gradient(func, xAsterisk, 1)];

        if stopCond == StopCondition.MaxIterations && stepCount == stopCondArg; break; end
        if stopCond == StopCondition.MaxTime && etime(clock(), startTime) >= stopCondArg; break; end
    end
end
