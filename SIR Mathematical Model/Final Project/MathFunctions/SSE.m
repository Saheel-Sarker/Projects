function error = SSE(data,P,d,IC)
    % data = [time infections]
    % P = [beta gamma]
    % IC = [S(0) I(0) R(0)]
    time = data(:,1);
    infections = data(:,2);
    f = @(t,x) [-P(1)*x(1)*x(2); P(1)*x(1)*x(2)-P(2)*x(2)-d(t)*x(2); P(2)*x(2)];
    [~, y] = ode45(f,(0:time(end)),IC);
    error = norm(y(time+1,2)-infections); % = SSE
end