function[] = plotData(fnString, interval, spacing)
%GENDATA takes a function (as a string), an interval (as a vector of size 2), and spacing as an int. Returns set of ordered pairs
    %To generate the plots with the ordered pairs form the project description, pass in "Data" as fnString, and blank strings for the rest of the parameters
    paris = [];
    rescale = 1e-4;
    if fnString ~= "Dates"
        if length(interval) ~= 2
            display("invalid input. interval must have form [<lower bound>, <upper bound>]");
            return;
        end

        currentFn = inline(fnString, 'x');
        xs = linspace(interval(1), interval(2), spacing)';
        ys = xs;
        for i=1:length(xs)
            ys(i) = currentFn(xs(i));
        end
        pairs = [xs ys];
    else
        pairs = [1994 67.052; 1995 68.008; 1996 69.83; 1997 72.024; 1998 73.400; 1999 72.063;
        2000 74.669; 2001 74.487; 2002 74.065; 2003 76.777];
    end

    pos = 1;

    vandemondePoly = vandemonde(pairs);
    subplot(3, 3, pos);
    genPlotPolynomial(vandemondePoly, pairs);
    title("Vandemonde Polynomial");

    pos = pos + 1;

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

    natCoeffs = cubicSpline(pairs, "n", rescale);
    subplot(3, 3, pos);
    genPlotCubicSpline(natCoeffs, pairs, rescale);
    title("Natural Spline");

    pos = pos + 1;

    continuousCoeffs = cubicSpline(pairs, "c", rescale);
    subplot(3, 3, pos);
    genPlotCubicSpline(continuousCoeffs, pairs, rescale);
    title("Complete Spline");

    pos = pos + 1;

    notAKnotCoeffs = cubicSpline(pairs, "k", rescale);
    subplot(3, 3, pos);
    genPlotCubicSpline(notAKnotCoeffs, pairs, rescale);
    title("Not-A-Knot Spline");

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
    
    xs = linspace(ts(1),ts(n),800);
    ys = xs;
    for i=1:length(xs)
        ys(i) = poly(xs(i));
    end
    plot(xs,ys);
    hold off;
    
end

function [] = genPlotCubicSpline(coeffs, pairs, rescale)
%GENPLOTCUBICSPLINE takes a vector of coefficents corresponding to a system of cubic equations and order pairs, and plots them.
%   plots the original points, as well as plots the corresponing functions that connnect them.
    
    n = length(pairs);
    ts = pairs(:,1);
    if rescale ~= 0
        ts = ts*rescale;
    end

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
    xs = linspace(ts(1), ts(n), 1000);
    ys = xs;

    coeffBase = 1;
    tctr = 2;
    for i=1:length(xs)
        currPolyString = coeffs(coeffBase+3) + "*(t.^3) + " + coeffs(coeffBase+2) + "*(t.^2) + " + coeffs(coeffBase+1) + "*(t) + " + coeffs(coeffBase);
        currPoly = inline(currPolyString, 't');
        ys(i) = currPoly(xs(i));

        if xs(i) > ts(tctr)
            tctr = tctr + 1;
            coeffBase = coeffBase + 4;
        end
    end

    if rescale ~= 0
        inv = floor(log10(rescale)) * -1;
        rescale = 1 * 10.^inv;
        xs = xs * rescale;
    end
    plot(xs, ys);
    hold off;
        
end

