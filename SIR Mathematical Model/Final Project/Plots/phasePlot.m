function phasePlot(s_sol, i_sol, criticalSize, phaseTitle)
    hold on
    plot(s_sol,i_sol, ['b']);
    xlim([s_sol(end)-s_sol(end)/4 s_sol(1)+s_sol(end)/4]);
    xline(criticalSize, ['m'], LineWidth=0.8);
    grid on
    xline(0);
    yline(0);
    title(phaseTitle);
    xlabel('Susceptibles');
    ylabel('Infecteds');
    criticalSizeEst = round(criticalSize,-5); %fact
    legend('Phase Line', ['S = gamma/beta = ~' num2str(criticalSizeEst)]);
end