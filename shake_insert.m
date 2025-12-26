 function [resultVC,resultVE,rcomb,exchangeMap]=shake_insert(VC,VE,vehicle,rcomb,lenMax,exchangeMap)
% disp('insert')
NV=length(VE);
vehicle_use=VE;
% [VC,vehicle_use]=comple_VC(VC,vehicle_use,vehicle);
[route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);

count=0;
r1=route(1);
r2=route(2);
route1=VC{r1};
route2=VC{r2};
constRoute1=route1;
constRoute2=route2;
f3=0;
while ~  f3  && count<100
    
    rem_len1=min(rem_len,length(constRoute1));
    rem_len1=max(2,randi(rem_len1));
    
    if length(constRoute1)~=1
        pos1=randi(length(constRoute1)-rem_len1+1);
        flag=1;
    else
        flag=0;
    end
    if flag
        if ~isempty(constRoute2)
            pos2=randi(length(constRoute2));
        else
            pos2=1;
        end
        
        route1_front=constRoute1(1:pos1-1);
        route1_after=constRoute1(pos1+rem_len1:end);
        temp1=constRoute1(pos1:pos1+rem_len1-1);
        
        route2_front=constRoute2(1:pos2-1);
        route2_after=constRoute2(pos2:end);
        
        route1=[route1_front  route1_after];
        route2=[route2_front temp1 route2_after];
        
        
        count=count+1;
%         temp=[vehicle_use(r2) sort([temp1])];
%         [f3,exchangeMap]=Judge_repeat(exchangeMap,temp);
        f3=1;
        if count==10
            [route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);
            r1=route(1);
            r2=route(2);
            route1=VC{r1};
            route2=VC{r2};
            constRoute1=route1;
            constRoute2=route2;
            count=0;
        end
    else
        [route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);
        r1=route(1);
        r2=route(2);
        route1=VC{r1};
        route2=VC{r2};
        constRoute1=route1;
        constRoute2=route2;
        count=0;
    end
    
    
    
end
VC{r1}=route1;
VC{r2}=route2;
% [VC,vehicle_use]=delete_VC( VC , vehicle_use);
resultVE=vehicle_use;
resultVC=VC;



end