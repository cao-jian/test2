%第一列代表需要送的货物
%第二列代表需要取的货物
function result = calLoad(route,comparts,demands,classes)
types=length(classes);
% len=length(route);
result=cell(types,1);
tempde=demands(route,:);
tempco=comparts(route,:);
for i=1:types
    index = tempco==classes(i);
    tempdee = tempde(index,:);
    result{i}(1) = sum(tempdee(:,1));
    for j=1:size(tempdee,1)
        result{i}(j+1) = result{i}(j)-tempdee(j,1)+tempdee(j,2);
    end
end
end