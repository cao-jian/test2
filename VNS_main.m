%% 用importdata这个函数来读取文件
% function [bestTD,runTime,repeatVis]=VNS_main(i,j,alpha,gamma,belta,delta1,delta2,lenP)
clc
clear all;
i=2;
j=1; 
alpha=100;
gamma=100;
belta=100;
delta1=0.1;
delta2=0.2;
lenP=1;
dataFile=['pd' sprintf('%03d',j) ]
vehicleFile=['vehicle' sprintf('%03d',j) ];
data=importdata(['data/' num2str(i) '舱/' dataFile '.txt']);
% data=data(1:34,:);
% cap=200;                                       %车辆最大装载量
vehicle=importdata(['data/' num2str(i) '舱/' vehicleFile '.txt']);
centernum=max(vehicle(:,2));
%% 提取数据信息
E=data(1,9);                                                    %配送中心时间窗开始时间
L=data(1,10);                                                    %配送中心时间窗结束时间
vertexs=data(:,2:3);                                           %所有点的坐标x和y
customer=vertexs(centernum+1:end,:);                                       %顾客坐标
cusnum=size(customer,1);                                         %顾客数
v_num=size(vehicle,1);
lenMax=ceil(lenP*(cusnum/v_num));
demands=data(centernum+1:end,5:6);                                          %取送货需求量，第一列为送，第二列为取
a=data(centernum+1:end,end-1);                                                %顾客时间窗开始时间[a[i],b[i]]
b=data(centernum+1:end,end);                                                %顾客时间窗结束时间[a[i],b[i]]+
s=data(centernum+1:end,4);                                                %客户点的服务时间
h=pdist(vertexs);
dist=squareform(h);                                           %距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
% dist=roundn(dist,-2);
comparts=data(centernum+1:end,1);
% classes=[0:i-1];
classes=0;
%% 初始化种群
cap=vehicle(1,4:end);
duration=vehicle(1,3);


[resultVC, resultVE, removed] = CW(data,centernum,customer,a,b,s,cusnum,comparts,demands,classes,cap,duration,vehicle);

% draw_Best(resultVC,vertexs,vehicle,resultVE,centernum,classes);



[bestVC,bestVE] = regretInit(resultVC,removed,resultVE,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
% % repeatVis = reaptVisit(cusnum,classes,bestVC)
% 
% draw_Best(bestVC,vertexs,vehicle,bestVE,centernum,classes);
% bestVC={
%     [69	70	87	88	61	62	81	82	13	14	73	74];
%     [17	18	83	84	91	92	77	78	3	4	29	30	49	50	51	52	45	46	71	72	63	64];
%     [43,44];
%     [67	68	19	20	89	90	11	12	53	54	5	6	95	96	21	22];
%     [25	26	65	66	39	40	57	58	15	16	9	10	33	34	35	36	31	32];
%     [55	56	7	8	37	38	27	28	1	2];
%     [93	94	47	48	23	24	75	76	79	80	41	42	85	86];
%     [59,60];
%     };
% bestVE=[1,2,3,4,5,6,7,8];
tic;
%% 优化
% optComb=initPointComb(cusnum);
ksMax=4;
routeCombMap=initRouteMap(vehicle);
shakeMap=initShakeMap(ksMax);

bestCost=costFuction(bestVC,cap,duration,demands,comparts,classes,a,b,L,s,dist,vehicle,bestVE,centernum,alpha,gamma,belta);
count=0;
ksha=1;
knei=1;
VCs=bestVC;
VEs=bestVE;
MaxNoImp=1000*(cusnum<=50) + 100 * (cusnum>50 & cusnum<=200) + 50 * (cusnum>200);
for time=1:MaxNoImp
    while 1
        currentCost=costFuction(VCs,cap,duration,demands,comparts,classes,a,b,L,s,dist,vehicle,VEs,centernum,alpha,gamma,belta);
        
        [newVC,newVE]=choose_neigh(VCs,VEs,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,knei,alpha,gamma,belta);
        
        [newCost,flagTw,flagDu,flagCa]=costFuction(newVC,cap,duration,demands,comparts,classes,a,b,L,s,dist,vehicle,newVE,centernum,alpha,gamma,belta);
        if newCost<currentCost
            VCs=newVC;
            VEs=newVE;
            knei=1;
        else
            knei=knei+1;
            if knei==10
                break;
            end
        end
    end
    if ~flagTw && ~flagDu && ~flagCa
        if newCost<bestCost
            bestCost=newCost;
            bestVC=newVC;
            bestVE=newVE;
            count=0;
        else
            count=count+1;
        end
    else
        count=count+1;
    end
    
    if count>MaxNoImp
        break;
    end
    
    VC=bestVC;
    VE=bestVE;
    [alpha,gamma,belta]=updatePenalty(flagTw,flagDu,flagCa,alpha,gamma,belta,delta1,delta2);
    knei=1;
    [VCs,VEs,routeCombMap,shakeMap]=shake2(VC,VE,vehicle,demands,comparts,classes,cap,duration,a,b,L,s,dist,centernum,routeCombMap,lenMax,shakeMap,bestCost,alpha,gamma,belta,ksha);
    
    ksha=mod(ksha,4)+1;
end
bestTD=bestCost;
% bestTD=travel_distance(bestVC,dist,vehicle,bestVE,centernum);
% disp(['车辆使用数目：',num2str(length(bestVE)),'，车辆行驶总距离：',num2str(bestTD)]);
% disp('-------------------------------------------------------------')
%% 判断最优解是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
% flag=Judge(bestVC,cap,demands,a,b,L,s,dist);

% %% 检查最优解中是否存在元素丢失的情况，丢失元素，如果没有则为空
% DEL=Judge_Del(bestVC);
%% 画出最终路线图
repeatVis = reaptVisit(cusnum,classes,bestVC);
draw_Best(bestVC,vertexs,vehicle,bestVE,centernum,classes);
runTime=toc;
% end