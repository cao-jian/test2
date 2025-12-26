function result = adjust(clsData,dist,centernum,cusnum,threshold)
clusterData=[[1:cusnum]' clsData];
tempdist=dist(centernum+1:end,centernum+1:end);
delete=zeros(1,4);
% record=zeros(1,2);
count=1;
while 1
    clusterDe=zeros(centernum,1);
    for i=1:centernum
        index= find(clusterData(:,4)==i);
%         clusterDe(i)=sum(demands(index));
        clusterDe(i)=length(index);
    end
    if std(clusterDe)<threshold
       break; 
    end
    [~,adc]=max(clusterDe);
    adcIndex=clusterData(clusterData(:,4)==adc,1);
    comb=nchoosek(adcIndex,2);
    s=size(comb,1);
    combdist=zeros(s,1);
    for j=1:s
        combdist(j)=tempdist(comb(j,1),comb(j,2));
    end
    [~,index2]=max(combdist);
    center=setxor(adc,1:centernum);
    
    [num,inpos]=meshgrid(center,comb(index2,:));
    comb2=[num(:) inpos(:)];
    s=size(comb2,1);
    combdist2=zeros(s,1);
    for j=1:s
        combdist2(j)=dist(comb2(j,1),comb2(j,2)+centernum);
    end
    [~,index3]=min(combdist2);
%     temp=[comb2(index3,2),adc];
%     if ismember(temp,record)
%         break;
%     else
%         record(count,:)=temp;
%     end
    
    
    clusterData(clusterData(:,1)==comb2(index3,2),4)=comb2(index3,1);
    delete(count,:)=clusterData(clusterData(:,1)==comb2(index3,2),:);
    clusterData(clusterData(:,1)==comb2(index3,2),:)=[];
    count=count+1;
end

result=[delete;clusterData];
end