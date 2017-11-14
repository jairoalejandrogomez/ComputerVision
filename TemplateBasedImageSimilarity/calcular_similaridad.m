function I2=calcular_similaridad(I,h,option)

I=double(I);  
h=double(h);

[m,n]=size(I);

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
        

mean_h=mean(h(:));          %Media de la máscara. Se usa en ZNCC
std_h =std(h(:));           %Desviación estándar de la máscar. Se usa en NCC.
sum_sum_h_squared=sum(sum(h.^2));

h_with_zero_mean=h-mean_h; %Máscara con media = 0. Se usa en ZNCC
sum_sum_h_with_zero_mean_squared=sum(sum(h_with_zero_mean.^2));
std_h_with_zero_mean=std(h_with_zero_mean(:));          %Desviación estándar de la máscara. Se usa en ZNCC.  


for i=1:m
    for j=1:n
        submatriz=Izp(i:i+mh-1,j:j+nh-1);
        
        switch option   %For the equations see: https://siddhantahuja.wordpress.com/tag/normalized-cross-correlation/
        
        case 1
        %------------------------------------------------------------------
        %SAD: Sum of absolute differences.
        %------------------------------------------------------------------
        I2(i,j)=sum(sum(   (abs(submatriz-h)) ));
        
        case 2
        %------------------------------------------------------------------
        %SSD: Sum of squared differences.
        %------------------------------------------------------------------
        I2(i,j)=sum(sum(   ((submatriz-h).^2) ));
        
            
        case 3
        %------------------------------------------------------------------
        %NCC: normalized cross correlataion.
        %------------------------------------------------------------------
                
        sum_sum_submatriz_squared=sum(sum(submatriz.^2));
        
        if sum_sum_h_squared>0 && sum_sum_submatriz_squared>0
            I2(i,j)=sum(sum(submatriz.*h))/sqrt(sum_sum_submatriz_squared*sum_sum_h_squared);
        else
            I2(i,j)=-1;    
        end
            
        case 4
        %------------------------------------------------------------------
        %ZNCC: zero-mean normalized cross correlataion.  
        %------------------------------------------------------------------
        
        %Nota: Creo que en matlab el comando es normxcorr2
        
        mean_submatriz          =mean(submatriz(:));
        submatriz_with_zero_mean=submatriz-mean_submatriz; 
        sum_sum_submatriz_with_zero_mean_squared=sum(sum(submatriz_with_zero_mean.^2));
        
        
        if sum_sum_submatriz_with_zero_mean_squared>0 && sum_sum_h_with_zero_mean_squared>0
            I2(i,j)=sum(sum(submatriz_with_zero_mean.*h_with_zero_mean))/sqrt(sum_sum_submatriz_with_zero_mean_squared*sum_sum_h_with_zero_mean_squared);
        else
            I2(i,j)=-1; 
        end
        %------------------------------------------------------------------
        
        otherwise
        %------------------------------------------------------------------
        %Filtrado lineal
        %------------------------------------------------------------------
        I2(i,j)=sum(sum(submatriz.*h));
        end
        
    end
end


