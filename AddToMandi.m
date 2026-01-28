function [ResultPic]=AddToMandi(Picture)
% Inputs:
% Picture - Gray levels image
%
% Outputs:
% ResultPic - Mandi and us image

% Load background picture
background=imread("images\mandi.tif");
background=rgb2gray(background);
background=mat2gray(background);
% Remove white frame
frame=100;
background=background(frame:end-frame,frame:end-frame);
% Show the background
figure
imshow(background)
title('Mandi at the museum')

% Resize the input picture to be 0.8 time the background in the length
Picture=imresize(Picture,size(background,1)/size(Picture,1)/1.25);

% Creating the mask
mask=Picture;
ind=mask>0.8;
% 0 for brighter parts, 1 for darker parts
mask(ind)=0;
mask(~ind)=1;
% Extracting us using multiplication with the mask
Portrait=Picture.*mask;
% Show the portrait
figure
imshow(Portrait)
title('Masking of us')

% Creating background mask to zero the portrait part
bgmask=ones(size(background));
bgmask(end-size(mask,1)+1:end,1:size(mask,2))=1-mask;
% The backgroung without the portrait parts (blackened)
background=background.*bgmask;

% continuation of the portrait in terms of length and width to mach the
% background size (blackened)
addPicture=zeros(size(background));
addPicture(end-size(Portrait,1)+1:end,1:size(Portrait,2))=Portrait;

% Adding the background and the portrait together
ResultPic=background+addPicture;
end
