# EECS 639 Project

## Lagrange Polynomial
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs the string of the Lagrange polynomial such as:

    >> lagrange(pairs)
    
    ans = 

        "(t - -2)t(t - 1)[(-4.500000/(t - -2)) + (0.500000/t) + (0.000000/(t - 1))]"'
Which, when plotted with the original data points, produces:

![Lagrange Plot](/sample_imgs/lagrange_sample.png?raw=true "Lagrange Sample Plot")

## Newton Polynomial
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs the string of the Newton polynomial such as:

	>> newton(pairs)

	ans = 

		"-27 + 13(t - -2) + -4(t - -2)*t"
Which, when plotted with the original data points, produces:

![Newton Plot](/sample_imgs/newton_sample.png?raw=true "Newton Sample Plot")

## Vandermonde Matrix
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs the Vandermonde matrix such as:

	>> VandermondeMatrix(pairs)
	
	ans =
	    1    -2     4
	    1     0     0
	    1     1     1

## Natural Cubic Spline
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs a vector of coefficents such as:

    >> naturalSpline(pairs)

    ans =

        -1.0000
        3.6667
        -7.0000
        -1.1667
        -1.0000
        -3.6667
        7.0000
        -2.3333

## Plotting Cubic Splines
Passing a vector of coefficents, along with the set of ordered pairs used to generate them, the function `genPlotCubicSpline` will generate a plot with the given points, along with their corresponding cubic polynomials such as:

    >> genPlotCubicSpline(coeffs, pairs)

![natCubicSpline Plot](/sample_imgs/naturalSpline_sample.png?raw=true "Natural Cubic Spline Sample Plot")