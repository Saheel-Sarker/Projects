% Vectorize the following
% Note the use of the tic/toc calls to time execution
% Compare the time once you have vectorized it


tic
for i = 1:1000
    t(i) = 2*i;
    y(i) = sin (t(i));
end
toc

tic
new_i = 1:1000;
new_vector = sin(2*new_i);
toc

%
clear;