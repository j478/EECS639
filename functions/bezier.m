function [coefficients] = bezier(n,endPoint,leftGuide,rightGuide)
%BEZIER Summary of this function goes here
%   Detailed explanation goes here
coefficients = zeros(n,8);
for i = 1:n
    coefficients(i,1) = endPoint(1,i);
    coefficients(i,2) = 3 * (leftGuide(1,i) - endPoint(1,i));
    coefficients(i,3) = 3 * (endPoint(1,i) + rightGuide(1,i) - 2 * leftGuide(1,i));
    coefficients(i,4) = endPoint(1,(i+1)) - endPoint(1,i) + 3 * leftGuide(1,i) - 3 * rightGuide(1,i);
    coefficients(i,5) = endPoint(2,i);
    coefficients(i,6) = 3 * (leftGuide(2,i) - endPoint(2,i));
    coefficients(i,7) = 3 * (endPoint(2,i) + rightGuide(2,i) - 2 * leftGuide(2,i));
    coefficients(i,8) = endPoint(1,(i+1)) - endPoint(1,i) + 3 * leftGuide(1,i) - 3 * rightGuide(1,i);
%coefficients = (n, size(endPoint), size(leftGuide), size(rightGuide))
end

