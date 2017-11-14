function dibujar_rectangulos(handle,vec_r,vec_c,mh,nh)

[mr,nr]=size(vec_r);
[mc,nc]=size(vec_c);

if mr==mc && nr==1 && nc==1
   
    for i=1:mr
        r=vec_r(i,1);
        c=vec_c(i,1);
        
        ul_y=r-floor(mh/2);
        ul_x=c-floor(nh/2);
        width = nh;
        height= mh;
        
        figure(handle)
        hold on 
        rectangle('Position',[ul_x,ul_y,width,height],'EdgeColor','r','LineWidth',1)
        hold off
    end

else 
    disp('The number of elements of r and c are different.')
    
end