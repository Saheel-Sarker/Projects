close all % close all figures

% DATA
dateStrings = ["2000-10-13";"2000-10-18";"2000-10-19";"2000-10-26";"2000-11-02";"2000-11-09";"2000-11-19";"2000-11-27";"2000-12-05";"2000-12-19";"2000-12-29";"2001-01-09";"2001-01-14";"2001-01-25";"2001-02-04";"2001-02-14";"2001-02-22";"2001-03-03";"2001-03-14";"2001-03-28";"2001-04-16"];
calendarTime = datetime(dateStrings,"InputFormat", "yyyy-MM-dd");
time = days(calendarTime - calendarTime(1));
cases = 10*[2175;3075;3279;3806;4270;4583;5285;5876;6548;8137;11183;15983;19499;27431;37204;48647;56092;62607;69761;78140;86107];
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
hold on
grid on
xline(0);
yline(0);
plot(time,deathRates,['.' 'k']);
title('DEATHRATES PER TIME');
xlabel('Time');
ylabel('Death Rates');

% Approximate Deathrate
rates = drPW(deathRates,time,time);
plot(time,rates, ['b']);
legend('Death Rates from Data', 'Death Rate Piecewise Function');
hold off

% Parameters Guess:
d = @(t) drPW(deathRates,time,t);
betaGuess = 0.000000004; % guess = 0.000000004 found manually
gammaDGuess = 0.15; % guess = 0.15 found manually
P0 = [betaGuess gammaDGuess]; % Parameters

% Estimate Parameters
pEst = fminsearch(@(P) SSE(data,P,d,IC),P0);

% Parameters :
beta = pEst(1); 
gamma = pEst(2);

% The right hand side of the model equtions are defined as a function
f = @(t,x) [-beta*x(1)*x(2); beta*x(1)*x(2)-gamma*x(2)-d(t)*x(2); gamma*x(2)];

% Matlab command to solve an ODE:
[t, y] = ode45(f, [0:500], IC);
s_sol = y(:,1);
i_sol = y(:,2);
r_sol = y(:,3);

% SIR MODEL for I only
figure(2)
subplot(2,2,1)
hold on
plot(t,i_sol,['r']);
plot(time,cases,['.' 'k']);
grid on
xline(0);
yline(0);
title('SIR MODEL FOR I ONLY');
xlabel('Time');
ylabel('Population');
legend('I','I From Data');
hold off

% SIR MODEL
figure(2)
subplot(2,2,2)
hold on
plot(t,s_sol, ['b']);
plot(t,i_sol, ['r']);
plot(t,r_sol, ['g']);
plot(time,cases,['.' 'k']);
grid on
xline(0);
yline(0);
title('SIR MODEL');
xlabel('Time');
ylabel('Population');
legend('S','I','R','I from Data');
hold off

% Facts 
gamma %fact
beta %fact
mostInfectedPrediction = max(i_sol) %fact
indexMostInfected = find(i_sol == mostInfectedPrediction); 
timeMostInfectedPrediction = t(indexMostInfected)
dateMostInfectedPrediction = calendarTime(1) + days(timeMostInfectedPrediction) %fact
criticalSize = gamma/beta %fact
infectionLength = 1/gamma %fact


% Phase line Analysis
figure(3)
subplot(2,1,1)
hold on
plot(s_sol,i_sol, ['b']);
xlim([s_sol(end)-s_sol(end)/5 s_sol(1)+s_sol(end)/5]);
xline(criticalSize, ['m'], LineWidth=0.8);
grid on
xline(0);
yline(0);
title('PHASE LINE');
xlabel('Susceptibles');
ylabel('Infecteds');
criticalSizeEst = round(criticalSize,-5); %fact
legend('Phase Line', ['S = gamma/beta = ~' num2str(criticalSizeEst)]);


%%%%%%%%%%% WITH HANDWASHING
% Parameters :
handwashEffect = 0.58; % CAN CHANGE THIS AROUND
beta = beta*(1-handwashEffect); 

% The right hand side of the model equtions are defined as a function
f = @(t,x) [-beta*x(1)*x(2); beta*x(1)*x(2)-gamma*x(2)-d(t)*x(2); gamma*x(2)];

% Matlab command to solve an ODE:
[t, y] = ode45(f, [0:500], IC);
s_sol = y(:,1);
i_sol = y(:,2);
r_sol = y(:,3);

% SIR MODEL for I only
figure(2)
subplot(2,2,3)
hold on
plot(t,i_sol,['r']);
plot(time,cases,['.' 'k']);
grid on
xline(0);
yline(0);
title('SIR MODEL FOR I ONLY W/ HANDWASHING');
xlabel('Time');
ylabel('Population');
legend('I','I From Data');
hold off

% SIR MODEL
figure(2)
subplot(2,2,4)
hold on
plot(t,s_sol, ['b']);
plot(t,i_sol, ['r']);
plot(t,r_sol, ['g']);
plot(time,cases,['.' 'k']);
grid on
xline(0);
yline(0);
title('SIR MODEL W/ HANDWASHING');
xlabel('Time');
ylabel('Population');
legend('S','I','R','I from Data');
hold off

% Facts
disp("AFTER HANDWASHING!")
gamma %fact
beta %fact
mostInfectedPrediction = max(i_sol) %fact
indexMostInfected = find(i_sol == mostInfectedPrediction); 
timeMostInfectedPrediction = t(indexMostInfected)
dateMostInfectedPrediction = calendarTime(1) + days(timeMostInfectedPrediction) %fact
criticalSize = gamma/beta %fact
infectionLength = 1/gamma %fact

% Phase line Analysis
figure(3)
subplot(2,1,2)
hold on
plot(s_sol,i_sol, ['b']);
xlim([s_sol(end)-s_sol(end)/4 s_sol(1)+s_sol(end)/4]);
xline(criticalSize, ['m'], LineWidth=0.8);
grid on
xline(0);
yline(0);
title('PHASE LINE W/ HANDWASHING');
xlabel('Susceptibles');
ylabel('Infecteds');
criticalSizeEst = round(criticalSize,-5); %fact
legend('Phase Line', ['S = gamma/beta = ~' num2str(criticalSizeEst)]);