function I2=apply_white_patch_algorithm_to_RGB_image(I)

I=double(I);
[m,n,k]=size(I);
I2=zeros(m,n,k);

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

Rmax=max(R(:));
Gmax=max(G(:));
Bmax=max(B(:));

Rout=(255/Rmax)*R;
Gout=(255/Gmax)*G;
Bout=(255/Bmax)*B;

I2(:,:,1)=Rout;
I2(:,:,2)=Gout;
I2(:,:,3)=Bout;


I2=uint8(I2);