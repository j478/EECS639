function[coefficents] = cubicSpline(orderedPairs, choice, rescale)
%CUBICSPLINE takes a matrix of ordered pairs, as well as a specifier, and returns the coefficents for the cubic equations.
%   usage: cubicSpline(<ordered pairs>, <token>) where <token> is either 'n' for natural spline, 'k' for not-a-knot, or 'c' for continuous spline

%helper lambda functions to set the first, second, and third derivative when needed
cubicT = @(t) [1 t t.^2 t.^3];
firstDerT = @(t) [1 2*t 3*t.^2];
secondDerT = @(t) [2 6*t];

%if choice is bad, fail
if (choice ~= 'n') && (choice ~= 'k') && (choice ~= 'c')
    display("invalid second input. please specify 'n' for natural, 'k' for not-a-knot, or 'c' for continuous");
    coefficents = [];
    return;
end

%if pairs are bad, fail
n = length(orderedPairs);
if n < 1
    coefficents = [];
    return;
end

%take list of ordered pairs, and split them on ts and ys.
ts = orderedPairs(:,1);
if rescale ~= 0
    ts = ts*rescale;
end

%want to construct y vector such that first half is values for intervals of y, and last half are zeros
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

%user choice determines how the final two rows are set, thus choosing the type of cubic spline generated.
numVars = 4*(n-1);
switch choice
    case 'n'
        %setting end points second derivatives equal to zero
        M(row,3:4) = secondDerT(ts(1));
        M(row+1, numVars-1:numVars) = secondDerT(ts(n));
    case 'k'
        %setting second endpoints third derivatives equal to each other
        M(row, 4) = 6;
        M(row, 8) = -6;

        %setting second to last third derivatives equal to each other
        M(row+1, numVars-4) = 6;
        M(row+1, numVars) = -6;
    case 'c'
        %defining first derivative of first endpoint
        M(row,2:4) = firstDerT(ts(1));
        modifiedYs(row) = 1;
        
        %defining first derivative of last endpoint
        M(row+1, numVars-2:numVars) = firstDerT(ts(n));
        modifiedYs(row+1) = 1;
    otherwise
        display("I'm supposed to be unreachable! Something went horribly wrong!!");
end

%return set of coefficents for evauluation with cubic polynomials
coefficents = M\modifiedYs;
end