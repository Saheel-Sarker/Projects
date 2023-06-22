function plotEig(CovMat)
    [X,D] = eig(CovMat);
    D = 2*sqrt(D);
    plot(D(1,1)*[0 X(1,1)],D(1,1)*[0 X(2,1)],'r')
    plot(D(2,2)*[0 X(1,2)],D(2,2)*[0 X(2,2)],'g')
end
