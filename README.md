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

## Vandemonde Matrix
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs the vandemonde matrix such as:

	>> vandemondeMatrix(pairs)
	
	ans =
	    1    -2     4
	    1     0     0
	    1     1     1

