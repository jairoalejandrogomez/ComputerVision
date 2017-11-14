%Autor: Dr. Jairo Alejandro Gómez. 
%Última modificación: 18 Mayo 2015.
%--------------------------------------------------------------------------
%Descripción: Esta función crea una matriz de salida de las mismas
%dimensiones de la imagen en escala de grises I, y con valores que
%corresponden a etiquetas que indican la pertenencia a un conjunto conexo
%en particular, a partir de los valores de interés que se usen en el vector
%v, y al tipo de adyacencia que se escoja.

%Entradas:
%I: Imagen en escala de grises
%v: vector columna con valores de interés para definir la adyacencia. 
%tipo_adyacencia:  4 
%                  8
%--------------------------------------------------------------------------

function [I2]=encontrar_componentes_conexos(I,tipo_adyacencia,v)
[m,n]=size(I);

I2=0*I;

etiqueta_actual=0;

vector_de_equivalencias=(1:m*n).';

%--------------------------------------------------------------------------
%Paso 1

    %caso 1. Si no tiene vecinos con valores que pertenezcan a v, asigne una nueva etiqueta.
    
    %caso 2. Si tiene solo 1 vecino con valores que pertenecen a v, entonces asigne la etiqueta del vecino
    
    %caso 3. Si tiene más de un vecino con valores que pertenecen a v, asigne una etiqueta del vecino e indique la equivalencia de etiquetas.

%--------------------------------------------------------------------------    

for i=1:m
    for j=1:n
   
        if tipo_adyacencia==4
            pos_vecinos=zeros(2,2);  %la columna 1 del vector representa las filas de los pixeles, la columna 2 del vector representa las columnas de los pixeles.
        elseif tipo_adyacencia==8
            pos_vecinos=zeros(4,2);  %la columna 1 del vector representa las filas de los pixeles, la columna 2 del vector representa las columnas de los pixeles.
        end
        
        pi=i;
        pj=j;
        pv=buscar_intensidad_en_vector(I,pi,pj,v);
        
        if pv==1  %Si el pixel actual pertenece a v, mire los valores de los vecinos.

                %------------------------------------------------------------------
                %Verifique el valor de los 4 vecinos que ya se han cubierto.
                %------------------------------------------------------------------

                %arriba
                qi=i-1;
                qj=j;
                pos_vecinos(1,:)=[qi qj];
                arriba=buscar_intensidad_en_vector(I,qi,qj,v);
                
                %izquierda
                qi=i;
                qj=j-1;
                pos_vecinos(2,:)=[qi qj];
                izquierda=buscar_intensidad_en_vector(I,qi,qj,v);

                adyacencia=[arriba;
                           izquierda];
                           
                num_adyacencias=(arriba + izquierda);   
                
                
                if tipo_adyacencia==8
                    
                    %------------------------------------------------------------------
                    %Verifique el valor de los vecinos diagonales que ya se han cubierto.
                    %------------------------------------------------------------------
                    
                    %superior izquierda
                    qi=i-1;
                    qj=j-1;
                    pos_vecinos(3,:)=[qi qj];
                    sup_izquierda=buscar_intensidad_en_vector(I,qi,qj,v);
                    
                    %superior derecha
                    qi=i-1;
                    qj=j+1;
                    pos_vecinos(4,:)=[qi qj];
                    sup_derecha=buscar_intensidad_en_vector(I,qi,qj,v);
                    
                    %------------------------------------------------------------------
                    adyacencia=[adyacencia;
                                sup_izquierda;
                                sup_derecha];
                    
                    num_adyacencias=num_adyacencias+(sup_izquierda + sup_derecha);
                    %------------------------------------------------------------------
                end
                
                
                if num_adyacencias==0
                   etiqueta_actual=etiqueta_actual+1;
                   I2(i,j)=etiqueta_actual; 
                    
                elseif num_adyacencias==1
                   indice_al_vecino=find(adyacencia==1); 
                   qi=pos_vecinos(indice_al_vecino,1);
                   qj=pos_vecinos(indice_al_vecino,2);
                   etiqueta_del_vecino=I2(qi,qj);
                   I2(i,j)=etiqueta_del_vecino;
                    
                elseif num_adyacencias>=1
                   indices_a_los_vecinos=find(adyacencia==1); 
                   num_equivalencias=size(indices_a_los_vecinos,1);
                       
                   etiquetas_de_los_vecinos=zeros(num_equivalencias,1);
                   
                   for k=1:num_equivalencias
                       indice_al_vecino=indices_a_los_vecinos(k,1);
                       
                       qi=pos_vecinos(indice_al_vecino,1);
                       qj=pos_vecinos(indice_al_vecino,2);
                       
                       etiqueta_del_vecino=I2(qi,qj);
                       etiquetas_de_los_vecinos(k,1)=etiqueta_del_vecino;
                   end
                   
                   min_etiqueta_de_los_vecinos=min(etiquetas_de_los_vecinos);
                   
                   vector_de_equivalencias(etiquetas_de_los_vecinos,1)=min_etiqueta_de_los_vecinos;
                   
                   I2(i,j)=min_etiqueta_de_los_vecinos;
                    
                end
        
        else
            
        end
    end
end
    

%--------------------------------------------------------------------------
%Paso 2. Resuelva todas las equivalencias detectadas de etiquetas y
%seleccione una etiqueta para cada equivalencia, el segundo recorrido
%las resuelve y asigna la etiqueta seleccionada.
%--------------------------------------------------------------------------
 
% %Forma 1: El siguiente código deja regiones con números no secuenciales
% for i=1:m
%     for j=1:n
%         
%         etiqueta_actual=I2(i,j);
%         if etiqueta_actual ~=0
%             I2(i,j)= vector_de_equivalencias(etiqueta_actual,1); 
%         end
%     end
% end


%Forma 2: El siguiente código deja regiones con números secuenciales.
new_offset=etiqueta_actual+1;

for i=1:m
    for j=1:n
        
        etiqueta_pixel_ij=I2(i,j);
        if etiqueta_pixel_ij ~=0
            I2(i,j)= new_offset+vector_de_equivalencias(etiqueta_pixel_ij,1); 
        end
    end
end

I3=I2*0;
nueva_etiqueta=1;
for k=new_offset:(2*etiqueta_actual+1);
    
    T=(I2==k);
    area_current_region=sum(T(:));
    
    if area_current_region>0
       I3=I3+nueva_etiqueta*double(I2==k);
       nueva_etiqueta=nueva_etiqueta+1;
    end
    
end

I2=I3;
%--------------------------------------------------------------------------




    
    