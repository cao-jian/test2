function [result,vtw,vdu,vlo] = costM(routeM,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta)
n=size(routeM,1);
result=zeros(n,1);
vtw=0;
vdu=0;
vlo=0;
if ~isempty(routeM)
    for i=1:n
        if isempty(routeM(i,:))
            result(i)=0;
        else
            %         if Judge(routeM(i,:),cap,duration,demands,a,b,L,s,dist,vehicle,vehicle_use,centernum)
            [vio,vtw,vdu,vlo]=Violate(routeM(i,:),cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta);
            dis=part_length(routeM(i,:),dist,center,centernum);
            result(i)=dis+vio;
            %         else
            %             result(i)=inf;
            %         end
        end
        
    end
else
    result=0;
end

end