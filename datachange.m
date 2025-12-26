 function result = datachange(data,centernum,vertexs, a,b,s,cusnum,comparts,demands,classes)
len=length(classes);
result=zeros(cusnum/len,6+len*size(demands,2));%
for i=1:cusnum/len
    result(i,1)=i;
    result(i,2:3)=vertexs((i-1)*len+1,:);
    result(i,4)=a((i-1)*len+1);
    result(i,5)=b((i-1)*len+1);
    
    for j=1:len
        result(i,6)=result(i,6)+s((i-1)*len+j);
        index = find(classes==comparts((i-1)*len+j));
        result(i,6+index*2-1:7+index*2-1)=demands((i-1)*len+j,:);
    end
end
temp=[];
for i=1:centernum
    % vertexs=data(:,2:3);                               %�?��点的坐标x和y
% customer=vertexs(2:end,:);                            %顾客坐标
% cusnum=size(customer,1);                              %顾客�?
% demands=data(2:end,5);                             %�?���?
% a=data(2:end,end-1);                                   %顾客时间窗开始时间[a[i],b[i]]
% b=data(2:end,end);                                   %顾客时间窗结束时间[a[i],b[i]]
% s=data(2:end,4); 
    temp=[temp; i data(i,2:3) data(1,9) data(1,10) zeros(1,1+len*size(demands,2))];
end
result=[temp; result];
end