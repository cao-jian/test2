function [resultVC,resultVE,rcomb,exchangeMap]=shake_threeSwap(VC,VE,vehicle,rcomb,lenMax,exchangeMap)
% disp('threeswap')
NV=length(VE);
vehicle_use=VE;
% [VC,vehicle_use]=comple_VC(VC,vehicle_use,vehicle);
[route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);
if rem_len>6
    disp('ssss');
end
% rcomb
count=0;
r1=route(1);
r2=route(2);
r3=route(3);
route1=VC{r1};
route2=VC{r2};
route3=VC{r3};
constRoute1=route1;
constRoute2=route2;
constRoute3=route3;
f3=0;

% constCost1 = part_length(constRoute1,dist,vehicle(vehicle_use(r1),2),centernum)
% constCost2 = part_length(constRoute2,dist,vehicle(vehicle_use(r2),2),centernum)

while ~ f3  && count<100
    
    while 1
        rem_len1=min(rem_len,length(constRoute1));
        rem_len2=min(rem_len,length(constRoute2));
        rem_len3=min(rem_len,length(constRoute3));
        
        rem_len1=randi(rem_len1);
        if rem_len2~=0 && rem_len3~=0
            rem_len2=randi(rem_len2);
            rem_len3=randi(rem_len3);
        end
        if rem_len1+rem_len2+rem_len3>=3 || length(constRoute2)<=1 || length(constRoute1)<=1 || length(constRoute3)<=1
            break;
        end
    end
    
    
    
    pos1=randi(length(constRoute1)-rem_len1+1);
    pos2=randi(length(constRoute2)-rem_len2+1);
    pos3=randi(length(constRoute3)-rem_len3+1);
    
    route1_front=constRoute1(1:pos1-1);
    route1_after=constRoute1(pos1+rem_len1:end);
    temp1=constRoute1(pos1:pos1+rem_len1-1);
    
    route2_front=constRoute2(1:pos2-1);
    route2_after=constRoute2(pos2+rem_len2:end);
    temp2=constRoute2(pos2:pos2+rem_len2-1);
    
    route3_front=constRoute3(1:pos3-1);
    route3_after=constRoute3(pos3+rem_len3:end);
    temp3=constRoute3(pos3:pos3+rem_len3-1);
    
    route1=[route1_front temp3 route1_after];
    route2=[route2_front temp1 route2_after];
    route3=[route3_front temp2 route3_after];
    
    
    count=count+1;
    
%     temp=sort([temp1 temp2 temp3]);
%     [f3,exchangeMap]=Judge_repeat(exchangeMap,temp);
            f3=1;
    if count==10
        %             disp('ddd')
        [route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);
        r1=route(1);
        r2=route(2);
        r3=route(3);
        route1=VC{r1};
        route2=VC{r2};
        route3=VC{r3};
        constRoute1=route1;
        constRoute2=route2;
        constRoute3=route3;
        count=0;
    end
    
    
end
VC{r1}=route1;
VC{r2}=route2;
VC{r3}=route3;
% [VC,vehicle_use]=delete_VC( VC , vehicle_use);
resultVC=VC;
resultVE=vehicle_use;

end