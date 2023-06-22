T = [ 0.  1.  2.  3.  4.  5.  6.  7.  8.  9. 10.];
D= [486.   481.14 466.56 442.26 408.24 364.5  311.04 247.86 174.96  92.34 0.  ];
T = T.';
D = D.';

close all

% Scatter plot for physics data
figure('Name', "Distance vs Time Graph");
scatter(T,D); % looks like a degree 2 problem. The speed of the ball looks like it's increasing as time increases
hold on;

% Find Function and graph it
[poly_vector, residual] = func_fit(T,D,"interpolate", "poly", 3);
T_poly = [T(1):0.01:T(end)].';
D_poly = polyval(poly_vector,T_poly);
plot(T_poly,D_poly);
hold off

disp("Residual vector is");
disp(residual);
relative_error = norm(residual)/norm(D);
disp("The relative residual error is");
disp(relative_error);

% It does seem to obey the laws of physics. As the ball gets dropped it's
% initial speed of the ball is 0 but due to the acceleration due to gravity 
% it picks up more and more speed over time.  