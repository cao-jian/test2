%% 判断当前方案是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
%输入：chrom               个体
%输入：cap                 最大载重量
%输入：demands             需求量
%输入：a                   顾客时间窗开始时间[a[i],b[i]]
%输入：b                   顾客时间窗结束时间[a[i],b[i]]
%输入：L                   配送中心时间窗结束时间
%输入：s                   客户点的服务时间
%输入：dist                距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
%输出：flag                0表示违反约束，1表示满足全部约束
function [vdu]=Judge_DU(route,duration,a,b,L,s,dist,vehicle,vehicle_use,centernum)
if ~isempty(route)
    [bs,back,arr]= begin_s( route,a,b,s,dist,vehicle(vehicle_use,2),centernum );
    leav=b(route);
    leav=leav';
    wait=bs-arr;
    fs=feasible(leav,wait,bs);
    
    vdu=back-0-fs>duration;
else
    vdu=0;
end


end

