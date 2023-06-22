function IRplot(t, i_sol, r_sol, sirTitle)
    hold on
    plot(t,i_sol,['r']);
    plot(t,r_sol,['g']);
    grid on
    xline(0);
    yline(0);
    title(sirTitle);
    xlabel('Time');
    ylabel('Population');
    legend('I','R');
    hold off
end