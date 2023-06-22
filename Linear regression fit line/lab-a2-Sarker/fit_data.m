function [X] = fit_data(X)
    len = length(X);
    if (-1)^len == 1
        len = len-1;
        X = X(1:len);
    end
end