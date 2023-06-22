function rate = drPW(deathRates, time, t)
    intersect = 15;
    d1 = polyfit(time(1:intersect),deathRates(1:intersect),1);
    d2 = mean(deathRates(intersect:end));
    rate = polyval(d1,t).*((time(1)<=t)&(t<=time(intersect))) + ...
           d2.*(t>time(intersect));
end