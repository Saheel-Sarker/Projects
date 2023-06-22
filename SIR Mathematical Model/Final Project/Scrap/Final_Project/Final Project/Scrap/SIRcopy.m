close all % close all figures

% DATA
dateStrings = ["2000-10-13";"2000-10-18";"2000-10-19";"2000-10-26";"2000-11-02";"2000-11-09";"2000-11-19";"2000-11-27";"2000-12-05";"2000-12-19";"2000-12-29";"2001-01-09";"2001-01-14";"2001-01-25";"2001-02-04";"2001-02-14";"2001-02-22";"2001-03-03";"2001-03-14";"2001-03-28";"2001-04-16"];
calendar_time = datetime(dateStrings,"InputFormat", "yyyy-MM-dd");
time = days(calendar_time - calendar_time(1));
cases = 10*[2175;3075;3279;3806;4270;4583;5285;5876;6548;8137;11183;15983;19499;27431;37204;48647;56092;62607;69761;78140;86107];
deaths = [22;26;27;31;32;33;35;35;35;41;51;60;66;74;85;108;120;131;139;163;181];

% Plot Death Rates
deathRates = deaths./cases;
subplot(2,2,1)
hold on
grid on
plot(time,deathRates,['.' 'b']);
title('Deathrates Over time');
xlabel('Time');
ylabel('Death Rates');

% Approximate Deathrate
deathRates = deathRates(14:end); % looks like death rate drops and levels off close to ~0.0002
deathRateMean = mean(deathRates);
data = [time cases];
plot([1:200],deathRateMean*[1:200].^0, ['k']);
legend('Death Rates at time t', ['Significant Death Rate = ~' num2str(deathRateMean)]);
hold off

% Initial conditions
N = 8990000;
I0 = cases(1);
S0 = N - I0;
R0 = 0;
IC = [S0 I0 R0];

% Parameters Guess:
beta = 0.000000004; % guess = 0.000000004 found manually
gamma_plus_d = 0.15; % guess = 0.15 found manually
P0 = [beta gamma_plus_d]; % Parameters

% Estimate Parameters
pEst = fminsearch(@(P) SSE(data,P,IC),P0);

% Parameters :
beta = pEst(1); 
gamma = pEst(2) - deathRateMean; % g_est = (g_est + dr_est) - dr
d = deathRateMean;  

% Approximate Parameters
pEst = fminsearch(@(P) SSE(data,P,IC),P0);

% The right hand side of the model equtions are defined as a function
f = @(t,x) [-beta*x(1)*x(2); beta*x(1)*x(2)-gamma*x(2)-d*x(2); gamma*x(2)];

% Matlab command to solve an ODE:
[t, y] = ode45(f, [0:500], IC);
s_sol = y(:,1);
i_sol = y(:,2);
r_sol = y(:,3);

% Plot ODE's
subplot(2,2,2)
hold on
plot(t,i_sol,['r']);
plot(time,cases,['.' 'k']);
grid on
title('Infecteds over Time');
xlabel('Time');
ylabel('Values');
legend('SIR Solution for I','From Data');
hold off

% figure
% hold on
% plot(t,susceptibles, ['b']);
% plot(t,removed, ['g']);
% grid on
% title('Susceptibles and Recovered over Time');
% xlabel('Time');
% ylabel('Values');
% legend('S', 'R');
% hold off

subplot(2,2,3)
hold on
plot(t,s_sol, ['b']);
plot(t,i_sol, ['r']);
plot(t,r_sol, ['g']);
plot(time,cases,['.' 'k']);
grid on
title('SIR MODEL');
xlabel('Time');
ylabel('Values');
legend('S','I','R','I from Data');
hold off

% Facts
maxInfected = max(i_sol); %fact
critSize = gamma/beta;
critSizeEst = round(critSize,-5); %fact
IndexMaxInfected = find(i_sol == maxInfected); 
TimeMaxInfected = t(IndexMaxInfected); %fact

% Phase line analysis
subplot(2,2,4)
hold on
plot(s_sol,i_sol, ['b']);
xlim([s_sol(end)-s_sol(end)/5 s_sol(1)+s_sol(end)/5]);
xline(critSize, [':' 'k'], LineWidth=1.5);
grid on
title('Phase Portrait');
xlabel('Susceptibles');
ylabel('Infecteds');
legend('Phase Line', ['gamma/beta = ~' num2str(critSizeEst)]);


