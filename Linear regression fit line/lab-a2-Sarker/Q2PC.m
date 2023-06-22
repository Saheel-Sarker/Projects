data = load("lab2parat2probc.mat");
X = data.X2.';
Y = data.Y2.';
X = fit_data(X);
Y = fit_data(Y);
close all

% Scatter plot of engeering data
figure('Name', "Engineering Function Graph");
scatter(X,Y);
hold on;

% Find Function and graph it

% Overall it looks like a polynomial of degree two
[poly_vector, residual1] = func_fit(X,Y,"approximate","poly",3);
Y_poly = polyval(poly_vector,X);
plot(X,Y_poly);
hold on;
% Now I subtract the original data with the polynomial function I found
% to get a trig function

Y_difference = Y - Y_poly;
scatter(X,Y_difference);

% To find the trig part of function
[trig_vector, residual2] =  func_fit(X, Y_difference, "approximate", "trig", 55);
X_plot = (X(1):0.1:X(end)).';
Y_trig = trigval(trig_vector,X_plot);
plot(X_plot,Y_trig);

% True function is trig function + poly function
True_Y = trigval(trig_vector,X_plot) + polyval(poly_vector, X_plot);
plot(X_plot, True_Y);

disp("Residual vector is");
disp(residual1 + residual2);
relative_error = norm(residual1 + residual2)/norm(Y);
disp("Euclidean norm of residual vector is");
disp(relative_error);










