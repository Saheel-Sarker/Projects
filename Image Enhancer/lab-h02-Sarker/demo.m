%Load the dataset char_c1.mat and mri_c1.mat given on the lab webpage
clear all;
close all;
%%Part 1- Character images
load char_c1.mat;
A=Achar;
%you can choose any column out of the given 7 columns
%Every column corresponds to an image
b=Bchar(:,1);
x1=A\b; %using built-in routine
x1=reshape(x1,[16,16])'; %Every image is 16*16 so you need to reshape the falttened images
x1=imresize(x1,10); %You can use the following code to resize your image
figure;
imshow(x1)
%%Let us add some random noise to the A matrix
A=imnoise(A,'gaussian',0.3);
x=A\b;
x=reshape(x,[16,16])';
x=imresize(x,10); %You can use the following code to resize your image
figure;
imshow(x)
%%% Now add the same gaussian noise to the image x1 and write down your
%%% observation. Which image is closer to the original image? What could be
%%% the reason behind this?

% Adding gaussian noise after reconstructing the image looks closer to the
% original image. I think it's because when you add noise then try to
% reconstruct, you're using data that's already messed up which recreates a
% even more messed up image. But if you reconstruct first, then the image
% would be less messed up looking since the reconstruction helps it not
% look as messed up. 

%%% ################# Enter your code here ######## %%%
A1=Achar;
x2=A1\b; %using built-in routine
x2=imnoise(x2,'gaussian',0.3);
x2=reshape(x2,[16,16])'; %Every image is 16*16 so you need to reshape the falttened images
x2=imresize(x2,10); %You can use the following code to resize your image
figure;
imshow(x2)

%%% ################# END #################### %%



%% Part 2- For MRI images
load mri_c1.mat
A=Amri;
%you can choose any column out of the given 10 columns
%Every column corresponds to a slice of the CT image
b=Bmri(:,9);
x2=A\b; %using built-in routine
x2=reshape(x2,[32,32])';
x2=imresize(x2,10); %You can use the following code to resize your image
figure;
imshow(x2)

%%Let us add some random noise to the A matrix
A=imnoise(A,'gaussian',0.3);
x=A\b;
x=reshape(x,[32,32])';
x=imresize(x,10); %You can use the following code to resize your image
figure;
imshow(x)
%%% Now add the same gaussian noise to the image x2 and write down your
%%% observation. Which image is closer to the original image? What could be
%%% the reason behind this?

% Adding gaussian noise after reconstructing the image looks closer to the
% original image. I think it's because when you add noise then try to
% reconstruct, you're using data that's already messed up which recreates a
% even more messed up image. But if you reconstruct first, then the image
% would be less messed up looking since the reconstruction helps it not
% look as messed up. So same reason

%%%

%%% ################# Enter your code here ######## %%%
A1=Amri;
x2=A1\b;
x2=imnoise(x2,'gaussian',0.3);
x2=reshape(x2,[32,32])';
x2=imresize(x2,10); %You can use the following code to resize your image
figure;
imshow(x2)

%%% ################# END #################### %%


%% Character Data
%%%% One of the datasets, char_c1.mat, contains sequence letters. What word does it spell out?

%%% ################# Enter your code here ######## %%%
figure("Name", "The Whole Word");
A=Achar;
for k = 1:1:7
    b=Bchar(:,k);
    x=A\b;
    x=reshape(x,[16,16])'; 
    x=imresize(x,10); 
    subplot(1,7,k);
    imshow(x);
end

    

%%% ################# END #################### %%

