function [coeffs] = naturalSpline(orderedPairs)
%NATURALSPLINE takes a matrix of ordered pairs, and returns lagrange polynomial
%   Detailed explanation goes here
cubicT = @(t) [1 t t.^2 t.^3];
firstDerT = @(t) [1 2*t 3*t.^2];
secondDerT = @(t) [2 6*t];

n = length(orderedPairs);
if n < 1
    coeffs = "";
    return;
end

%take list of ordered pairs, and split them on ts and ys.
ts = orderedPairs(:,1);
ys = orderedPairs(:,2);
modifiedYs = zeros((4*(n-1)),1);
row = 1;
for i=1:n-1
    modifiedYs(row) = ys(i);
    modifiedYs(row+1) = ys(i+1);
    row = row + 2;
end

%construct upper matrix
M = zeros(4*(n-1));
base = 1;
row = 1;
for i=1:n-1
    M(row,base:base+3) = cubicT(ts(i));
    M(row+1,base:base+3) = cubicT(ts(i+1));

    row = row + 2;
    base = base + 4;
end

%first derivatives equal for interal knots
base = 2;
for i=2:n-1
    thisT = firstDerT(ts(i));
    M(row,base:base+2) = thisT;
    base = base + 4;
    M(row,base:base+2) = -thisT;

    row = row+1;
end

%second derivatives equal for internal knots
base = 3;
for i=2:n-1
    thisT = secondDerT(ts(i));
    M(row,base:base+1) = thisT;
    base = base + 4;
    M(row,base:base+1) = -thisT;

    row = row+1;
end

%set final two rows to be the second derivative of the first and last points equal to zero(natual spline)
numVars = 4*(n-1);
M(row,3:4) = secondDerT(ts(1));
M(row+1, numVars-1:numVars) = secondDerT(ts(n));

%[TODO]: maybe don't want to use lsqr here, but will work for now
coeffs = lsqr(M, modifiedYs, 1e-6, 100);
end