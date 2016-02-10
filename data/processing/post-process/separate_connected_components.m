clc;
clear all;
image=imread('PrognosisTMABlock1_A_3_1_H&E_4_px.jpg');
image1=image(26:715-25, 26:603-25,:);
%image_annotated=imread('maskWithBoundaryPrognosisTMABlock1_A_3_1_H&E.png');
boundary=imread('1.png');
boundary=boundary(:,:,1);
nucleus=imread('2.png');
se = [0 1 0;0 1 0;0 1 0];
% for i=1:2
%     nucleus= imerode(nucleus, se);
% end
nucleus=im2bw(nucleus, .5);
nuc = bwlabel(nucleus);
rgb=label2rgb(nuc, 'jet' ,[1 1 1],'shuffle');
figure(1)
subplot(1,2,1), imshow(image1);
subplot(1,2,2), imshow(rgb);

figure(2)
% imshow(image1)
% hold on
% h = imagesc( rgb );
% set( h, 'AlphaData', .2 ); 
subplot(1,2,2), imshow(image1);
hold on
h = imagesc( rgb );
set( h, 'AlphaData', .2 ); 
subplot(1,2,1), imshow(image1);