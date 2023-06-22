function  theta = invKin2D(l, theta0, pos, n, mode)
    if mode == 0 % Newton's Method
        for k = 1:n
            [posk, J] = evalRobot2D(l,theta0);
            sk = J\(-(posk - pos));
            theta0 = theta0 + sk;
        end
    elseif mode == 1 %Broyden's Method
        [~, B] = evalRobot2D(l,theta0);
        for k = 1:n
           posk = evalRobot2D(l,theta0); % f(x)
           sk = B\(-(posk - pos));
           theta0 = theta0 + sk;
           posk1 = evalRobot2D(l,theta0); % f(x_+1)
           yk = posk1 - posk;
           B = B + ((yk-B*sk)*sk.')/(sk.'*sk);
        end
    end
    theta = theta0;
end