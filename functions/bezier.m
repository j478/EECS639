function [coefficients] = bezier(n,endPoint,leftGuide,rightGuide)
%BEZIER Summary of this function goes here
%   INPUT: 
%       n: int, number of curves to be constructed
%       endPoint: nx2 matrix, coordinates from endpoints on original
%       function
%       leftGuide: (n-1)x2 matrix, coordinates from first derivative on
%       left derivative
%       rightGuide: (n-1)x2 matrix, coordinates from first derivative on
%       right guide
%   OUTPUT:
%       coefficients: nx8 matrix, coefficients for bezier curve [a1, a2,
%       a3, a4, b1, b2, b3, b4]
%   Detailed explanation goes here
t = linspace(0,1,n);
coefficients = zeros(n,8);
for i = 1:n-1
    coefficients(i,1) = endPoint(i,1);
    coefficients(i,2) = 3 * (leftGuide(i,1) - endPoint(i,1));
    coefficients(i,3) = 3 * (endPoint(i,1) + rightGuide(i,1) - 2 * leftGuide(i,1));
    coefficients(i,4) = endPoint((i+1),1) - endPoint(i,1) + 3 * leftGuide(i,1) - 3 * rightGuide(i,1);
    coefficients(i,5) = endPoint(i,2);
    coefficients(i,6) = 3 * (leftGuide(i,2) - endPoint(i,2));
    coefficients(i,7) = 3 * (endPoint(i,2) + rightGuide(i,2) - 2 * leftGuide(i,2));
    coefficients(i,8) = endPoint((i+1),2) - endPoint(i,2) + 3 * leftGuide(i,2) - 3 * rightGuide(i,2);

    funcx = @(t) coefficients(i,1) + coefficients(i,2)*t + coefficients(i,3)*t.^2+coefficients(i,4)*t.^3;
    funcy = @(t) coefficients(i,5) + coefficients(i,6)*t + coefficients(i,7)*t.^2+coefficients(i,8)*t.^3;
    x = funcx(t);
    y = funcy(t);
    plot(x,y);
    hold on;
    
end
hold off;
end

