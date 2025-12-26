%% 判断是否违背时间窗约束，0代表不违背，1代表违背
%输入vehicles_customer：       每辆车所经过的顾客
%输入bsv：                     每辆车配送路线上在各个点开始服务的时间，还计算返回集配中心时间
%输入b：                       顾客时间窗结束时间[a[i],b[i]]
%输入L：                       集配中心时间窗结束时间
%输出violate_TW：              否违背时间窗约束的元胞数组
function flag = Judge_TWS( route,bs,back,b,L )
% violate_TW=cell(NV,1);
flag=1;
l_bs=length(bs);
for j=1:l_bs
    if bs(j)>b(route(j))
        flag=0;
        return
    end
end
if back>L
    flag=0;
end

end

