close all
clear all
clc
%--------------------------------------------------------------------------
I=imread('test_image1.jpg');
I=rgb2gray(I);
h1=figure;
imshow(I,[])
title('Imagen de entrada')
%--------------------------------------------------------------------------------
h=ones(3,3); %Esto solo es para definir las dimensiones.
tipo=1;      %LBP convencional.
I2=aplicar_filtrado_lbp(I,h,tipo);

h2=figure;
imshow(I2,[])
title('Imagen de salida usando filtrado no lineal con Local Binary Patterns (LBP)')
%--------------------------------------------------------------------------------
tipo=2;     %LBP U sin recodificar.
I3=aplicar_filtrado_lbp(I,h,tipo);

h3=figure;
imshow(I3,[])
title('Imagen de salida usando filtrado no lineal con Local Binary Patterns (LBP-U sin recodificar)')
%--------------------------------------------------------------------------------
tipo=3; %LBP U codificado
I4=aplicar_filtrado_lbp(I,h,tipo);

h4=figure;
imshow(I4,[])
title('Imagen de salida usando filtrado no lineal con Local Binary Patterns (LBP-U codificado)')
%--------------------------------------------------------------------------------



