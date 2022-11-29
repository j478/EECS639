function [] = genPlotPolynomial(poly, pairs)
%GENPLOTPOLYNOMIAL takes a polynomial (in the form of an inline function) and ordered pairs, and plots them together.
%   plots the original points, as well as plots the given polynomial for that range.

n = length(pairs);
ts = pairs(:,1);
if n < 2
    display("improper input. must have at least two ordered pairs");
    return;
end

hold on;
%plot given points
for i=1:length(pairs)
    plot(pairs(i,1), pairs(i,2), "*r");
end

lower = ts(1);
upper = ts(n);
spacing = (upper-lower)/800;

xs = lower:spacing:upper;
ys = xs;
for i=1:length(xs)
    ys(i) = poly(xs(i));
end
plot(xs,ys);
hold off;

end