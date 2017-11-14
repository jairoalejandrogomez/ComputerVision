function LUT2=calcular_LUT_para_codificar_valores_LBP_U(k)

%k=número de bits.

L=2^k;
LUT=(-1)*ones(L,1);

v1=(0:(L-1)).';
vec_u=zeros(L,1);

for i=0:L-1
    
    ibinario=dec2binvec(i,k);
    u=sum(abs(diff(double([ibinario ibinario(1,1)]))));   %La concatenación permite que la diferenciación sea circular.
    
    vec_u(i+1,1)=u;
    
    if u==2
        LUT(i+1)=i;
    elseif u==0 && i==0
        LUT(i+1)=0;
    elseif u==0 && i==(L-1)
        LUT(L)=(L-1);
    else    
        LUT(i+1)=-1;  %-1 nunca sucede.
    end
end

%[v1 vec_u LUT]

v_replicado=find(LUT==-1);
n_replicado=length(v_replicado);
no_replicados=256-n_replicado+1;  %El +1 es por el replicado

LUT2=LUT*0;
LUT2(1,1)=0;
LUT2(L,1)=no_replicados-1;
LUT2=LUT2+(no_replicados-2)*double(LUT==-1);

etiqueta=1;
for i=0:L-1
    if vec_u(i+1)==2
    indice=LUT(i+1);
    LUT2(indice+1)=etiqueta;
    etiqueta=etiqueta+1;
    end
end

