close all % close all figures
addpath("MathFunctions\","plots\");
% DATA
dateStrings = ["2000-10-13";"2000-10-18";"2000-10-19";"2000-10-26";"2000-11-02";...
    "2000-11-09";"2000-11-19";"2000-11-27";"2000-12-05";"2000-12-19";"2000-12-29";...
    "2001-01-09";"2001-01-14";"2001-01-25";"2001-02-04";"2001-02-14";"2001-02-22";...
    "2001-03-03";"2001-03-14";"2001-03-28";"2001-04-16"];
calendarTime = datetime(dateStrings,"InputFormat", "yyyy-MM-dd");
time = days(calendarTime - calendarTime(1));
assumption = 10;
cases = assumption*[2175;3075;3279;3806;4270;4583;5285;5876;6548;8137;11183;15983;19499;...
    27431;37204;48647;56092;62607;69761;78140;86107];
deaths = [22;26;27;31;32;33;35;35;35;41;51;60;66;74;85;108;120;131;139;163;181];
data = [time cases];

% Initial conditions
N = 8990000;
I0 = cases(1);
S0 = N - I0;
R0 = 0;
IC = [S0 I0 R0];

% Plot Death Rates
deathRates = deaths./cases;
figure(1)
subplot(2,2,1)
hold on
grid on
xline(0);
yline(0);
plot(time,deathRates,['.' 'k']);
title('DEATHRATES PER TIME');
xlabel('Time');
ylabel('Death Rates');

% Approximate Deathrate
intersect = 15;
d1 = polyfit(time(1:intersect),deathRates(1:intersect),1);
d2 = mean(deathRates(intersect:end));
d = @(t) drPW(intersect,d1,d2, time, t); % deathrate piecewise function
plot(time,d(time),['b']);
legend('Death Rates from Data', 'Death Rate Piecewise Function');
hold off

% Parameters Guess:
betaGuess = 0.000000004; % guess = 0.000000004 found manually
gammaDGuess = 0.15; % guess = 0.15 found manually
P0 = [betaGuess gammaDGuess]; % Parameters

% Estimate Parameters
pEst = fminsearch(@(P) SSE(data,P,d,IC),P0);

% Parameters :
beta = pEst(1); 
gamma = pEst(2);

% The right hand side of the model equtions are defined as a function
t = [0:500];
[s_sol, i_sol, r_sol, t] = solveSIR(t,beta, gamma, d, IC);

% SIR MODEL for I only
figure(1)
subplot(2,2,2)
Iplot(t, i_sol, time, cases, 'SIR MODEL FOR I ONLY')

% SIR MODEL
figure(1)
subplot(2,2,3)
SIRplot(t, s_sol, i_sol, r_sol, time, cases, 'SIR MODEL')

% Facts 
criticalSize = facts(N,gamma,beta,t,s_sol,i_sol,r_sol,calendarTime);

% Phase line Analysis
figure(2)
subplot(2,1,1)
phasePlot(s_sol, i_sol, criticalSize, 'PHASE LINE HANDWASHING')

%%%%%%%%%%% WITH HANDWASHING %%%%%%%%%%%
% Parameters :
handwashEffect = 0.5; % CAN CHANGE THIS AROUND
beta = beta*(1-handwashEffect); 

% The right hand side of the model equtions are defined as a function
[s_sol, i_sol, r_sol, t] = solveSIR(t,beta, gamma, d, IC);

% IR MODEL W/ HANDWASHING
figure(1)
subplot(2,2,4)
hold on
IRplot(t,i_sol,r_sol,"IR MODEL W/HANDWASHING")
hold off

% Facts
disp("AFTER HANDWASHING!")
criticalSize = facts(N,gamma,beta,t,s_sol,i_sol,r_sol,calendarTime);

% Phase line Analysis W/ HANDWASHING
figure(2)
subplot(2,1,2)
phasePlot(s_sol, i_sol, criticalSize, 'PHASE LINE W/ HANDWASHING')