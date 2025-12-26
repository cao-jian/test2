function result = Judge_violate_pos(VC,VE,vehicle,cap,demands,a,b,L,s,dist,centernum,comparts,classes)
n=size(VC,1);
result=cell(n,1);
centers=vehicle(VE,2);
pos=[];
for i = 1:n
    route=VC{i};
    center=centers(i);
    if ~isempty(route)
        [bs,back,arr]= begin_s( route,a,b,s,dist,center,centernum );
        leav=b(route);
        leav=leav';
        %         wait=bs-arr;
        %     vtw=arr-leav;da
        vtw=arr-leav;
        pos1=find(vtw>0);
        
        
        %         fs=feasible(leav,wait,bs);
        %         vdu=max(back-0-fs-duration,0);
        
        
%         init_v=containers.Map('KeyType','double','ValueType','any');
%         tempde=demands(route);
%         tempco=comparts(route);
%         count=1;
%         for j=classes
%             in= tempco==j;
%             init_v(count)=find(cumsum(tempde(in))>cap(count));
%             count=count+1;
%         end
        pos=pos1;
%         for k=1:length(classes)
%             pos=union(pos,init_v(k));
%         end
    else
        pos=[];
    end
    result{i}=pos;
    
end



end