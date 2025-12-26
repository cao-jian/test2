function result = initPenalty(K,num,alpha,gamma,belta)
% result=containers.Map('KeyType','double','ValueType','any');
% for k=1:K
%     result(k)=zeros(1,num);
% end
result=zeros(K,num);
result(:,1)=alpha;
result(:,2)=gamma;
result(:,3)=belta;
end