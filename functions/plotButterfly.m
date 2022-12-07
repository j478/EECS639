function [] = plotButterfly(n)
% creates the points that will passed on to the bezier function. 
% INPUTS:
%   n: number of points that will be generated
% OUTPUTS:
%   null: nothing is returned
t = linspace(0,2*pi,n); % generate n equally spaced points on [0,2pi]

butterflyX = @(t) sin(t).*(exp(cos(t))-2.*cos(4.*t)-sin(t/12).^5); % butterfly parametric function
butterflyY = @(t) cos(t).*(exp(cos(t))-2.*cos(4.*t)-sin(t/12).^5);

butterflyXprime = @(t) cos(t).*(exp(cos(t))-2.*cos(4.*t)-sin(t/12).^5)+sin(t).*(-exp(cos(t)).*sin(t)+8.*sin(4.*t)-5/12.*sin(t/12).^4.*cos(t/12));% first derivative of butterfly
butterflyYprime = @(t) -sin(t).*(exp(cos(t))-2.*cos(4.*t)-sin(t/12).^5)+sin(t).*(-exp(cos(t)).*sin(t)+8.*sin(4.*t)-5/12.*sin(t/12).^4.*cos(t/12));

x_coord = butterflyX(t); % create n points
y_coord = butterflyY(t);

scatter(x_coord,y_coord);
hold on

alpha = butterflyXprime(t); % create the tranformations for the guide points
beta = butterflyYprime(t);

endPoints = [x_coord;y_coord].'; % create nx2 arrays to be passed to bezier
leftGuides = [x_coord+alpha;y_coord+beta].';
rightGuides = [x_coord-alpha;y_coord-beta].';

bezier(n,endPoints,leftGuides,rightGuides);

end

