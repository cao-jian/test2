function [flag,exchangeMap] =Judge_repeat(exchangeMap,change)
flag=0;
tempflag=1;
len=length(change);
if exchangeMap.isKey(len)
    temp=exchangeMap(len);
    n=size(temp,1);
    
     for i=1:n
        if isequal(temp(i,:),change)
            tempflag=0;
            flag=0;
            break;
        end
    end
else
    exchangeMap(len)=change;
    tempflag=0;
    flag=1;
end
if tempflag
    temp=exchangeMap(len);
    temp=[temp; change];
    exchangeMap(len)=temp;
    flag=1;
end
end