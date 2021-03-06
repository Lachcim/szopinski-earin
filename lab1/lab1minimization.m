% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin
% This file contains the input prompt and output analysis code.

% prompt for minimization algorithm
fprintf([ ...
    'Available minimization algorithms:\n', ...
    '\tN) Newton''s method\n', ...
    '\tG) Gradient descent\n', ...
]);
algorithm = '';
while ~strcmp(algorithm, 'N') && ~strcmp(algorithm, 'G')
    algorithm = input('Specify minimization algorithm [N/G]: ', 's');
end

% prompt for mathematical function
fprintf([ ...
    'Available function forms:\n', ...
    '\tF(x) = ax^3 + bx^2 + cx + d\n', ...
    '\tG(x) = c + b^T x + x^T A x\n', ...
]);
functionForm = '';
while ~strcmp(functionForm, 'F') && ~strcmp(functionForm, 'G')
    functionForm = input('Specify function form [F/G]: ', 's');
end

% prompt for function parameters
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

    % define the mathematical function
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

    % define the mathematical function
    mainFunc = @(x) c + b' * x + x' * A * x;
end

% prompt for stopping condition
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

% prompt for stopping condition argument
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

% prompt for initial value form
fprintf([ ...
    'Available initial value forms:\n', ...
    '\t1. Initial value given explicitly\n', ...
    '\t2. Initial value drawn from range\n', ...
]);
initialValueChoice = 0;
while ~isscalar(initialValueChoice) || ~ismember(initialValueChoice, [1 2])
    initialValueChoice = input('Choose initial value form [1/2]: ');
end

% prompt for initial value or range of random values
if initialValueChoice == 1
    initialValueLength = 1;
    initialValueDescription = 'scalar';
    
    if functionForm == 'G'
        initialValueLength = length(b);
        if initialValueLength ~= 1
            initialValueDescription = strcat("vector of length ", num2str(initialValueLength));
        end
    end

    while 1
        initialValue = input(strcat("Initial value (", initialValueDescription, "): "));
        if isvector(initialValue) && length(initialValue) == initialValueLength
            break
        end
    end

    if size(initialValue, 1) == 1
        initialValue = initialValue';
    end
else
    initialValueRange = [1, 0];
    while ~isvector(initialValueRange) || length(initialValueRange) ~= 2 || initialValueRange(1) > initialValueRange(2)
        initialValueRange = input('Range of values to choose from (2-element vector): ');
    end
end

% prompt for batch mode
repeatCount = 0;
while ~isscalar(repeatCount) || floor(repeatCount) ~= repeatCount || repeatCount <= 0
    repeatCount = input('How many times to perform the calculation: ');
end

% define lambda with established parameters
if algorithm == 'N'
    minimize = @(startingPoint) newton(mainFunc, startingPoint, stopCond, stopCondArg);
else
    minimize = @(startingPoint) gradientDescent(mainFunc, startingPoint, stopCond, stopCondArg);
end

% establish length of argument to mathematical function
argLength = 1;
if functionForm == 'G'
    argLength = length(b);
end

results = zeros(argLength, repeatCount);
for i = 1:repeatCount
    % generate random initial value or use prefefined one
    if initialValueChoice == 2
        startingPoint = rand(argLength, 1) .* (initialValueRange(2) - initialValueRange(1)) + initialValueRange(1);
    else
        startingPoint = initialValue;
    end

    % record the result
    results(:, i) = minimize(startingPoint);
end

if repeatCount > 1
    fprintf("Mean result: %f\n", mean(results));
    fprintf("Standard deviation: %f\n", std(results));
else
    fprintf("Result: %f\n", results);
end
