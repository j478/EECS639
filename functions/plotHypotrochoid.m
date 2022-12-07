function [] = plotHypotrochoid(n)
% creates the points that will passed on to the bezier function. 
% INPUTS:
%   n: number of points that will be generated
% OUTPUTS:
%   null: nothing is returned
t = linspace(0,1000,n); % generate n equally spaced points on [0,2pi]

hypotrochoidX = @(t) 2*cos(t) + 5*cos(2*t/3); % hypotrochoid parametric function
hypotrochoidY = @(t) 2*sin(t) - 5*sin(2*t/3);

hypotrochoidXprime = @(t) -2*sin(t) - 10/3*sin(2*t/3);% first derivative of hypotrochoid
hypotrochoidYprime = @(t) 2*cos(t) - 10/3*cos(2*t/3);

x_coord = hypotrochoidX(t); % create n points
y_coord = hypotrochoidY(t);

scatter(x_coord,y_coord);
hold on

alpha = hypotrochoidXprime(t); % create the tranformations for the guide points
beta = hypotrochoidYprime(t);

endPoints = [x_coord;y_coord].'; % create nx2 arrays to be passed to bezier
leftGuides = [x_coord+alpha;y_coord+beta].';
rightGuides = [x_coord-alpha;y_coord-beta].';

bezier(n,endPoints,leftGuides,rightGuides);
end

