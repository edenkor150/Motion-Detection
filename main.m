%% 1.2
% Load the picture
RawIMG=imread('IMG_0989.jpg');
% Convert to grayscale
GrayIMG=rgb2gray(RawIMG);
% Normalize
NormIMG=mat2gray(GrayIMG);
TransIMG=NormIMG;

% Transformation visualization
transformation=ones(1,1001);
transformation([1:300 601:1001])=0;
figure
plot(0:0.001:1,transformation)
title('Transformation visualization')
xlabel('Gray level')
ylabel('Multiplication factor')
ylim padded

% Show img
figure
subplot(121)
imshow(NormIMG)
title('Original image')

% Transformation
TransIMG(NormIMG<=0.3|NormIMG>=0.6)=0;
% Show img
subplot(122)
imshow(TransIMG)
title('Transformed image')

% Histograms
f=figure(WindowState="maximized");
subplot(121)
imhist(NormIMG)
title('Original image',FontSize=18)
xlabel({'','','Gray level'},FontSize=16)
ylabel('Count',FontSize=16)
ylim([0 2.5e4])

subplot(122)
imhist(TransIMG)
title('Transformed image',FontSize=18)
xlabel({'','','Gray level'},FontSize=16)
ylabel('Count',FontSize=16)
ylim([0 2.5e4])

%% 1.4
% Function activation
NegIMG=Negative(NormIMG);
% Plot Negative image
figure
subplot(121)
imshow(NormIMG)
title('Original image')

subplot(122)
imshow(NegIMG)
title('Negative image')

%% 1.5
% Partialy linear inversible transformation
f=0:0.01:1;
g=zeros(size(f));

ind=f<=0.75;
g(ind)=f(ind)/3;
g(~ind)=3*f(~ind)-2;
% Plotting the transformation
figure
subplot(121)
plot(f,g)
title('Transformation T_1\{f[m,n]\}')
xlabel('f[m,n] values')
ylabel('g[m,n] values')
grid on

subplot(122)
plot(g,f)
title('Inverse transformation T_1\{g[m,n]\}')
xlabel('g[m,n] values')
ylabel('f[m,n] values')
grid on

% Partialy linear non-inversible transformation
f=0:0.01:1;
g=zeros(size(f));

ind=f<0.5;
g(ind)=f(ind);
g(~ind)=1-f(~ind);
% Plotting the transformation
figure
plot(f,g)
title('Transformation T_2\{f[m,n]\}')
xlabel('f[m,n] values')
ylabel('g[m,n] values')
ylim([0 1])
grid on

%% 1.8
% Load the picture
RawIMG=imread('IMG20240117191010.jpg');
% Convert to grayscale
GrayIMG=rgb2gray(RawIMG);
% Normalize
mandiIMG=mat2gray(GrayIMG);

% Function activation
UsAndMandi=AddToMandi(mandiIMG);

% Plotting the result
figure
imshow(UsAndMandi)
title('Stinky Mandi and us at the museum')

%% 2.3
% Define Matrices for the filters
Lap_filter = [-1 -1 -1; -1 8 -1; -1 -1 -1];
avg_filter = (1/9) * ones(3, 3);

% Correct the padding to create a 30x30 matrix
padded_Lap = padarray(Lap_filter, [13 13], 'post');
padded_avg = padarray(avg_filter, [13 13], 'post');

padded_Lap = padarray(padded_Lap, [14 14], 'pre');
padded_avg = padarray(padded_avg, [14 14], 'pre');

% FFT on the padded filters
fft_laplacian = fft2(padded_Lap);
fft_average = fft2(padded_avg);

% Display the magnitude using surface
figure(WindowState="maximized");
subplot(121)
surface(-15:14,-15:14, abs(fftshift(fft_laplacian)));
title('Laplacian Filter FFT');
colormap;
colorbar;

subplot(122)
surface(-15:14,-15:14, abs(fftshift(fft_average)));
title('Average Filter FFT');
colormap;
colorbar;

%% 2.5
original=double(imread('images\lenna.jpg'))/255;
%imshow(original)

% Creating the average filters of different sizes by fspecial function
H3=fspecial('average');
H4=fspecial('average',[4 4]);
H5=fspecial('average',[5 5]);

% Blurring the image - apply the filter with zero padding
blurred3 = imfilter(original, H3, 'same');
blurred4 = imfilter(original, H4, 'same');
blurred5 = imfilter(original, H5, 'same');

%plotting original and blurred pictures
figure
subplot(2,2,1)
imshow(original);
title('Original image')
subplot(2,2,2)
imshow(blurred3);
title('Blurred lenna using 3x3 average filter')
subplot(2,2,3)
imshow(blurred4);
title('Blurred lenna using 4x4 average filter')
subplot(2,2,4)
imshow(blurred5);
title('Blurred lenna using 5x5 average filter')

% Using laplacian filter to improve the picture quality
% Convert the image to the frequency domain
F_blu3 = fft2(double(blurred3));
F_blu4 = fft2(double(blurred4));
F_blu5 = fft2(double(blurred5));
% Create the frequency domain filter (same size as the image)
F_filter = fft2(double(Lap_filter),size(original,1),size(original,2));
% Apply the filter in the frequency domain
F_filtered3 = F_blu3 .* F_filter;
F_filtered4 = F_blu4 .* F_filter;
F_filtered5 = F_blu5 .* F_filter;
% Convert back to the spatial domain
filtered_imageB3 = ifft2(F_filtered3);
filtered_imageB4 = ifft2(F_filtered4);
filtered_imageB5 = ifft2(F_filtered5);

%plotting original and the pictures after improving (using laplacian
%filter)
figure
subplot(2,2,1)
imshow(original);
title('Original image')
subplot(2,2,2)
imshow(filtered_imageB3+original);
title('Filtered lenna for Blurred3')
subplot(2,2,3)
imshow(filtered_imageB4+original);
title('Filtered lenna for Blurred4')
subplot(2,2,4)
imshow(filtered_imageB5+original);
title('Filtered lenna for Blurred5')

% improving the picture using fspecial function
LapF=fspecial('laplacian');
% improve the image - apply the filter 
fil3 = imfilter(blurred3, LapF);
fil4 = imfilter(blurred4, LapF);
fil5 = imfilter(blurred5, LapF);

%plotting original and the pictures after improving (using laplacian
%filter by fspecial function)
figure
subplot(2,2,1)
imshow(original);
title('Original image')
subplot(2,2,2)
imshow(fil3+original);
title('Filtered lenna for Blurred3')
subplot(2,2,3)
imshow(fil4+original);
title('Filtered lenna for Blurred4')
subplot(2,2,4)
imshow(fil5+original);
title('Filtered lenna for Blurred5')

% MSE calculation
% for laplacian
err1 = immse(blurred3,filtered_imageB3+original);
err2 = immse(blurred4,filtered_imageB4+original);
err3 = immse(blurred5,filtered_imageB5+original);
% using fspecial
err4 = immse(blurred3,fil3+original);
err5 = immse(blurred4,fil4+original);
err6 = immse(blurred5,fil5+original);

%% 2.6
% upload image
pic = imread('images/lenna.jpg');
pic = im2double(pic);
%pic = rgb2gray(pic); is already gray

P = [0.1 0.5 0.9]; 

%plotting
figure
subplot(2,2,1)
imshow(pic)
title('original')
for i=1:3
 imf = FreqCanceling(pic,1-P(i));
 subplot(2,2,i+1)
 imshow(imf)
 title([num2str(P(i) * 100), '% filtered']);
end

%% 2.8
IM = double(imread('coins.png'))/255;
noisy_I = imnoise(IM, 'salt & pepper');
filtered_I_gaussian = CleanSP(noisy_I, 'Gaussian', 3, 3);
filtered_I_median = CleanSP(noisy_I, 'Median', 3, 3);

figure
subplot(2,2,1)
imshow(IM)
title('Original Image');
subplot(2,2,2)
imshow(noisy_I)
title('Noisy Image');
subplot(2,2,3)
imshow(filtered_I_gaussian)
title('Filtered Image (Gaussian)');
subplot(2,2,4)
imshow(filtered_I_median)
title('Filtered Image (Median)');

%% 3.2
% Loading circles picture
circles=imread("images\circles.png");
% Function activation
[n,coordinates]=LocateCirc(circles);

%% 3.3
% Loading the image
Iexam=imread('images\Iexam.tif');
% Normalizing the matrix
Iexam=mat2gray(Iexam);

% Showing the image
figure
imshow(Iexam)
title('Eye exam')

% Cell vector of the noisy images
IexamSP={imnoise(Iexam,'salt & pepper',0.01),imnoise(Iexam,'salt & pepper',0.03),imnoise(Iexam,'salt & pepper',0.2)};
% Allocating memory
IexamFiltered=IexamSP;
percentages=[1,3,20];
% Loop for filtering and showing the results
figure
for i=1:3
    % Filtering using opening and then closing of the noisy images
    IexamFiltered{i}=imclose(imopen(IexamSP{i},ones(3)),ones(3));

    % Plotting the noisy images
    subplot(2,3,i)
    imshow(IexamSP{i})
    title([num2str(percentages(i)) '%'])
    if i==1
        ylabel('Noisy picture')
    end
    % Plotting the filtered images
    subplot(2,3,i+3)
    imshow(IexamFiltered{i})
    if i==1
        ylabel('Filtered picture')
    end
end
sgtitle('Salt & Peper noise and filtered images')

%% 3.4
% Creating the stick-man
smIMG=zeros(20);
smIMG(10:19,4)=1;
smIMG([10 11],[3 5])=1;

% Plotting the stick-man
figure
subplot(131)
imshow(smIMG)
title('Original image')
% Moving the stick-man using dilation
SEd=[0 0 0 ;0 1 1;0 0 0];
for i=1:13
    smIMG=imdilate(smIMG,SEd);
end
% Plotting
subplot(132)
imshow(smIMG)
title('Dilated image')

% Moving the stick-man using erosion
SEe=[0 0 0 ;1 1 0;0 0 0];
for i=1:13
    smIMG=imerode(smIMG,SEe);
end
% Plotting
subplot(133)
imshow(smIMG)
title('Eroded image')

%% 3.5
% Creating track matrix
track=[1 25;2 10;1 -15;2 20;1 -11;1 35;2 -23;2 30;1 9];
% Function activation
M=IMove(track);

%% 4.2
% Loading the image
saturn=imread('saturn.jpg');
% Converting to gray-scale
saturn=rgb2gray(saturn);
% Normalizing the image
saturn=mat2gray(saturn);

% Creating the element for LoG filter
h=fspecial("log");

% Plotting the results
figure
subplot(121)
imshow(saturn)
title('Original image')

subplot(122)
imshow(imfilter(saturn,h))
title('Image after LoG')
