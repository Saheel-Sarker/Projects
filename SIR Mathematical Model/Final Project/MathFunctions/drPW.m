function rate = drPW(intersect,d1,d2, time, t)
    rate = polyval(d1,t).*((time(1)<=t)&(t<=time(intersect))) + ...
           d2.*(t>time(intersect));
end