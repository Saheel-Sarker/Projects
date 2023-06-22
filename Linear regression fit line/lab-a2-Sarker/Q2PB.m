data = load("lab2part2probb.mat");
X = data.x.';
Y = data.y.';

close all

% Scatter plot for Analyst data
figure('Name', "Unknown function Graph");
scatter(X,Y); % Looks like a polynomial of degree 2
hold on;

% Find Function and graph it
[poly_vector, residual] = func_fit(X,Y,"approximate", "poly", 3);
X_poly = (X(1):0.01:X(end)).';
Y_poly = polyval(poly_vector,X_poly);
plot(X_poly,Y_poly);
hold off

% Find derivative
derivative = polyder(poly_vector.'); 
disp("Derivative vector of function (starting with my highest degree and ending with my constant) is:"); 
disp(derivative);

% Find Integral
integral = polyint(poly_vector.');
a = data.x(1,1);
b = data.x(length(data.x));
Area = polyval(integral,b) - polyval(integral, a);
integral = integral;
disp("Integral vector of function (starting with my highest degree and ending with my constant) is:"); 
disp(integral);
disp("And area between first and last point is:");
disp(Area);

disp("Residual vector is");
disp(residual);
relative_error = norm(residual)/norm(Y);
disp("The relative residual error is");
disp(relative_error);