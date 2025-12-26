function flag =  isChangeVC(VC,resultVC,changed_route)
changed_route=unique(changed_route);
flag=0;
count=1;
while 1
    if length(VC{changed_route(count)})~=length(resultVC{changed_route(count)})
        flag=1;
        break;
    end
    
    if isequal(VC{changed_route(count)},resultVC{changed_route(count)})
        flag=1;
        break;
    end
    count=count+1;
    if count>length(changed_route)
        break;
    end
end

end