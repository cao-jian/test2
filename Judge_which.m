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
function [flagTw,flagDu,flagCa]=Judge_which(VC,cap,duration,demands,a,b,L,s,dist,vehicle,VE,centernum)
n=length(VE);
flagTw=0;
flagCa=0;
flagDu=0;
for i=1:n
    if ~flagTw
        flagTw=Judge_TW(VC{i},a,b,L,s,dist,vehicle,VE(i),centernum);
    end
    
    if ~flagCa
        flagCa=Judge_CA(VC{i},cap,demands);
    end
    
    if ~flagDu
        flagDu=Judge_DU(VC{i},duration,a,b,L,s,dist,vehicle,VE(i),centernum);
    end
    
    if flagTw || flagCa || flagDu
        return
    end
end
end

