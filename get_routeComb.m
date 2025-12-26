function [route,ksha,rcomb]=get_routeComb(VC,rcomb,kshaMax)
len=size(rcomb,1);
col=size(rcomb,2);
if col==4
    %     if len>NV
    %         [s,~]=find(rcomb(:,1)>NV);
    %         for i=1:length(s)
    %             rcomb(s(i),3)=inf;
    %         end
    %     end
    while 1
        comb=find(rcomb(:,3)==min(rcomb(:,3)));
        choose=comb(randi(length(comb)));
        shakeNums=rcomb(choose,1:2);
        rcomb(choose,3)=rcomb(choose,3)+1;
        if rcomb(choose,4)==kshaMax
            rcomb(choose,4)=2;
        else
            rcomb(choose,4)=mod(rcomb(choose,4),kshaMax)+1;
        end
        
        ksha=rcomb(choose,4);
        
        
        
        
        
        % route1=find(vehicle_use==shakeNums(1));
        % route2=find(vehicle_use==shakeNums(2));
        route1=shakeNums(1);
        route2=shakeNums(2);
        
        route=[route1 route2];
%         if VC{route1}==22
%             disp('sss')
%         end
%         disp('hhhh')
%         VC{route1}
%         disp('ssss')
%         try
            if ~isempty(VC{route1})
                break;
            end
%         catch
%             disp('hhhh')
%         end

    end
else
    
    while 1
        comb=find(rcomb(:,4)==min(rcomb(:,4)));
        choose=comb(randi(length(comb)));
        shakeNums=rcomb(choose,1:3);
        rcomb(choose,4)=rcomb(choose,4)+1;
        if rcomb(choose,5)==kshaMax
            rcomb(choose,5)=2;
        else
            rcomb(choose,5)=mod(rcomb(choose,5),kshaMax)+1;
        end
        
        ksha=rcomb(choose,5);
        
        
        
        % route1=find(vehicle_use==shakeNums(1));
        % route2=find(vehicle_use==shakeNums(2));
        route1=shakeNums(1);
        route2=shakeNums(2);
        route3=shakeNums(3);
        
        route=[route1 route2 route3];
        if ~isempty(VC{route1})
            break;
        end
    end
end
end