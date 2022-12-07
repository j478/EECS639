function [] = plotWavyCurve(n)
% creates the points that will passed on to the bezier function. 
% INPUTS:
%   n: number of points that will be generated
% OUTPUTS:
%   null: nothing is returned
t = linspace(0,80*pi,n); % generate n equally spaced points on [0,2pi]

wavyCurveX = @(t) 20.*t.*cos(.2.*t); % wavyCurve parametric function
wavyCurveY = @(t) 10*sin(t);

wavyCurveXprime = @(t) 20*(cos(.2.*t)-.2.*t.*sin(.2.*t));% first derivative of wavyCurve
wavyCurveYprime = @(t) 10*cos(t);

x_coord = wavyCurveX(t); % create n points
y_coord = wavyCurveY(t);

scatter(x_coord,y_coord);
hold on

alpha = wavyCurveXprime(t); % create the tranformations for the guide points
beta = wavyCurveYprime(t);

endPoints = [x_coord;y_coord].'; % create nx2 arrays to be passed to bezier
leftGuides = [x_coord+alpha;y_coord+beta].';
rightGuides = [x_coord-alpha;y_coord-beta].';

bezier(n,endPoints,leftGuides,rightGuides);

end
