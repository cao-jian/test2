function result = Judge_pd_demands(route,demands,classes)
% NV = size(VC,1);
% for i=1:NV
types=length(classes);
len=length(route);
Load=zeros(types,len+1);

for j = 1:types
    Load(j,1)=sum(demands(route,(j-1)*2+1));
    for k=1:len
        Load(j,k+1) = Load(j,k)- sum(demands(route(k),(j-1)*2+1)) + sum(demands(route(k),(j-1)*2+2));
    end
end

% end

% result = Load(Load>cap);
result=Load;
% if result>0
%     disp('hhhh')
% end


end