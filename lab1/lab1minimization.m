% EARIN LABORATORY 1
% MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
% https://github.com/Lachcim/szopinski-earin

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
