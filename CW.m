function [resultVC, resultVE, resultRemoved] = CW(data,centernum,customer,a,b,s,cusnum,comparts,demands,classes,cap,duration,vehicle)
v_num=size(vehicle,1);                                                        %车辆最多使用数目
cen_ve=v_num/centernum;
data=datachange(data,centernum,customer, a,b,s,cusnum,comparts,demands,classes);
vertexs=data(:,2:3);
h=pdist(vertexs);
dist=squareform(h);
[~,index]=sort(dist(centernum+1:end,1:centernum),2,'ascend');
index=index(:,1);
resultVC=containers.Map('KeyType','double','ValueType','any');
resultVE=[];
outOfcen=[];
count=1;
for cen =1:centernum
    %     ttt=[2 15 25 23];
    %     ttt=15;
    in= index==cen;
    temp=1:cusnum;
    %     temp(ttt)=[];
    %     in(ttt)=[];
    temp=temp(in);
    len=length(temp);
    map=containers.Map('KeyType','double','ValueType','double');
    for i=1:len
        map(i)=temp(i);
    end
    VC=CW_VRPTW([data(cen,:); data(temp+centernum,:)],cap,duration,classes);
    n=size(VC,1);
    if n>cen_ve
        outOfcen=[outOfcen; cen n-cen_ve];
    end
    for i=1:n
        for j=1:length(VC{i})
            VC{i}(j)=map(VC{i}(j));
        end
        resultVC(count)=VC(i);
        resultVE=[resultVE cen];
        
        count=count+1;
    end
end
VC=cell(count-1,1);
for i=1:count-1
    
    temp=resultVC(i);
    VC{i}=temp{1};
end
removed=[];
del=[];
m=size(outOfcen,1);
for i=1:m
    ind=find(resultVE==outOfcen(i,1));
    len=length(ind);
    lens=zeros(len,1);
    for j=1:len
        lens(j)=length(VC{ind(j)});
    end
    [~,index]=sort(lens);
    removed = [removed VC{ind(index(1:outOfcen(i,2)))}];
    del=[del ind(index(1:outOfcen(i,2)))];
end
len=length(del);
for i=1:len
    VC{del(i)}=[];
end
VC=deal_vehicles_customer(VC);
resultVE(del)=[];

ve2cen=vehicle(:,1:2);
len=length(resultVE);
for i=1:len
    indx=find(ve2cen(:,2)==resultVE(i),1);
    resultVE(i)=ve2cen(indx,1);
    ve2cen(indx,:)=[];
end

n=size(VC,1);
len=length(classes);
tempVC=cell(n,1);
for i=1:n
    for j=1:length(VC{i})
        temp=VC{i}(j);
        tempVC{i}=[tempVC{i} len*(temp-1)+[1:len]];
    end
end
resultRemoved=[];
for i=1:length(removed)
    resultRemoved=[resultRemoved (removed(i)-1)*len+[1:len]];
end

[resultVC,resultVE]=comple_VC(tempVC,resultVE,vehicle);
end