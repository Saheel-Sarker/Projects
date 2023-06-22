% I added the residual here because it's easier for me to calculate the
% residual vector on here

function [coefficient_vector, residual] = func_fit(X,Y,type, basis, parameters)
    if basis == "poly"
        A = flip(find_poly_A(X,parameters),2);
    elseif basis == "trig"
        A = find_trig_A(X,type,parameters);
    end
    if type == "approximate"
        At = A.';
        At_A = At*A;
        At_Y = At*Y;
        coefficient_vector = At_A\At_Y;
        coefficient_vector
    elseif type == "interpolate"
        coefficient_vector = A\Y;
    end
    residual = Y - A*coefficient_vector;
end