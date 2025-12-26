%
%      @作者：随心390
%      @微信公众号：优化算法交流地
%
function init_vc=CW_VRPTW(data,cap,duration,classes)
% data=tttemp;
% E=data(1,8);                                       %配送中心时间窗开始时间
% L=data(1,9);                                       %配送中心时间窗结束时间
% vertexs=data(:,2:3);                               %所有点的坐标x和y
% customer=vertexs(2:end,:);                            %顾客坐标
% cusnum=size(customer,1);                              %顾客数
% demands=data(2:end,5);                             %需求量
% a=data(2:end,end-1);                                   %顾客时间窗开始时间[a[i],b[i]]
% b=data(2:end,end);                                   %顾客时间窗结束时间[a[i],b[i]]
% s=data(2:end,4);                                   %客户点的服务时间
% h=pdist(vertexs);
% dist=squareform(h);                                   %距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
tic;
%% 用importdata这个函数来读取文件 
% cap=200;

%% CW法构造VRPTW初始解
[init_vc]=init_TW(data,cap,duration,classes);
initNV=size(init_vc,1);
% str1=['车辆行驶总距离 =  ' num2str(init_TD)];
% disp(str1)
% str2=['车辆使用数目 =  ' num2str(initNV)];
% disp(str2)
%% 判断最优解是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
% flag=Judge(init_vc,cap,demands,a,b,L,s,dist);
%% 检查最优解中是否存在元素丢失的情况，丢失元素，如果没有则为空
% DEL=Judge_Del(init_vc);
[init_vc]=deal_vehicles_customer(init_vc);
% %% 画出配送路线图
% vertexs=data(:,2:3);                                            %所有点的坐标x和y
% draw_Best(init_vc,vertexs);
toc
end