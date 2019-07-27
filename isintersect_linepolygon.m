function b= isintersect_linepolygon(S,Q)
q=[Q Q(:,1)];
p0=S(:,1); p1=S(:,2);


if isequal(p0,p1)
    [in,on] = inpolygon(S(1,1), S(2,1), q(1,:), q(2,:));
    if isequal(in,1) || isequal(on,1)
    b=1;
    %disp('point in convex hull')
    return
    end
else
    tE= 0; tL= 1;
    ds= p1-p0;
    m=size(Q,2);
    for i=1:m
        e(:,i)= q(:,i+1)-q(:,i);
        nn= [cos(-90) -sin(-90); sin(-90) cos(-90)]*e(:,i);
        n(:,i)= nn/norm(nn);
        N= -( p0 - q(:,i) )'*n(:,i);
        D= ds'*n(:,i);
        if D==0
            if N < 0
                b=0;
                %disp('b is false')
                return
            end
        end
        t= N/D;
        
        if D<0
            tE= max(tE,t);
            if tE > tL
                b=0;
                %disp('b is false')
                return
            end
        elseif D>0
            tL= min(tL,t);
            if tL<tE
                b=0;
                %disp('b is false')
                return
            end
        end
    end
    if tE<=tL
        b=1;
        %disp('b is true')
        return
    else
        b=0;
        %disp('b is false')
    end
end
b=1;
%disp('b has intersection')
end
