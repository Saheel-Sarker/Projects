function [A] = find_poly_A(X, parameters)
    for i = 1:1:parameters
        A(:,i) = X.^(i-1);
    end
end