function [n,Coordinates]=LocateCirc(IMG)
% Inputs:
% IMG - Gray levels image
%
% Outputs:
% n - number of identified patterns.
% Coordinates - a vector with the XY coordinates of the
% required pattern [ n * 2 (X Y)]

% Extracting the pattern by eye
origin=[48 153];
bg=30;
pattern=IMG(origin(1)-bg:origin(1)+bg,origin(2)-bg:origin(2)+bg);
% Showing the pattern
figure
imshow(pattern)
title('Desired pattern')

% Finding all reacurent patterns in the image
hit=false(size(IMG));
% Loop of all pixels in the image (within a frame of 30 pixels high and
% wide)
for x=bg+1:size(IMG,1)-bg
    for y=bg+1:size(IMG,2)-bg
        % Comparisson of the pattern and the appropriate size array of a
        % certain part of the image. Calculation of the number of matching
        % pixels and comparisson to the total number of pixels in the
        % pattern. If matching then True, else False
        hit(x,y)=nnz(IMG(y-bg:y+bg,x-bg:x+bg)==pattern)==(2*bg+1)^2;
    end
end
% Calculating the number of matches
n=nnz(hit);
% Creating coordinates vector
[X,Y]=find(hit);
Coordinates=[X;Y];

% Showing the original image and the identified patterns marked as red X
figure
imshow(IMG)
hold on
scatter(X,Y,[],"red",Marker="x")
title('Original image and identified patterns')
legend('Patterns')
end
