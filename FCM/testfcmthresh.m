clear;close all;
im=imread('IM_00240.TIF');
fim=mat2gray(im);
level=graythresh(fim);
bwfim=imbinarize(fim,level);
[bwfim0,level0]=fcmthresh(fim,0);
[bwfim1,level1]=fcmthresh(fim,1);
subplot(1,2,1);
imshow(fim);title('Original');
subplot(1,2,2);
imshow(bwfim1);title(sprintf('FCM1,level=%f',level1));
% im1=medfilt2(bwfim1,[5 5]); %Median filtering the image to remove noise%
% BW = edge(im1,'canny'); %finding edges 
% [imx,imy]=size(BW);
% msk=[0 0 0 0 0 0 0;
%      0 1 1 1 1 1 0;
%      0 1 1 1 1 1 0;
%      0 1 1 1 1 1 0;
%      0 1 1 1 1 1 0;
%      0 1 1 1 1 1 0;
%      0 0 0 0 0 0 0;];
% B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components
% L = bwlabel(B,8);% Calculating connected components
% mx=max(max(L))
% % There will be mx connected components.Here U can give a value between 1 and mx for L or in a loop you can extract all connected components
% % If you are using the attached car image, by giving 17,18,19,22,27,28 to L you can extract the number plate completely.
% [r,c] = find(L==30);  
% rc = [r c];
% [sx sy]=size(rc);
% n1=zeros(imx,imy); 
% for i=1:sx
%     x1=rc(i,1);
%     y1=rc(i,2);
%     n1(x1,y1)=255;
% end % Storing the extracted image in an array
% %figure,imshow(im);
% figure,imshow(im1);
% figure,imshow(B);
% figure,imshow(n1,[]);


% th=graythresh(bwfim1);
% bw=im2bw(bwfim1,th);
% se=strel('disk',3);
% bw=imclose(bwfim1,se);
% bw=imfill(bw,'holes');
% figure,imshow(bw)
% r=regionprops(bw,'all');
% Area=cat(1,r.Area)
% Cent=cat(1,r.Centroid)
% hold on
% for i=1:size(Cent,1)
%     plot(Cent(i,1),Cent(i,2),'rx')
% end

se=strel('disk',3);
bw=imclose(bwfim1,se);
bw=imfill(bw,'holes');
figure,imshow(bw)
L=bwlabel(bw);
f=(L==1);
Area=sum(sum(f));
[R,C]=meshgrid(1:size(bw,2),1:size(bw,1));
cx=sum(sum(R.*f))/Area;
cy=sum(sum(C.*f))/Area;
disp([cx cy])