function pp=Dijkstra(graph,n_init,n_goal)
n= size(graph,1);
U=zeros(1,n);  % 0: not visited, 1: visited
dist(1:n)=Inf;
prev(1:n)= 0 ;
dist(n_init)=0; 

while 1
    if U(n_goal) == 1  %when n_goal is visited, it breaks
        break
    end
    
    emp=[];
         for i=1:n
             if U(i)==0   % if not visited,
                 emp=[emp dist(i)];
             else  % if visited already,
                 emp=[emp Inf];
             end
         end
         
        [b,C]=min(emp);
            U(C)=1; %mark visited
            
            for i=1:n
                 alt= dist(C)+ graph(C,i);
              if alt<dist(i)
                 dist(i)=alt;
                 prev(i)=C;
              end
            end        
end

%  disp('U'),disp(U)
%  disp('dist'),disp(dist)
%  disp('prev'),disp(prev)

 k=0;
 ini=n_goal;
 path(1)=n_goal;
 while ini~=n_init
 k=k+1;
 ini = prev(ini);
 path(k+1)=ini;
 end
 path= flip(path);
 pp=path;
 disp('path'),disp(path)
end
