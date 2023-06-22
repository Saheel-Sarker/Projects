function [Cov] = covariance(DataStd)
    [m,n] = size(DataStd);
    Cov = (DataStd'*DataStd)/m;
end