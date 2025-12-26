function result=get_comb(relComb)
result=[];
key=cell2mat(keys(relComb));
len=length(key);

for i=1:len
    for j=1:length(relComb(i))
        temp=relComb(i);
        a=i;
        b=temp(j);
        result=[result; a b 0];
    end
end
end