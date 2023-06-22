load("EllipsePoints.mat");
set(Y1,1)
set(Y2,2)
set(Y3,3)

function set(Y,num)
    Data = Y.';
    DataStd = standard(Data);
    CovMat = covariance(DataStd);
    figure(num);
    axis equal
    hold on
    plot(DataStd(:,1),DataStd(:,2),".");
    plotEig(CovMat);
    hold off
end