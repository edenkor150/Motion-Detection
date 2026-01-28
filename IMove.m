function [M]=IMove(Track)
% Input:
% Track - a vector [n x 2] contains movement instruction for
% stick-man. the first column contains axis:
% 1=movement in the X-axis
% 2=movement in the Y-axis
% the second column contains number of steps in the same
% direction. %
% Output:
% M - a Matrix [50 x 50 x (n*steps)] contains the movements
% step-by-step.

% Creating the stick-man image
M=zeros(50);
M(2:11,4)=1;
M([2 3],[3 5])=1;

% Plotting the steps (f1) and an animated gif (f2)
f1=figure;
% % f2=figure;
% % imshow(M)
% % exportgraphics(f2,'SM50.gif','Append',true);

% Loops to run the dilation and erosion according to track
for i=1:length(Track)
    if Track(i,1)==1
        % X-axis movement
        SE=[0 0 0;0 1 1;0 0 0];
        if Track(i,2)<0
            % If the movement number is negative, flip the SE matrix
            SE=fliplr(SE);
        end
    else
        % Y-axis movement
        SE=[0 0 0;0 1 0;0 1 0];
        if Track(i,2)<0
            % If the movement number is nagetive, flip the SE matrix
            SE=flipud(SE);
        end
    end
    % plot the steps
    set(0,'CurrentFigure',f1)
    subplot(2,ceil(length(Track)/2),i)
    imshow(M)
    title([num2str(i) '/10'])

    % Dilation and erosion on the image and plotting the gif
    % % set(0,'CurrentFigure',f2)
    for j=1:abs(Track(i,2))
        M=imdilate(M,SE);
        % % imshow(M)
        % % exportgraphics(f2,'SM50.gif','Append',true);
    end
    % Erosion while SE is flipped 180 degrees
    for j=1:abs(Track(i,2))
        M=imerode(M,rot90(rot90(SE)));
        % % imshow(M)
        % % exportgraphics(f2,'SM50.gif','Append',true);
    end
end
% Plot the last step
set(0,'CurrentFigure',f1)
subplot(2,ceil(length(Track)/2),10)
imshow(M)
title('10/10')
f1.WindowState="maximized";

sgtitle('Movement frames of the stick-man figure')
end
