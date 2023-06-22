function [s_sol, i_sol, r_sol, t] = solveSIR(t,beta, gamma, d, IC)
    f = @(t,x) [-beta*x(1)*x(2); beta*x(1)*x(2)-gamma*x(2)-d(t)*x(2); gamma*x(2)];
    % Matlab command to solve an ODE:
    [t, y] = ode45(f, t, IC);
    s_sol = y(:,1);
    i_sol = y(:,2);
    r_sol = y(:,3);
end