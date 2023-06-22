l = [1;1];
theta = [pi/4;pi/2];
h = 0.1;
plotRobot2D(l, theta);
[pos, j] = evalRobot2D(l, theta);
ja = fdJacob2D(l,theta,h);

theta0 = [pi/4;pi/4];
n = 10;
mode = 1;
angles=invKin2D(l,theta0, pos, n, mode)
positionFromAngles=evalRobot2D(l,angles)