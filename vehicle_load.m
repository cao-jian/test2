%% 计算每辆车离开当前路径上集配中心时的载货量、每辆车离开当前路径上每一点时的载货量
%输入vehicles_customer            每辆车所经过的顾客
%输入d1                           表示由集配中心运送到顾客的配送量
%输出vd                           每辆车离开集配中心的装货量
%输出vw                           每辆车离开加工车间的装货量
%输出vl                           每辆车离开当前路径上集配中心时的载货量、每辆车离开当前路径上每一点时的载货量
function [vl]= vehicle_load( route,demands)
%% 先计算出每辆车在集配中心初始的装货总量
if isempty(route)
    vl=0;
else
    Ld= leave_load( route,demands );
    vl=Ld;
end
end