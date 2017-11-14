%--------------------------------------------------------------------------
close all 
clear all
clc
%--------------------------------------------------------------------------
%Select an input image.
I=imread('test_image1.jpg');

I2=apply_white_patch_algorithm_to_RGB_image(I);

h1=figure;
imshow(I,[]);
title('Input image')

h2=figure;
imshow(I2,[]);
title('Output image: effect of the white patch algorithm')
%--------------------------------------------------------------------------



