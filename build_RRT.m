function [GEd,qw]=build_RRT(qset, NumNodes, dq, Q)
qinit=qset(:,1); qgoal=qset(:,2);
G=qinit; GE=[];

Qp=[Q,Q(:,1)];
plot(Qp(1,:),Qp(2,:))
hold on


% Gph=zeros(n);
% for i=1:NumNodes
%     for j=1:NumNodes
%         if i~=j
%             Gph(i,j)=inf;
%         end
%     end
% end

for k= 1:NumNodes
    qrand=[rand*5; rand*5];
    C(:,k)=qrand;
    qnear= Nearest_Vertex( C(:,k) , G);
    qnew= qnear + dq*(C(:,k)-qnear)/norm(C(:,k)-qnear);
    S=[qnear,qnew];
    if isequal(0,isintersect_linepolygon(S,Q) )
        G=[G,qnew];
        GE= [GE, [qnear;qnew]];
         plot([qnear(1),qnew(1)],[qnear(2),qnew(2)])
         hold on
%          Gph
    else
        continue
    end
    
    if isequal(qnew,qgoal) || norm(qnew-qgoal)<dq
        GE= [GE, [qnew;qgoal]];
        plot([qnear(1),qnew(1)],[qnear(2),qnew(2)])
        hold on

        break
    end
end

qw=G;
GEd=GE;

end




function vv=Nearest_Vertex(q,G)
d= inf;
n= size(G,2);
for i=1:n
    if norm(G(:,i) - q) < d && ~isequal(G(:,i),q)
        vnew= G(:,i);
        d= norm(G(:,i)-q);
    end
end
vv= vnew;
end