image0 = int16(ReadYUV('360\Stitched_left_Dancing360_4116x2048.yuv',4116,2048,0));
image1 = int16(ReadYUV('360\Stitched_right_Dancing360_4116x2048.yuv',4116,2048,0));

[dy, dx, dc] = size(image0);

ds = -40;
de = 20;

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
    sad = RowSimilaritySADWindow2(y,image0,image1,dx,dy,ds,de,4,4);
    %sad = RowSimilarityBilateralFilteringNaive(y,image0,image1,dx,dy,dd,2,2,10.0,10.0);
    %sad = RowSimilarityBilateralFiltering(y,image0,image1,dx,dy,dd,2,2,75.0,80.0);
    %sad = RowSimilarityBilateralFiltering2(y,image0,image1,dx,dy,ds,de,2,2,75.0,80.0);
    %toc
    %WTA
    newdepth0(y,:) = RowWTA2(sad,dx,ds,de); %9.6385 %3x3 9.6563  %5x5 7.48 %15.12
    %newdepth0(y,:) = Row2WTA(sad,dx,dd); %24.06 %3x3 24.18   %5x5 18.8587
    %newdepth0(y,:) = RowGlobal2WTA(sad,dx,dd); %3x3 12.24   %5x5 9.79
    disp(y);
end
toc
%BadPixel(newdepth0*scale,depth0,nonocc0,scale)
imshow(newdepth0,[0 de-ds])

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