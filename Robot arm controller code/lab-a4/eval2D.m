%This code is available in eval2D.m
% make sure you define n and mode
ls=[0.5,0.5]';
t=rand(2,1); %Choose some random starting point.

clf;
plotRobot2D(ls,t);
hold off;

n = 10
mode = 1

while(1)
  desired=ginput(1)'; %Get desired position from user

  clf;
  plot(desired(1),desired(2),'*');
  hold on;
  plotRobot2D(ls,t,':');
  
  %Solve and display the position
  t=invKin2D(ls,t,desired,n,mode); 
  plotRobot2D(ls,t);
  hold off;
end

%Netwon is better than broyden. Took less clicks to get to my spot.