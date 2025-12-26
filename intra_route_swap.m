function [resultVC,resultVE]=intra_route_swap(VC,VE,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta)
NV=length(VE);
vehicle_use=VE;
cap=vehicle(1,4:end);
duration=vehicle(1,3);
optRotue=VC;
center=vehicle(vehicle_use,2);
parfor i=1:NV
    route=VC{i};
    len=length(route);
    if len>1
        comb=nchoosek(1:len,2);
        n=size(comb,1);
        tempRoute=zeros(n,len);
        constCost=costM(route,cap,duration,demands,comparts,classes,a,b,L,s,dist,center(i),centernum,alpha,gamma,belta);
        for j=1:n
            tempR=route;
            temp=route(comb(j,1));
            tempR(comb(j,1))=tempR(comb(j,2));
            tempR(comb(j,2))=temp;
            tempRoute(j,:)=tempR;
        end
        
        cost=costM(tempRoute,cap,duration,demands,comparts,classes,a,b,L,s,dist,center(i),centernum,alpha,gamma,belta);
        cost=constCost-cost;
        [tempC,pos]=max(cost);
        if tempC~=-inf && tempC>0
            optRotue{i}=tempRoute(pos,:);
        else
            optRotue{i}=route;
        end
    else
        optRotue{i}=route;
    end
end
resultVC=optRotue;
resultVE=vehicle_use;
end