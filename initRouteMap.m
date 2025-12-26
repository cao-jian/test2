function result=initRouteMap(vehicle)
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
temp=nchoosek(1:size(vehicle,1),2);
temp(:,3)=0;
temp(:,4)=1;
result(1)=temp;
result(4)=temp;
% result(3)=temp;
temp=[temp; temp(:,2) temp(:,1) temp(:,3) temp(:,4);];
result(2)=temp;

tempp=get_combination(size(vehicle,1),3);
tempp(:,4)=0;
tempp(:,5)=1;
result(3)=tempp;


end