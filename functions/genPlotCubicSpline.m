function [] = genPlotCubicSpline(coeffs, pairs)
%GENPLOTCUBICSPLINE takes a vector of coefficents corresponding to a system of cubic equations and order pairs, and plots them.
%   plots the original points, as well as plots the corresponing functions that connnect them.
hold on;

n = length(pairs);
ts = pairs(:,1);

%plot given points
for i=1:length(pairs)
    plot(pairs(i,1), pairs(i,2), "*r");
end

%The idea here is to generate an inline function for each of the cuibc spline equations. This is accomplished by taking values from
%`coeffs` by 4 (since there are always four coefficents), and turning them into a string along with the variable 't' in order to generate
%the correct funciton. A vector consisting of values between the current points are then applied to the function, and the corresponding values are
%then plotted together. This is done for every interval in the ordered pairs.
coeffBase = 1;
for i=1:n-1
    currPolyString = coeffs(coeffBase+3) + "*(t.^3) + " + coeffs(coeffBase+2) + "*(t.^2) + " + coeffs(coeffBase+1) + "*(t) + " + coeffs(coeffBase);
    currPoly = inline(currPolyString, 't');

    xs = ts(i):.01:ts(i+1);
    ys = xs;
    for j=1:length(xs)
        ys(j) = currPoly(xs(j));
    end
    plot(xs,ys);

    coeffBase = coeffBase + 4;
end
hold off
    
end