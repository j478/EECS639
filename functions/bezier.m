function [coefficients] = bezier(n,endPoint,leftGuide,rightGuide)
%BEZIER Summary of this function goes here
%   INPUT: 
%       n: int, number of points
%       endPoint: 2xn matrix, coordinates from endpoints on original
%       function
%       leftGuide: 2x(n-1) matrix, coordinates from first derivative on
%       left derivative
%       rightGuide: 2x(n-1) matrix, coordinates from first derivative on
%       right guide
%   OUTPUT:
%       coefficients: nx8 matrix, coefficients for bezier curve [a1, a2,
%       a3, a4, b1, b2, b3, b4]
%   Detailed explanation goes here
t = linspace(0,1,20);
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

    funcx = @(t) coefficients(i,1) + coefficients(i,2)*t + coefficients(i,3)*t.^2+coefficients(i,4)*t.^3;
    funcy = @(t) coefficients(i,5) + coefficients(i,6)*t + coefficients(i,7)*t.^2+coefficients(i,8)*t.^3;
    x = funcx(t);
    y = funcy(t);
    plot(x,y);
    hold on;
    
end
hold off;
end

