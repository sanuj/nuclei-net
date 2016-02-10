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
figure(1)
nucleus=uint8(255*nucleus);
imshow(nucleus)
neg=~nucleus;

D = (bwdist(neg));
figure(2)
imshow(D,[],'InitialMagnification','fit');

D = -D;
D(neg) = -Inf;

watersh = watershed(D);
rgb = label2rgb(watersh,'jet',[1 1 1],'shuffle');


figure(3)
imshow(rgb,'InitialMagnification','fit')

figure(4)
subplot(1,2,1), imshow(image1);
subplot(1,2,2), imshow(rgb);
