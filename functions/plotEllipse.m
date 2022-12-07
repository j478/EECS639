function [] = plotEllipse(n)
% creates the points that will passed on to the bezier function. 
% INPUTS:
%   n: number of points that will be generated
% OUTPUTS:
%   null: nothing is returned
t = linspace(0,2*pi,n); % generate n equally spaced points on [0,2pi]

ellipseX = @(t) 5*cos(3*t); % ellipse parametric function
ellipseY = @(t) 2*sin(3*t);

ellipseXprime = @(t) -15*sin(3*t);% first derivative of ellipse
ellipseYprime = @(t) 6*cos(3*t);

x_coord = ellipseX(t); % create n points
y_coord = ellipseY(t);

scatter(x_coord,y_coord);
hold on

alpha = ellipseXprime(t); % create the tranformations for the guide points
beta = ellipseYprime(t);

endPoints = [x_coord;y_coord].'; % create nx2 arrays to be passed to bezier
leftGuides = [x_coord+alpha;y_coord+beta].';
rightGuides = [x_coord-alpha;y_coord-beta].';

bezier(n,endPoints,leftGuides,rightGuides);

end