function [P] = trigval(coefficient_vector,X)
    P(1:length(X),1) = coefficient_vector(1);
    k = 1;
    for i = 2:2:length(coefficient_vector)-1
        P = P + coefficient_vector(i)*cos(k*X);
        P = P + coefficient_vector(i+1)*sin(k*X);
        k = k + 1;
    end
end