X1 = [-6.28318531 -5.62179738 -4.96040945 -4.29902153 -3.6376336  -2.97624567  -2.31485774 -1.65346982 -0.99208189 -0.33069396  0.33069396  0.99208189   1.65346982  2.31485774  2.97624567  3.6376336   4.29902153  4.96040945   5.62179738  6.28318531];
Y1 = [-0.02212373  0.68087378  0.93174316  0.93548568  0.44657927 -0.16281821  -0.71237743 -0.94524065 -0.87719887 -0.37732703  0.35844402  0.8994329   0.95673157  0.6759106   0.15797694 -0.49044645 -0.92443154 -0.97354381  -0.65275084  0.10165245];
X2 = [-5.         -4.79591837 -4.59183673 -4.3877551  -4.18367347 -3.97959184  -3.7755102  -3.57142857 -3.36734694 -3.16326531 -2.95918367 -2.75510204  -2.55102041 -2.34693878 -2.14285714 -1.93877551 -1.73469388 -1.53061224  -1.32653061 -1.12244898 -0.91836735 -0.71428571 -0.51020408 -0.30612245  -0.10204082  0.10204082  0.30612245  0.51020408  0.71428571  0.91836735   1.12244898  1.32653061  1.53061224  1.73469388  1.93877551  2.14285714   2.34693878  2.55102041  2.75510204  2.95918367  3.16326531  3.36734694   3.57142857  3.7755102   3.97959184  4.18367347  4.3877551   4.59183673   4.79591837  5.        ];
Y2 = [ 1.51657986e+01  1.18834486e+01  1.14908377e+01  9.69999012e+00   8.83752995e+00  8.53654378e+00  7.26220222e+00  6.24526603e+00   6.14466521e+00  2.20438691e+00  3.02257790e+00  2.55301601e+00   1.20314417e+00  2.81993279e+00 -7.95772374e-02  5.17986596e-01  -2.02214422e+00 -1.88483645e+00 -6.00919079e-01 -1.89204707e-01   1.69449681e-02  3.91334228e-01 -1.73970249e+00 -3.19757434e-01  -6.00188224e-01  2.31330343e-01  5.82638717e-01  4.22184971e+00   3.59292410e-01  4.59202652e+00  4.71769806e+00  5.21676309e+00   6.70631069e+00  6.62448237e+00  7.35495405e+00  9.65171985e+00   9.61038903e+00  1.22648215e+01  1.29301284e+01  1.33289427e+01   1.76286428e+01  1.76382160e+01  2.07450785e+01  2.18295969e+01   2.30767522e+01  2.64519126e+01  2.74412541e+01  2.89516763e+01   3.31531920e+01  3.70987315e+01];

X1 = X1.';
Y1 = Y1.';
X2 = X2.';
Y2 = Y2.';

close all

% Scatter plot for first set of data
figure('Name', "Plot 1");
scatter(X1,Y1); % This looks like it's trigometric just cus it has a lot of ups and downs
hold on;

% Find Function and graph it
X1 = fit_data(X1);
Y1 = fit_data(Y1);
trig_vector = func_fit(X1,Y1,"interpolate", "trig", "None"); % I'm interpolating since I think the curve can go through everypoint nicely and smoothlysize(X1)
X_trig = (X1(1):0.01:X1(end)).';
Y_trig = trigval(trig_vector,X_trig).';
plot(X_trig,Y_trig);
hold off

% Scatter plot for second set of data
figure('Name', "Plot 2");
scatter(X2,Y2); % This looks like it's Polynomial just cus it has a simple curve that looks like a parabola
hold on;

% Find Function and graph it
poly_vector = func_fit(X2,Y2,"approximate", "poly", 3); % I don't think the data goes through all the points that well so im gonna go inbetween and approximate
X_poly = (X2(1):0.01:X2(end)).';
Y_poly = polyval(poly_vector,X_poly);
plot(X_poly,Y_poly);
hold off

