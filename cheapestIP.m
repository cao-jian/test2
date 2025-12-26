function [result]= cheapestIP( rv,rfvc,VE,L,a,b,s,dist,demands,comparts,classes,vehicle,centernum,k,alpha,gamma,belta)
leng=length(VE);
outcome=[];
result=zeros(1,3);
cap=vehicle(1,4:end);
duration=vehicle(1,3);
for i=1:leng
    center=vehicle(VE(i),2);
    route=rfvc{i};
    len=length(route);
    LB=costM(route,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta);
    for j=1:len+1;
        if j==1
            temp_r=[rv route];
            LA=costM(temp_r,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta);
            delta=LA-LB; 
            outcome=[outcome;i j delta];
        elseif j==len+1
            temp_r=[route rv];
            LA=costM(temp_r,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta);
            delta=LA-LB;
            outcome=[outcome;i j delta];
        else
            temp_r=[route(1:j-1) rv route(j:end)];
            LA=costM(temp_r,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta);
            delta=LA-LB;
            outcome=[outcome;i j delta];
        end
    end
end
if ~isempty(outcome)
    addC=outcome(:,3);
    [saC,sindex]=sort(addC);
    temp=outcome(sindex,:);
    result(1,1)=temp(1,1);
    result(1,2)=temp(1,2);
    if k==1
        result(1,3)=temp(1,3);
    elseif size(temp,1)<k
        result(1,3)=inf;
    else
        for kk=1:k
            result(1,3)=result(1,3)+temp(k,3)-temp(1,3);
        end
    end
end
end

