load sincos_basis.mat;
figure('visible','on')
%Double Angle in Y
New_Y = [Y(1,:).^2-Y(2,:).^2;2*Y(1,:).*Y(2,:)];
%Double Angle in B
New_B = [2*B(:,1).*B(:,2),B(:,2).^2-B(:,1).^2];
for i=1:64
    Ii=renderim(New_Y(:,i),B,imsize);
    imshow(Ii,[]);
    drawnow;
    pause(0.01);
end


% B scales the time so it would make it faster as you increase time.

