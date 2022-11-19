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

## Vandemonde Matrix
Takes a matrix of ordered pairs such as:

    >> pairs = [-2 -27; 0 -1; 1 0]

    pairs =

        -2   -27
        0    -1
        1     0
and outputs the vandemonde matrix such as:

	ans =

     		1    -2     4
     		1     0     0
     		1     1     1