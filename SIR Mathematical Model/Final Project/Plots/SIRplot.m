function SIRplot(t, s_sol, i_sol, r_sol, time, cases, sirTitle)
    hold on
    plot(t,s_sol, ['b']);
    plot(t,i_sol, ['r']);
    plot(t,r_sol, ['g']);
    plot(time,cases,['.' 'k']);
    grid on
    xline(0);
    yline(0);
    title(sirTitle);
    xlabel('Time');
    ylabel('Population');
    legend('S','I','R','I from Data');
    hold off
end