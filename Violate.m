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
function [result,vtww,vdu,vlo]=Violate(route,cap,duration,demands,comparts,classes,a,b,L,s,dist,center,centernum,alpha,gamma,belta)
result=0;
if ~isempty(route)
    [bs,back,arr]= begin_s( route,a,b,s,dist,center,centernum );
    leav=b(route);
    leav=leav';
    wait=bs-arr;
%     vtw=arr-leav;
    vtw=arr-leav;
    vtww=sum(vtw(vtw>0))+max(back-L,0);
%     vtww=sum(vtw(vtw>0));
    fs=feasible(leav,wait,bs);
    vdu=max(back-0-fs-duration,0);
%     init_v=vehicle_load(route,demands);
%     init_v=comp_demads(demands,comparts,route,classes);
%     init_v=sum(demands(route));
%     cap=cap';
%     vlo=sum(sum(max(init_v-cap,0)));
    vlo=0;
    load=calLoad(route,comparts,demands,classes);
    for i=1:size(load,1)
        temp=load{1};
%         try
            vlo=vlo+sum(max(temp-cap(i),0));
%         catch
%             disp('hhh')
%         end
        
    end
    
    result=alpha*vtww+gamma*vdu+belta*vlo;
end


end

