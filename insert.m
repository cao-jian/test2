function [ifvc]=insert(fv,fviv,fvip,rfvc)
    ifvc=rfvc;
    route=rfvc{fviv};
    len=length(route);
    if fvip==1
        temp=[fv route];
    elseif fvip==len+1
        temp=[route fv];
    else
        temp=[route(1:fvip-1) fv route(fvip:end)];
    end
    ifvc{fviv}=temp;
end

