% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin

fprintf([ ...
    'Available minimization algorithms:\n', ...
    '\tN) Newton''s method\n', ...
    '\tG) Gradient descent\n', ...
]);
algorithm = '';
while ~strcmp(algorithm, 'N') && ~strcmp(algorithm, 'G')
    algorithm = input('Specify minimization algorithm [N/G]: ', 's');
end

fprintf([ ...
    'Available function forms:\n', ...
    '\tF(x) = ax^3 + bx^2 + cx + d\n', ...
    '\tG(x) = c + b^T x + x^T A x\n', ...
]);
functionForm = '';
while ~strcmp(functionForm, 'F') && ~strcmp(functionForm, 'G')
    functionForm = input('Specify function form [F/G]: ', 's');
end

if functionForm == 'F'
    fParams = zeros(1, 4);
    fParamNames = 'abcd';

    for i = 1:4
        while 1
            newParam = input(strcat("Specify scalar ", fParamNames(i), ": "));
            if isscalar(newParam)
                fParams(i) = newParam;
                break
            end
        end
    end

    mainFunc = @(x) fParams(1) * x^3 + fParams(2) * x^2 + fParams(3) * x + fParams(4);
else
    while 1
        c = input('Specify scalar c: ');
        if isscalar(c); break; end
    end

    while 1
        b = input('Specify vector b: ');
        if isvector(b)
            if size(b, 1) == 1
                b = b';
            end
            break
        end
    end

    lenB = num2str(length(b));
    while 1
        A = input(strcat("Specify ", lenB, "x", lenB, " matrix A: "));
        if all(size(A) == [length(b), length(b)])
            break
        end
    end

    mainFunc = @(x) c + b' * x + x' * A * x;
end

fprintf([ ...
    'Available stopping conditions:\n', ...
    '\t1. Max iterations\n', ...
    '\t2. Desired value\n', ...
    '\t3. Max computation time\n' ...
]);
stopConds = [StopCondition.MaxIterations, StopCondition.DesiredValue, StopCondition.MaxTime];
stopCondChoice = 0;
while 1
    stopCondChoice = input('Choose stopping condition [1/2/3]: ');
    if isscalar(stopCondChoice) && ismember(stopCondChoice, [1 2 3])
        stopCond = stopConds(stopCondChoice);
        break
    end
end

if stopCond == StopCondition.MaxIterations
    stopCondArg = 0;
    while ~isscalar(stopCondArg) || floor(stopCondArg) ~= stopCondArg || stopCondArg <= 0
        stopCondArg = input('Max iteration count: ');
    end
elseif stopCond == StopCondition.DesiredValue
    stopCondArg = [0, 0];
    while ~isscalar(stopCondArg)
        stopCondArg = input('Desired value: ');
    end
else
    stopCondArg = 0;
    while ~isscalar(stopCondArg) || stopCondArg <= 0
        stopCondArg = input('Max computation time in seconds: ');
    end
end

if algorithm == 'N'
    minimize = @(startingPoint) newton(mainFunc, startingPoint, stopCond, stopCondArg);
else
    minimize = @(startingPoint) gradientDescent(mainFunc, startingPoint, stopCond, stopCondArg);
end
