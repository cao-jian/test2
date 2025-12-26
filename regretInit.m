function [resultVC,resultVe,changed_route] = regretInit(VC,removed,VE,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta)

rfvc=VC;
count=0;
for i=1:size(VC,1)
    count=count+length(VC{i});
end
lens=length(removed);
counts=1;
changed_route=zeros(lens,1);
while ~isempty(removed)
    len=length(removed);
    deltaCost=zeros(len,4);
    for i=1:len
        [temp]= cheapestIP( removed(i),rfvc,VE,L,a,b,s,dist,demands,comparts,classes,vehicle,centernum,count+length(VE),alpha,gamma,belta);
        deltaCost(i,:)=[removed(i) temp];
    end
    
    tempCost=sortrows(deltaCost,-4);
    removed(removed==tempCost(1,1))=[];
    count=count-1;
    rfvc=insert(tempCost(1,1),tempCost(1,2),tempCost(1,3),rfvc);
    changed_route(counts)=tempCost(1,2);
    counts=counts+1;
end

resultVC=rfvc;
resultVe=VE;

end