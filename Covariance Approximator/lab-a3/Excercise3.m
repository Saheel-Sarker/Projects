load("immotion_basis.mat")
figure('visible','on')
for i=1:13
    Ii=renderim(Y(:,i),B,imsize);
    imshow(Ii);
    drawnow;
    pause(0.01);
end

% Mine

I_mine = imread("tibetan-mastiff-2.jpg");
I_mine = im2gray(I_mine);
I_mine = im2double(I_mine);
imsize_mine = size(I_mine);
[Ix,Iy] = gradient(I_mine);
Ix = Ix(:);
Iy = Iy(:);
I_mine = I_mine(:);
B_mine = [I_mine,Ix,Iy];
Y_mine = [ones(1,13); (-6:1:6); (-6:1:6)];

%Larger Y values make less movement I think
%Finely spaced t-values values make less movement I think too
%I Think this is because if the t-values are too close then the difference
%between each image is too close to see noticable change. Likewise larger Y
%values make the difference between each step seem less significant aswell
%This approximation is best for images with images that have a general form
%that's understandable even if it's distorted a bit. When the taylor
%expansion doesn't work is when images that have a lot of contrast. 

figure('visible','on')
for i=1:13
    I_mine=renderim(Y_mine(:,i),B_mine,imsize_mine);
    imshow(I_mine);
    drawnow;
    pause(0.01);
end