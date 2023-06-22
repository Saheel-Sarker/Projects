% Sample script  that shows how to automate running problem solutions
close all;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Load an image using the imread command 
lenna = imread("lena_std.tiff.tif");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b) Display original image in the first spot of a 2 x 3 a grid layout
%    Check the imshow and subplot commands.
figure(1);
subplot(2,3,1);
imshow(lenna);
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% c) Display a gray scale version of the image in position 2 of the grid.
%    help rgb2gray
Lenna_rgb = rgb2gray(lenna);
subplot(2,3,2);
imshow(Lenna_rgb);
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d) Generate a new figure and ask user to manually select a region of the
%    image. Display the subimage in position 3 of the grid.
%    Hint--> getrect()

% Get user input on a newly dislayed image

% Make grid the current figure

% Display selected region. Note the last : which applies the cut
% over all 3 channels.
fig2 = figure(2);
imshow(lenna);
lenna_rect = getrect();
lenna_crop = imcrop(lenna, lenna_rect);
close(fig2);
figure(1);
subplot(2,3,3);
imshow(lenna_crop);
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% e) Create a function J = luminance_change(I, option, value) such that:
%   * When given the option 'c', image I's contrast will be modified by
%     the given value. Simple multiplication will achieve this.
%   * When given the option 'b', image I's brightness will be modified by
%     the given value. Simple addition will achieve this.
%  
%   Showcase your function by filling positions 4 and 5 in the grid

% Contrast change
lenna_contrast = luminance_change(lenna, 'c', 2);
subplot(2,3,4);
imshow(lenna_contrast);
pause();

% Brightness change
lenna_brightness = luminance_change(lenna, 'b', 100);
subplot(2,3,5);
imshow(lenna_brightness);
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f) BONUS: Display a version of the image after it's been blurred using a
%    Gaussian filter. Hint: imgaussfilt()

lenna_gauss = imgaussfilt(lenna,5);
subplot(2,3,6);
imshow(lenna_gauss);

function new_lenna = luminance_change(I, option, value)
    if option == 'b'
        new_lenna = I + value;
    elseif option == 'c'
        new_lenna = I * value;
    end
end
