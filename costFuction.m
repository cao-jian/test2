%% 计算当前解的成本函数
%输入curr_vc                  每辆车所经过的顾客
%输入a,b                      顾客时间窗结束时间[a[i],b[i]]
%输入s                        对每个顾客的服务时间
%输入L                        仓库时间窗结束时间
%输入dist                     距离矩阵
%输入demands                  各个顾客需求量
%输入cap                      车辆最大载货量
%输出cost                      成本函数 f=TD+alpha*q+belta*w
function [cost,flagTW,flagDU,flagCA]=costFuction(curr_vc,cap,duration,demands,comparts,classes,a,b,L,s,dist,vehicle,vehicle_use,centernum,alpha,gamma,belta)
% if isempty(curr_vc{1})
%     cost=0;
% else
    cost=0;
    flagTW=0;
    flagDU=0;
    flagCA=0;
    n=length(vehicle_use);
    for i=1:n
        [re1,re2,re3,re4]=costM(curr_vc{i},cap,duration,demands,comparts,classes,a,b,L,s,dist,vehicle(vehicle_use(i),2),centernum,alpha,gamma,belta);
        cost=cost+re1;
        flagTW=flagTW+re2;
        flagDU=flagDU+re3;
        flagCA=flagCA+re4;
    end
% end

end

