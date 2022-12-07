function [] = plotEllipse(n)
t = linspace(0,2*pi,n);

ellipseX = @(t) 5*cos(3*t);
ellipseY = @(t) 2*sin(3*t);

ellipseXprime = @(t) -15*sin(3*t);
ellipseYprime = @(t) 6*cos(3*t);

x_coord = ellipseX(t);
y_coord = ellipseY(t);

alpha = ellipseXprime(t);
beta = ellipseYprime(t);

endPoints = [x_coord;y_coord].';
leftGuides = [x_coord+alpha;y_coord+beta].';
rightGuides = [x_coord-alpha;y_coord-beta].';

bezier(n,endPoints,leftGuides,rightGuides);

end