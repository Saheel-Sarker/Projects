%Part 1

%With Built-in LU routine
Pixels = [1,1,1,0,0,0,0,0,0; %\
          0,0,0,0,0,0,1,1,1; %/
          1,1,0,1,0,0,0,0,0; %\
          0,0,0,0,0,1,0,1,1; %/
          1,0,0,1,0,0,1,0,0; %\
          0,0,1,0,0,1,0,0,1; %/
          0,1,1,0,0,1,0,0,0; %\
          1,0,0,0,1,0,0,0,1; % |4
          0,0,0,1,0,0,1,1,0];%/

b_data = [8;13;3.81;14.79;6;18;10.51;16.31;7.04];
[L,U,P] = lu(Pixels);
y = L\(P*b_data);
x = U\(y);
disp(x);

% With \ operator
Pixels_New = [1,1,1,0,0,0,0,0,0; %\
              0,0,0,1,1,1,0,0,0; % |1
              0,0,0,0,0,0,1,1,1; %/
              1,1,0,1,0,0,0,0,0; %\
              0,0,1,0,1,0,1,0,0; % |2
              0,0,0,0,0,1,0,1,1; %/
              1,0,0,1,0,0,1,0,0; %\
              0,1,0,0,1,0,0,1,0; % |3
              0,0,1,0,0,1,0,0,1; %/
              0,1,1,0,0,1,0,0,0; %\
              1,0,0,0,1,0,0,0,1; % |4
              0,0,0,1,0,0,1,1,0];%/;

b_data_New = [8;15;13;3.81;14.31;14.79;6;12;18;10.51;16.31;7.04];
x_new = Pixels_New\b_data_New;
disp(x_new);
% This is better because it's more accurate since it uses more data while
