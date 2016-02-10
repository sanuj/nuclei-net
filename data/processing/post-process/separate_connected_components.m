clc;
clear all;
image=imread('image_test.jpg');
image1=image(26:715-25, 26:603-25,:);

nucleus=imread('2.png');
nucleus=im2bw(nucleus, .5);
nuc = bwlabel(nucleus);
rgb=label2rgb(nuc, 'jet' ,[1 1 1],'shuffle');

figure(1)
subplot(1,2,1), imshow(image1);
subplot(1,2,2), imshow(rgb);

subplot(1,2,2), imshow(image1);
hold on
h = imagesc( rgb );
set( h, 'AlphaData', .2 ); 
subplot(1,2,1), imshow(image1);
