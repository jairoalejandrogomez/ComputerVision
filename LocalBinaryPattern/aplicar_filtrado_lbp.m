function I2=aplicar_filtrado_lbp(I,h,tipo)

I=double(I);

[m,n]=size(I);

I_lbp=zeros(m,n);
I_lbpu=zeros(m,n);

I2=zeros(m,n);

[mh,nh]=size(h);

mzp=m+mh-1;
nzp=n+nh-1;

fila_inicial   =1+round((mh-1)/2);
columna_inicial=1+round((nh-1)/2);

fila_final     =fila_inicial+m-1;
columna_final  =columna_inicial+n-1;

Izp=zeros(mzp,nzp);
Izp(fila_inicial:fila_final,columna_inicial:columna_final)=I;

num_pixeles_ventana=mh*nh;
centro=1+floor((num_pixeles_ventana-1)/2);
vector_de_pesos=(2.^(0:(num_pixeles_ventana-1-1))).';

for i=1:m
    for j=1:n
        submatriz=Izp(i:i+mh-1,j:j+nh-1);
        
        intensidad_pixel_central=I(i,j);
        codigo_LBP=double(submatriz>=intensidad_pixel_central); %Matriz de unos y ceros.
        codigo_LBP=codigo_LBP(:);  %vector de num_pixeles_ventana x 1 elementos.
        codigo_LBP(centro)=[];     %vector de (num_pixeles_ventana-1)x 1 elementos.
        
        %LBP. Código decimal.
        valor_decimal_codigo_LBP=sum(vector_de_pesos.*codigo_LBP);
        I_lbp(i,j)=valor_decimal_codigo_LBP;
                
        %LBP-U.
        num_cambios_U=calcular_cambios_en_vector_binario(codigo_LBP);
        I_lbpu(i,j)=num_cambios_U;
        
    end
end

switch tipo
    case 1 %LBP. Código decimal.
        I2=I_lbp;
                
    case 2 %LBP-U.
        I2=I_lbpu;
                
    case 3  %LBP-U codificado.
        I2=I_lbpu;
        k=(num_pixeles_ventana-1);
        LUT=calcular_LUT_para_codificar_valores_LBP_U(k);
        I2=LUT(I2+1);
    otherwise
end

end
%--------------------------------------------------------------------------
function num_cambios=calcular_cambios_en_vector_binario(v)
num_cambios=[];

[m,n]=size(v);

if n==1
    %Diferenciar y sumar.
    v2=abs(diff(v));
    num_cambios=sum(v2);
else
    disp('El vector de entrada debe ser tipo columna')
end

end
%--------------------------------------------------------------------------




