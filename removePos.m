function [VC,removed] = removePos(VC,pos)
n=size(VC,1);
removed=[];
for i=1:n
    route=VC{i};
    removed=[removed route(pos{i})];
    
    route(pos{i})=[];
    VC{i}=route;
end
end