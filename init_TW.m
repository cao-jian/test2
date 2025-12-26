
%% CW法构造VRPTW初始解
%输入dataset      数据集
%输入cap          每辆车容量约束
%输出init_vc      每辆车所经过的顾客
%输出init_TD      所有车行驶的总距离
%输出init_vl      每辆车的装载量
%输出violate_INTW 判断是否违背时间窗约束，0代表不违背，1代表违背
function [VC]=init_TW(dataset,cap,duration,classes)
E=dataset(1,4);                                       %配送中心时间窗开始时间
L=dataset(1,5);                                       %配送中心时间窗结束时间
vertexs=dataset(:,2:3);                               %所有点的坐标x和y
customer=vertexs(2:end,:);                            %顾客坐标
cusnum=size(customer,1);                              %顾客数
vecnum=cusnum;                                        %车辆数
demands=dataset(2:end,7:end);                             %需求量
comparts=dataset(:,1);
a=dataset(2:end,4);                                   %顾客时间窗开始时间[a[i],b[i]]
b=dataset(2:end,5);                                   %顾客时间窗结束时间[a[i],b[i]]
s=dataset(2:end,6);                                   %客户点的服务时间
h=pdist(vertexs);
dist=squareform(h);                                   %距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
VC=cell(vecnum,1);                                    %每辆车所经过的顾客
%% 初始化各个车辆配送路线，每个顾客由一辆车配送
VC=init_route(VC);
%% 计算融合任意两个路径的节约值
[sav,sav_sort]=sav_cal(VC,L,a,b,s,dist,cap,duration,demands,comparts,classes);
%% 构造VRPTW初始解
if ~isempty(sav_sort)
    while sav_sort(1,1)>0
        %% 更新插入之后的sav矩阵
        [sav,sav_sort]=sav_cal(VC,L,a,b,s,dist,cap,duration,demands,comparts,classes);
        if ~isempty(sav_sort)
            in_index=sav_sort(:,4);                                                             %被插入路径的坐标序号
            put_index=sav_sort(:,3);                                                            %将要插入的路径序号
            in_pos=sav_sort(:,2);                                                               %插入原始路径位置
            %% 更新融合路径后的VC矩阵
            VC=update_vehicles_customer(VC,in_index(1),put_index(1),in_pos(1));
        else
            break;
        end
    end
end

end