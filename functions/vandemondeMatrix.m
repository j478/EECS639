function [vandemonde] = vandemondeMatrix(orderedPairs)
%VANDEMONDEMATRIX Summary of this function goes here
%   Detailed explanation goes here
n = length(orderedPairs);
ts = orderedPairs(:,1);
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

vandemonde = A;
end

