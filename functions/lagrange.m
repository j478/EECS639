function [polynomial] = lagrange(orderedPairs)
%LAGRANGE takes a matrix of ordered pairs, and returns lagrange polynomial
%   Detailed explanation goes here

%take list of ordered pairs, and split them on ts and ys.
n = length(orderedPairs);
ts = orderedPairs(:, 1);
ys = orderedPairs(:, 2);
lStr = "";
summations = "";

for i=1:n
    mult = 1;
    for j=1:n
        if (i ~= j) %when i ~= j, multiply the the ts together
            mult = mult * (ts(i) - ts(j));
        end
    end

    l = "";
    if (ts(i) ~= 0)
        l = "(t - " + ts(i) + ")";
    else
        l = "t";
    end
    lStr = lStr + l + "*";

    w = 1 / mult;
    top = w * ys(i);
    if i ~= n
        summations = summations + "(" + sprintf("%.6f", top) + "/" + l + ") + ";
    else
        summations = summations + "(" + sprintf("%.6f", top) + "/" + l + ")";
    end
end

polynomial = lStr + "(" + summations + ")";
end