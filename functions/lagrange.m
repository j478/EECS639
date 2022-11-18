function [polynomial] = lagrange(orderedPairs)
%LAGRANGE takes a matrix of ordered pairs, and returns lagrange polynomial
%   Detailed explanation goes here

n = length(orderedPairs);
%take list of ordered pairs, and split them on ts and ys.
ts = orderedPairs(:, 1);
ys = orderedPairs(:, 2);
ws = coder.nullcopy(ts);

l(n) = "";
%construct l
for i=1:n
    if (ts(i) ~= 0)
        l(i) = "(t - " + ts(i) + ")";
    else
        l(i) = "t";
    end
end

%construct set of weights
for i=1:n
    mult = 1;
    for j=1:n
        if (i ~= j) %when i ~= j, multiply the the ts together
            mult = mult * (ts(i) - ts(j));
        end
    end
    ws(i) = 1 / mult;
end

%construct top of summation values
tops = coder.nullcopy(ts);
for i=1:n
    tops(i) = ws(i) * ys(i);
end

%construct final polynomial. Will change depending on how output is worked
%with later
lStr = "";
for i=1:n
    lStr = lStr + l(i);
end

summations = "";
for i=1:n
    if i ~= n
        summations = summations + "(" + sprintf("%.6f", tops(i)) + "/" + l(i) + ") + ";
    else
        summations = summations + "(" + sprintf("%.6f", tops(i)) + "/" + l(i) + ")";
    end
end

polynomial = lStr + "[" + summations + "]";

end