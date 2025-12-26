function result = find_target_col(Matrix,target)
target=unique(target);
len=length(target);
index=[];
for i=1:len
    [col,~]=find(Matrix==target(i));
    index=[index; col];
end
index=unique(index);
result=Matrix(index,:);
end