close all
clear all
clc
%--------------------------------------------------------------------------
%Read image
%--------------------------------------------------------------------------
Iin=imread('test_image1.jpg');


%--------------------------------------------------------------------------
%Convert from RGB to chromatic coordinates.
%--------------------------------------------------------------------------
[r,g,b]=RGB_to_chromatic_coordinates(Iin);

factor=0.2;  %1.8;

Iin2=factor*Iin;
[r2,g2,b2]=RGB_to_chromatic_coordinates(Iin2);

%--------------------------------------------------------------------------
%Assemble new image from r and g chromatic coordinates.
%--------------------------------------------------------------------------
Iout=create_RGB_image_from_two_chromatic_coordinates(r,g);

Iout2=create_RGB_image_from_two_chromatic_coordinates(r2,g2);
%--------------------------------------------------------------------------
%Display results
%--------------------------------------------------------------------------
h1=figure;
imshow(Iin,[]);
title('Original image in RGB')

h2=figure;
imshow(Iin2,[]);
title('Image obtained modifying the RGB')


h3=figure;
imshow(Iout,[]);
title('Original image in chromatic coordinates')

h4=figure;
imshow(Iout2,[]);
title('Modified image in chromatic coordinates')
%--------------------------------------------------------------------------