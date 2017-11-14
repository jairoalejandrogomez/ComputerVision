%I: Imagen en escala de grises
%i: fila.
%j: columna.
%v: vector columna con valores de interés para definir la adyacencia. 
function bandera=buscar_intensidad_en_vector(I,i,j,v)
[m,n]=size(I);

if i>=1 && i<=m && j>=1 && j<=n
    r=I(i,j); %Intensidad del pixel
    
    s=find(v==r);      %Busque r en v.
    
    if length(s)== 0
       bandera=0;      %No se encontró la intensidad del pixel en el vector v.
    else
       bandera=1;      %Si se encontró la intensidad del pixel en el vector v.
    end
    
else
    bandera=0; %El pixel solicitado está por fuera de la imagen.
    
end
