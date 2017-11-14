clear all
close all
clc
%--------------------------------------------------------------------------
%Matriz con puntos a reducir
%--------------------------------------------------------------------------
P=[0 0
  -1 0
   0 1
   1 1
   1 0
   0 -1
   10 10
   10 11
   9 10
   11 11]

r=P(:,1)
c=P(:,2)

figure
plot(c,r,'*r')

%--------------------------------------------------------------------------
%Aplicar reducci�n de puntos que est�n a menos de epsilon pixeles de
%distancia Eucl�dea.
%--------------------------------------------------------------------------
epsilon=3; %Aquellos centroides que se encuentren a epsilon pixeles de distancia ser�n fusionados en uno solo;
[r,c]=reduccion_de_centroides(r,c,epsilon);

figure;
plot(c,r,'*b')
%--------------------------------------------------------------------------