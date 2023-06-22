function criticalSize = facts(N,gamma,beta,t,s_sol,i_sol,r_sol,calendarTime)
    gamma %fact
    beta %fact
    mostInfectedPrediction = max(i_sol) %fact
    indexMostInfected = find(i_sol == mostInfectedPrediction); 
    timeMostInfectedPrediction = t(indexMostInfected)
    dateMostInfectedPrediction = calendarTime(1) + days(timeMostInfectedPrediction) %fact
    criticalSize = gamma/beta %fact
    infectionLength = 1/gamma %fact
    last_t = t(end) + 1; % length(t);
    totalDead =  N - (s_sol(last_t) + i_sol(last_t) + r_sol(last_t))
    totalInfected = N - s_sol(last_t)
end