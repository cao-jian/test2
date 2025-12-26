function result = reaptVisit(cusnum,classes,VC)
len=length(classes);
cus=cusnum/len;
n=size(VC);
result=0;
for i = 1:cus
    temp=(i-1)*len+[1:len];
    if temp(1)==54
        disp('ssss')
    end
    re=[];
    for j=1:n
%         for k=1:length(VC{j})
            
            for k=1:len
                flag = isempty(find(VC{j}==temp(k)));
                if ~flag
                    re=[re j];
                end
            end
%         end
    end
    if ~all(re==re(1))
        result=result+1;
    end
    
end
end