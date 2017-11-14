%This function computes the chromatic coordinates from a color image in
%RGB.
function [r,g,b]=RGB_to_chromatic_coordinates(I);
r=[];
g=[];
b=[];

I=double(I);

[m,n,k]=size(I);

if k==3

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

S=R+G+B;

r=R./S;
g=G./S;
b=B./S;


else
   disp('The input image should have 3 color channels: R G B') 
end



