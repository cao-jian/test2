%
%      @作者：随心390
%      @微信公众号：优化算法交流地
%
%% 初始化各个车辆配送路线，每个顾客由一辆车配送
function VC=init_route(VC)
vecnum=size(VC,1);
for i=1:vecnum
    VC{i}=i;                   %初始一辆车只去一个顾客那里
end
end