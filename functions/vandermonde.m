function [polynomial] = vandermonde(orderedPairs)
%VandermondeMATRIX Summary of this function goes here
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
display(cond(A));
coeffs = lsqr(A, ys, 1e-10, 500);

%Horner's nested eval
polyString = "" + coeffs(1);
endParens(n-2) = "";
for i=1:n-2
    polyString = polyString + " + t*(" + coeffs(i+1);
    endParens(i) = ")";
end
polyString = polyString + " + t*" + coeffs(i+2) + sprintf('%s', endParens);

polynomial = inline(polyString, "t");
end

