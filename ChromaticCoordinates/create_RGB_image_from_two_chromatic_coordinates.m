function I2=create_RGB_image_from_two_chromatic_coordinates(r,g)
I2=[];

b=1-(r+g);

I2(:,:,1)=r;
I2(:,:,2)=g;
I2(:,:,3)=b;


