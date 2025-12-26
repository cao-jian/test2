function result=initShakeMap(ksMax)
% result=containers.Map('KeyType','double','ValueType','any');
% len=size(vehicle,1);
% for i=1:len
%     for j=1:len
%         if i<j
%             temp=str2num([num2str(i) num2str(j)]);
%             result(temp)=containers.Map('KeyType','double','ValueType','any');
%         end
%     end
% end
result=containers.Map('KeyType','double','ValueType','any');
for i=1:ksMax
    result(i)=containers.Map('KeyType','double','ValueType','any');
end

end