function J = fdJacob2D(l, theta, h)
     J(:,1) = (evalRobot2D(l,theta+[h;0])-evalRobot2D(l,theta-[h;0]) ) / (2*h);
     J(:,2) = (evalRobot2D(l,theta+[0;h])-evalRobot2D(l,theta-[0;h]) ) / (2*h);
end

% a) They are close enough I think
% b) Faster computation maybe