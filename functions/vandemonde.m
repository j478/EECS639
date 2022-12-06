function [polynomial] = vandemonde(orderedPairs)
%VANDEMONDEMATRIX Summary of this function goes here
%   Detailed explanation goes here
n = length(orderedPairs);
ts = orderedPairs(:,1);
ys = orderedPairs(:,2);

A = zeros(n);
for i=1:n
    for j=1:n
        if j == 1
            A(i,j) = 1;
        else
            A(i,j) = ts(i).^(j-1);
        end
    end
end

%must be lsqr becuase matrix here is nearly singular
coeffs = lsqr(A, ys, 1e-10, 500);

polyString = "" + coeffs(1);
for i=1:n-1
    polyString = polyString + " + (" + coeffs(i+1) + "*(t.^" + i + "))";
end

polynomial = inline(polyString, "t");
end

