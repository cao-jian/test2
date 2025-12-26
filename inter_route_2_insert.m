function [resultVC,resultVE]=inter_route_2_insert(VC,VE,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta)
resultVC=VC;
resultVE=VE;
NV=length(VE);
% [VC,vehicle_use]=comple_VC(VC,VE,vehicle);
cap=vehicle(1,4:end);
duration=vehicle(1,3);
% [ss,tt]=meshgrid(1:size(VC,1),changed_route);
% routeComb=[ss(:) tt(:)];
% index= routeComb(:,1)<routeComb(:,2);
% routeComb=routeComb(index,:);

routeComb=nchoosek(1:size(VC,1),2);
routeComb=[routeComb;routeComb(:,[2 1])];
index=routeComb(:,1)<=NV;
routeComb=routeComb(index,:);

n=size(routeComb,1);
cost=zeros(n,1);
center=vehicle(VE,2);
center1=center(routeComb(:,1));
center2=center(routeComb(:,2));
optRoute1=cell(n,1);
optRoute2=cell(n,1);
parfor i=1:n
    route1=VC{routeComb(i,1)};
    route2=VC{routeComb(i,2)};
    len1=length(route1);
    len2=length(route2);
    cost1=costM(route1,cap,duration,demands,comparts,classes,a,b,L,s,dist,center1(i),centernum,alpha,gamma,belta);
    cost2=costM(route2,cap,duration,demands,comparts,classes,a,b,L,s,dist,center2(i),centernum,alpha,gamma,belta);
    constCost=cost1+cost2;
    if len2==0
        for k=1:len1-1
            tempR1=route1;
            tempR1(k:k+1)=[];
            tempR2=route1(k:k+1);
            cost1=costM(tempR1,cap,duration,demands,comparts,classes,a,b,L,s,dist,center1(i),centernum,alpha,gamma,belta);
            cost2=costM(tempR2,cap,duration,demands,comparts,classes,a,b,L,s,dist,center2(i),centernum,alpha,gamma,belta);
            tempCost=cost1+cost2;
            if cost(i)<constCost-tempCost
                cost(i)=constCost-tempCost;
                optRoute1{i}=tempR1;
                optRoute2{i}=tempR2;
            end
        end
    else
        %route1ÒÆ³ö route2²åÈë
        
        [num,inpos]=meshgrid(1:len1-1,1:len2+1);
        comb=[num(:) inpos(:)];
%         index= comb(:,1)~=comb(:,2);
%         comb=comb(index,:);
        nn=size(comb,1);
        for j=1:nn
            tempR1=route1;
            tempR1(comb(j,1):comb(j,1)+1)=[];
            tempR2=[route2(1:comb(j,2)-1) route1(comb(j,1):comb(j,1)+1) route2(comb(j,2):end)];
            cost1=costM(tempR1,cap,duration,demands,comparts,classes,a,b,L,s,dist,center1(i),centernum,alpha,gamma,belta);
            cost2=costM(tempR2,cap,duration,demands,comparts,classes,a,b,L,s,dist,center2(i),centernum,alpha,gamma,belta);
            tempCost=cost1+cost2;
            if cost(i)<constCost-tempCost
                cost(i)=constCost-tempCost;
                optRoute1{i}=tempR1;
                optRoute2{i}=tempR2;
            end
        end
    end
end
[maxNum,pos]=max(cost);
if maxNum~=0
    VC{routeComb(pos,1)}=optRoute1{pos};
    VC{routeComb(pos,2)}=optRoute2{pos};
%     [VC,vehicle_use]=delete_VC( VC , vehicle_use);
    resultVC=VC;
    resultVE=VE;
end
end