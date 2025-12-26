function [resultVC,resultVE,rcomb,exchangeMap]=shake_exchange(VC,VE,vehicle,rcomb,lenMax,exchangeMap)
% disp('exchange')
vehicle_use=VE;
NV=length(vehicle_use);
% [VC,vehicle_use]=comple_VC(VC,vehicle_use,vehicle);
[route,rem_len,rcomb]=get_routeComb(VC,rcomb,lenMax);
if rem_len>6
    disp('ssss');
end
% rcomb
count=0;
r1=route(1);
r2=route(2);
route1=VC{r1};
route2=VC{r2};
constRoute1=route1;
constRoute2=route2;
f3=0;

% constCost1 = part_length(constRoute1,dist,vehicle(vehicle_use(r1),2),centernum)
% constCost2 = part_length(constRoute2,dist,vehicle(vehicle_use(r2),2),centernum)

while ~ f3  && count<100
    
    while 1
        rem_len1=min(rem_len,length(constRoute1));
        rem_len2=min(rem_len,length(constRoute2));
        
        rem_len1=randi(rem_len1);
        if rem_len2~=0
            rem_len2=randi(rem_len2);
        end
        if rem_len1+rem_len2>=3 || length(constRoute2)<=1 || length(constRoute1)<=1
            break;
        end
    end
    
    
    
    pos1=randi(length(constRoute1)-rem_len1+1);
    pos2=randi(length(constRoute2)-rem_len2+1);
    
    route1_front=constRoute1(1:pos1-1);
    route1_after=constRoute1(pos1+rem_len1:end);
    temp1=constRoute1(pos1:pos1+rem_len1-1);
    
    route2_front=constRoute2(1:pos2-1);
    route2_after=constRoute2(pos2+rem_len2:end);
    temp2=constRoute2(pos2:pos2+rem_len2-1);
    
    route1=[route1_front temp2 route1_after];
    route2=[route2_front temp1 route2_after];
    
    %     if isempty(route1_front) || isempty(route1_after) || isempty(route2_front) || isempty(route2_after)
    %         f4=1;
    %     elseif Judge_granular(temp2(1),route1_front(end),[],sparse,bestEdge) || Judge_granular(temp1(1),route2_front(end),[],sparse,bestEdge) ...
    %             || Judge_granular(temp2(end),route1_after(1),[],sparse,bestEdge)|| Judge_granular(temp1(end),route2_after(1),[],sparse,bestEdge)
    %         f4=1;
    %     else
    %         f4=0;
    %     end
    
    
    %     f2=Judge(route2,cap,duration,demands,a,b,L,s,dist,vehicle,vehicle_use(r2),centernum);
    %     if ~f2
    %         f1=Judge(route1,cap,duration,demands,a,b,L,s,dist,vehicle,vehicle_use(r1),centernum);
    %         isFisible=f1;
    %     else
    %         isFisible=1;
    %     end
    count=count+1;
%     
%     temp=sort([temp1 temp2]);
%     [f3,exchangeMap]=Judge_repeat(exchangeMap,temp); 
    f3=1;
    if count==10
        %             disp('bbb')
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
resultVC=VC;
resultVE=vehicle_use;


end