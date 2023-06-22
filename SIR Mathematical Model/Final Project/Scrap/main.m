% S'(t) = -B*I*S
% I'(t) =  B*I*S-a*I
% R'(t) =  a*I

dateStrings = ["2000-10-13";"2000-10-18";"2000-10-19";"2000-10-26";"2000-11-02";"2000-11-09";"2000-11-19";"2000-11-27";"2000-12-05";"2000-12-19";"2000-12-29";"2001-01-09";"2001-01-14";"2001-01-25";"2001-02-04";"2001-02-14";"2001-02-22";"2001-03-03";"2001-03-14";"2001-03-28";"2001-04-16"];
calendar_time = datetime(dateStrings,"InputFormat", "yyyy-MM-dd");
time = days(calendar_time - calendar_time(1));
cases = 10*[2175;3075;3279;3806;4270;4583;5285;5876;6548;8137;11183;15983;19499;27431;37204;48647;56092;62607;69761;78140;86107];
deaths = [22;26;27;31;32;33;35;35;35;41;51;60;66;74;85;108;120;131;139;163;181];

deathrates = deaths./cases;
deathrates_mean = mean(deathrates);

% Graphs data with cases or death on y-axis and time on x-axis
close all
figure("Name", "Cases");
plot(time,cases,".");
% figure("Name", "Deaths");
% plot(time,deaths,".");

figure("Name", "Death rates");
plot(time,deathrates,"."); % looks like deaths level out around ~0.0002