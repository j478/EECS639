function [polynomial] = newton(orderedPairs)
%NEWTON Summary of this function goes here
%   Detailed explanation goes here
n = length(orderedPairs);
if n < 1
    polynomial = "";
    return;
end

%take list of ordered pairs, and split them on ts and ys.
ts = orderedPairs(:, 1);
ys = orderedPairs(:, 2);

%construct basis functions
pis(n-1) = "";
if ts(1) ~= 0
    pis(1) = "(t - " + ts(1) + ")";
else
    pis(1) = "t";
end

for i=2:n-1
    if (ts(i) ~= 0)
        pis(i) = pis(i-1) + "*(t - " + ts(i) + ")";
    else
        pis(i) = pis(i-1) + "*t";
    end
end

%construct matrix with basis functions
A = zeros(n);
for i=1:n
    for j=1:n
        if j == 1
            A(i,j) = 1;
        elseif i < j
            A(i,j) = 0;
        else
            tmp = inline(pis(j-1), 't'); %converts string in pis to executable function
            A(i,j) = tmp(ts(i));
        end
    end
end

%solve for xs
xs  = A\ys;

%construct polynomial
tmp = xs(1) + " + ";
for i=2:n
    if i ~= n
        tmp = tmp + xs(i) + pis(i-1) + " + ";
    else
        tmp = tmp + xs(i) + pis(i-1);
    end
end
polynomial = tmp;

end



