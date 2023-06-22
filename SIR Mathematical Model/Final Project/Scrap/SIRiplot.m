function SIRiplot(t, i_sol, sirTitle)
    hold on
    plot(t,i_sol,['r']);
    plot(time,cases,['.' 'k']);
    grid on
    title(sirTitle);
    xlabel('Time');
    ylabel('Population');
    legend('I','I From Data');
    hold off
end