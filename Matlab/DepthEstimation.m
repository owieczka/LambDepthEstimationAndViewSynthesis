image0 = int16(imread('cones\im2.png'));
image1 = int16(imread('cones\im6.png'));
depth0 = imread('cones\disp2.png');
depth1 = imread('cones\disp6.png');
nonocc0 = imread('cones\nonocc2.png');

[dy, dx, dc] = size(image0);

dd = 64;

scale = 4;

newdepth0 = zeros(dy,dx,'uint8');
%profile on
%profule clear
%profile report
%profile off

%Biraleral Filtering
%In¿ynierka SAD from in¿ynierka
tic
for y=[1:dy]
    %SAD
    %tic
    %sad = RowSimilaritySADWindowNaive(y,image0,image1,dx,dy,dd,2,2);
    %sad = RowSimilaritySADWindow(y,image0,image1,dx,dy,dd,2,2);
    %sad = RowSimilarityBilateralFilteringNaive(y,image0,image1,dx,dy,dd,2,2,10.0,10.0);
    sad = RowSimilarityBilateralFiltering(y,image0,image1,dx,dy,dd,2,2,75.0,80.0);
    %toc
    %WTA
    newdepth0(y,:) = RowWTA(sad,dx,dd); %9.6385 %3x3 9.6563  %5x5 7.48 %15.12
    %newdepth0(y,:) = Row2WTA(sad,dx,dd); %24.06 %3x3 24.18   %5x5 18.8587
    %newdepth0(y,:) = RowGlobal2WTA(sad,dx,dd); %3x3 12.24   %5x5 9.79
    %disp(y);
end
toc
BadPixel(newdepth0*scale,depth0,nonocc0,scale)
imshow(newdepth0,[0 dd-1])

%y=100;
%sadWindows = RowSimilaritySADWindow(y,image0,image1,dx,dy,dd,1,1);
%sadFilter = RowSimilarityBilateralFiltering(y,image0,image1,dx,dy,dd,1,1,10000000.0,1000000.0);
%figure(1)
%imshow(sadWindows,[0 200]);
%figure(2)
%imshow(sadFilter,[0 200]);
%diffsad=abs(sadWindows-sadFilter);
%figure(3)
%imshow(diffsad)