function[] = plotData(fnString, interval, spacing)
%GENDATA takes a function (as a string), an interval (as a vector of size 2), and spacing as an int. Returns set of ordered pairs
    if length(interval) ~= 2
        display("invalid input. interval must have form [<lower bound>, <upper bound>]");
    end

    currentFn = inline(fnString, 'x');
    xs = linspace(interval(1), interval(2), spacing)';
    ys = xs;
    for i=1:length(xs)
        ys(i) = currentFn(xs(i));
    end
    pairs = [xs ys];

    pos = 1;

    newtonPoly = newton(pairs);
    subplot(3, 3, pos);
    genPlotPolynomial(newtonPoly, pairs)
    title("Newton Polynomial");

    pos = pos + 1;

    lagrangePoly = lagrange(pairs);
    subplot(3, 3, pos);
    genPlotPolynomial(lagrangePoly, pairs);
    title("Lagrange Polynomial");

    pos = pos + 1;

    %{
        vandemondePoly = vandemonde(pairs);
        subplot(3, 3, pos);
        genPlotPolynomial(vandemondePoly, pairs);
        title("Vandemonde Polynomial");
    %}

    pos = pos + 1;

    natCoeffs = cubicSpline(pairs, "n");
    subplot(3, 3, pos);
    genPlotCubicSpline(natCoeffs, pairs);
    title("Natural Spline");

    pos = pos + 1;

    notAKnotCoeffs = cubicSpline(pairs, "k");
    subplot(3, 3, pos);
    genPlotCubicSpline(notAKnotCoeffs, pairs);
    title("Not-A-Knot Spline");

    pos = pos + 1;

    %{
        continuousCoeffs = cubicSpline(pairs, "c");
        subplot(3, 3, pos);
        genPlotPolynomial(continuousCoeffs, pairs);
        title("continuous Spline");
    %}

    sgtitle("f(x) = " + fnString);

end

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

function [] = genPlotCubicSpline(coeffs, pairs)
%GENPLOTCUBICSPLINE takes a vector of coefficents corresponding to a system of cubic equations and order pairs, and plots them.
%   plots the original points, as well as plots the corresponing functions that connnect them.
    
    n = length(pairs);
    ts = pairs(:,1);
    if length(coeffs) ~= 4*(n-1)
        display("invalid input. number of coefficents must equal 4 * (number of pairs - 1)");
        display("# of coefficents: " + length(coeffs));
        display("# of ordered pairs: " + n);
        display("4 * (# of ordered pairs - 1): " + 4*(n-1));
        return;
    end
    
    hold on;
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
    hold off;
        
end

