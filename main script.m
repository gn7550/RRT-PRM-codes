%% Prob 1. Run RRT
close all
clear
clc
qset=[0 3;0 3]; % 1st column: q_initial, 2nd: q_goal
NumNodes=2000;
dq=0.1;
Q=[1 2 2 1;1 1 2 2];   %obstacle

[GE,qw]=build_RRT(qset, NumNodes, dq, Q);   %GE is [qnear ; qnew]
%the first and last columns have q_init and q_goal
qc1=GE(1:2,:); qc2=GE(3:4,:);
qc1=flip(qc1,2); qc2=flip(qc2,2);
qpath=[qc1(:,1)];

while ~isequal(qpath(:,1),qset(:,1))
for i=1:size(GE,2)
    if isequal(qpath(:,1), qc2(:,i))
        qpath=[qc1(:,i) qpath];
    end
end
end
qpath= [qpath qset(:,2)];
disp(qpath)
plot(qpath(1,:),qpath(2,:),'b--o')
hold on
%% 2. Run PRM
    %get the graph by running PRM and map lot
    %V is all the qs'
    close all
    clc
    clear
    qset=[0 3;0 3];  % 1st column: q_initial, 2nd: q_goal
    n=500;
    k=5;
    Q=[1 2 2 1;1 1 2 2];   %obstacle
    
[V,G]=build_PRM(n,k,Q);
d1=inf; d2=inf;
for i=1:size(V,2)   %this loop is find nearest nodes to qset
    if norm(V(:,i)-qset(:,1))<d1
    node1=V(:,i);
    d1=norm(V(:,i)-qset(:,1));
    ind1=i;
    end
    if norm(V(:,i)-qset(:,2))<d2
    node2=V(:,i);
    d2=norm(V(:,i)-qset(:,2));
    ind2=i;
    end
end
% so we have node1 and 2 which are nearest to q_init and q_goal

   %run Dijkstra for indices of the shortest path
n_init=ind1; n_goal=ind2;  %set initial and goal node
path=Dijkstra(G,n_init,n_goal); %this gives indices

for ii=1:size(path,2)
repath(:,ii)= V(:,path(ii));
end
repath=[qset(:,1) repath qset(:,2)];
plot(repath(1,:),repath(2,:),'b--o')
hold on