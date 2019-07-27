function [allV,graph]= build_PRM(n,k,Q)
V=[]; E=[];
G=zeros(n);
Qp=[Q,Q(:,1)];
plot(Qp(1,:),Qp(2,:))
hold on
for i=1:n
    for j=1:n
        if ~isequal(i,j)
         G(i,j)=inf;
        end
    end
end

while size(V,2)<n
    qrand=[5*rand;5*rand];
    [in,on] = inpolygon(qrand(1),qrand(2),Q(1,:),Q(2,:));
    if isequal(0,in) || isequal(0,on)
        V=[V,qrand];
    end
end

for j=1:size(V,2)
    ind= knnsearch( V', V(:,j)', 'k',k);
    for i=1:size(ind,2)
        Nq(:,i)= V(:,ind(i));
    end
    
    for i=1:size(Nq,2)
        if  isequal( 0, isintersect_linepolygon( [V(:,j),Nq(:,i)] , Q) )
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
