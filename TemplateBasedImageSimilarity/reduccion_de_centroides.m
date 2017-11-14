function [vec_r_reduced,vec_c_reduced]=reduccion_de_centroides(vec_r,vec_c,epsilon)

vec_r_reduced=[];
vec_c_reduced=[];

[mr,nr]=size(vec_r);
[mc,nc]=size(vec_c);

if mr==mc && nr==1 && nc==1 && mr>=1
    
    vec_visited=0*vec_r;
    
    i          =1;  %This is required for the first iteration of the while loop.
    i_next     =-1; %This variable will point to the next centroid that isn't within epsilon pixels of distance from the centroid currently evaluated.
    vec_visited=zeros(mr,1); %0 if a given centroid has not been visited. 1: otherwise.
    vec_visited(1,1)=1;
    v          =find(vec_visited==0);
    
    pending=1; %This is to make sure that the program enters at least one time into the while loop
    
    counter=1;
    
    while pending>0
        
        n_neighbours=1;
        
        r_reduced=vec_r(i,1);
        c_reduced=vec_c(i,1);
        
        i_next     =-1;
        
        for k=1:size(v,1)
            
            j=v(k);
            
            r1=vec_r(i,1);
            r2=vec_r(j,1);
            
            c1=vec_c(i,1);
            c2=vec_c(j,1);
            
            D=sqrt(((r1-r2)^2)+((c1-c2)^2));
            
            if i~=j && D<=epsilon
                
                r_reduced=r_reduced+r2;
                c_reduced=c_reduced+c2;
                
                n_neighbours=n_neighbours+1;
                
                vec_visited(i,1)=1;
                vec_visited(j,1)=1;
                
            elseif i~=j && i_next==-1
                    i_next=j;
            end
        end
        
        
        if  n_neighbours==1
            vec_visited(i,1)=1;
            vec_r_reduced(counter,1)= r_reduced;
            vec_c_reduced(counter,1)= c_reduced;
        
        elseif n_neighbours>1
            
            vec_r_reduced(counter,1)=r_reduced/n_neighbours;
            vec_c_reduced(counter,1)=c_reduced/n_neighbours;
                        
        end
        
        
        counter=counter+1;
        
        if i==mr       %If you just evaluated the last centroid, stop.
            pending=0;
        else
            i=i_next;
            v=find(vec_visited==0);
            pending=sum(v);
        end
    end
else
    disp('vec_r and vec_c should be column vectors with the same number of rows.')
end



