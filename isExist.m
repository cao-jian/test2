function result = isExist(para,paraRecord)
    result=1;
    len=length(para);
    for j=1:len
        index=(paraRecord(:,j)==para(j));
        paraRecord=paraRecord(index,:);
        if isempty(paraRecord)
            result=0;
            return;
        end
    end
end