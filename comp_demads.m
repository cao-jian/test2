function result = comp_demads(demands,comparts,route,class)
    result=zeros(length(class),1);
    tempde=demands(route);
    tempco=comparts(route);
    count=1;
    for i=class
        in= tempco==i;
        result(count)=sum(tempde(in));
        count=count+1;
    end
end