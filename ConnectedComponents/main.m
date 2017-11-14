%--------------------------------------------------------------------------
close all
clear all
clc
%--------------------------------------------------------------------------
%Descripción: Este script encuentra los componentes conexos en una imagen
%en escala de gris a partir del tipo de adyacencia que se use (4 u 8) y de
%un vector v con las intensidades de interés  
%--------------------------------------------------------------------------
%Imagen de entrada en escala de grises. 
disp('Imagen de entrada')
I=[1 1 0 0 0 1 1;
   1 1 3 0 1 1 1;
   0 1 0 0 1 1 0;
   0 0 3 0 2 0 1;
   3 0 0 0 0 0 0;
   3 1 4 0 0 0 0]

%Seleccione el tipo de adyacencia (4 u 8)
%tipo_adyacencia=4;
tipo_adyacencia=8;

%Indique en el vector v los valores de interés para definir la adyacencia.
v=[1;
   3];

disp('Imagen de salida con los componentes conexos resaltados')
I2=encontrar_componentes_conexos(I,tipo_adyacencia,v)
%--------------------------------------------------------------------------