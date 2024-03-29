function Iplot(t, i_sol, time, cases, sirTitle)
    hold on
    plot(t,i_sol,['r']);
    plot(time,cases,['.' 'k']);
    grid on
    xline(0);
    yline(0);
    title(sirTitle);
    xlabel('Time');
    ylabel('Population');
    legend('I','I From Data');
    hold off
end