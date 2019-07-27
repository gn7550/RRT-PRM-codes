function [allV,graph]= build_PRMmulti(n,k,Q)  % n:the limit number of nodes, K: number of nearest neighbors
                                        %Q: obstacle
V=[]; E=[];
G=zeros(n);
for i=1:size(Q,3)
Qp(:,:,i)=[Q(:,:,i),Q(:,1,i)];
plot(Qp(1,:,i),Qp(2,:,i))
hold on
end

for i=1:n
    for j=1:n
        if ~isequal(i,j)
         G(i,j)=inf;
        end
    end
end

while size(V,2)<n
    for i=1:size(Q,3)
        qrand=[5*rand;5*rand];
        [in(i),on(i)] = inpolygon(qrand(1),qrand(2),Q(1,:,i),Q(2,:,i));
    end
    AA=zeros(size(Q,3),1)';
    if isequal(AA,in) && isequal(AA,on)
        V=[V,qrand];
    end
end   %get V up to here

for j=1:size(V,2)
    ind= knnsearch( V', V(:,j)', 'k',k);
    for i=1:size(ind,2)
        Nq(:,i)= V(:,ind(i));
    end
    
    for i=1:size(Nq,2)
        for kk=1:size(Q,3)
        aa(kk)=isintersect_linepolygon( [V(:,j),Nq(:,i)] , Q(:,:,kk));
        end
        
        if  isequal( aa, AA )
            %~isequal(V(:,j),E(2*i-1 : 2*i ,1)) && ~isequal(Nq(:,i),E(2*i-1 : 2*i ,2))...
            E=[E ; [V(:,j),Nq(:,i)]];
            G(j,ind(i))=1;
            G(ind(i),j)=1;
            plot([V(1,j),Nq(1,i)],[V(2,j),Nq(2,i)])
            hold on
        end
    end            
end
allV=V;
graph=G;

end