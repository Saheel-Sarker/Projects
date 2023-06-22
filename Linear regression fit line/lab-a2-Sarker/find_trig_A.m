function [A] = find_trig_A(X, type, parameters)
    if type == "approximate"
        len = parameters;
    elseif type == "interpolate"
        len = length(X);
    end
    A(:,1) = X.^0;
    k = 1;
    for i = 2:2:len - 1
        A(:,i) = cos(k*X);
        A(:,i+1) = sin(k*X);
        k = k + 1;
    end
end