% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file implements Newton's method.

function xAsterisk = newton(func, startingPoint, stopCond, stopCondArg)
    stepCount = 0;
    startTime = clock();
    
    xAsterisk = startingPoint;
    y = func(startingPoint);

    while 1
        if stopCond == StopCondition.DesiredValue && y <= stopCondArg; break; end

        grad1 = gradient(func, xAsterisk, 1);
        grad2 = gradient(func, xAsterisk, 2);
        xAsterisk = xAsterisk - (grad1 ./ grad2)';
        y = func(xAsterisk);

        stepCount = stepCount + 1;
        if stopCond == StopCondition.MaxIterations && stepCount == stopCondArg; break; end
        if stopCond == StopCondition.MaxTime && etime(clock(), startTime) >= stopCondArg; break; end
    end
end
