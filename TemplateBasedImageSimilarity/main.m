%--------------------------------------------------------------------------
%Descripción: Este script permite buscar una imagen pequeña en otra más
%grande usando coincidencia de plantillas (template matching) y varias
%métricas de similitud. El proceso puede verse como un filtrado no lineal.
%--------------------------------------------------------------------------
close all
clear all
clc
%--------------------------------------------------------------------------
%Imagen completa (en escala de grises de 0-1)
Ic=imread('imagen_donde_se_va_a_buscar.png');
I=rgb2gray(Ic);
I=double(I)/255;

% La siguiente línea permite filtrar la imagen de entrada con un filtro
% paso bajo tipo promedio de 3x3, para emular un caso en el que la plantilla
% no corresponde exactamente con lo que está en la imagen.
% I=calcular_similaridad(I,(1/9)*ones(3,3),0);

%--------------------------------------------------------------------------
%Objeto que se va a buscar (en escala de grises de 0-1)
h=imread('imagen_con_plantilla_de_interes.png');
h=double(h)/255;
%--------------------------------------------------------------------------

%Nota: La opción 1 es la que mejor funciona para este ejemplo.

opcion=1    %1: SAD: Sum of absolute differences.
            %2: SSD: Sum of squared differences.
            %3: NCC: normalized cross correlataion.
            %4. ZNCC: zero-mean normalized cross correlataion.

factor_disimilaridad   = 1.02; %Aplica SAD y SSD.
factor_similaridad     = 0.97; %Aplica para NCC y ZNCC.

Isimilaridad           = calcular_similaridad(I,h,opcion);

%--------------------------------------------------------------------------
%Búsqueda de objeto en imagen.
%--------------------------------------------------------------------------
if opcion==1 || opcion==2
    
    min_Idisimil=min(min(Isimilaridad));
    [r,c,v]=find(Isimilaridad<=(factor_disimilaridad*min_Idisimil));
    
elseif opcion==3 || opcion==4
    
    max_Isimil=max(max(Isimilaridad));
    [r,c,v]=find(Isimilaridad>=(factor_similaridad*max_Isimil));
    
end

%--------------------------------------------------------------------------
%Reducción de centroides usando un algoritmo "parecido" a KNN.
%--------------------------------------------------------------------------
sprintf('%s %d','Num centroides encontrados por el algoritmo:',size(r,1))

epsilon=160; %Aquellos centroides que se encuentren a epsilon pixeles de distancia serán fusionados en uno solo.
             %Este parámetro depende de que tan cerca pueden estar dos.
             %ROIS, y está acotado por la máxima distancia en la imagen.
[r,c]=reduccion_de_centroides(r,c,epsilon);

sprintf('%s %d','Num centroides después de la reducción por cercanía:',size(r,1))

%--------------------------------------------------------------------------
%Gráficas.
%--------------------------------------------------------------------------

[mh,nh]=size(h);
ul_y=r-floor(mh/2);  %Coordenada y del punto superior izquierdo (Upper-left y coordinate).
ul_x=c-floor(nh/2);  %Coordenada x del punto superior izquierdo (Upper-left x coordinate).
width = nh;          %Ancho del rectángulo de interés (width of the bounding box).
height= mh;          %Alto  del rectángulo de interés (Height of the bounding box).

h1=figure;
imshow(h,[]);
title('Imagen que se está buscando')

h2=figure;
imshow(Isimilaridad,[],'InitialMagnification','fit');
title('Imagen de salida de disimilaridad')
dibujar_rectangulos(h2,r,c,mh,nh);    %Esta función añade varios rectángulos alrededor de las regiones de interés (This function adds multiple bounding boxes around rois).

h3=figure;
imshow(I,[],'InitialMagnification','fit');
title('Imagen de entrada con objeto encontrado')
dibujar_rectangulos(h3,r,c,mh,nh);    %Esta función añade varios rectángulos alrededor de las regiones de interés (This function adds multiple bounding boxes around rois).

%--------------------------------------------------------------------------


