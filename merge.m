%
%      @作者：随心390
%      @微信公众号：优化算法交流地
%
%% 更新合并路径
%输入：VC                             每辆车所经过的顾客
%输出：ins_pos                        插入原始路径位置
%输出：put_index                      将要插入的路径序号
%输出：in_index                       被插入路径的坐标序号
%输出：route_in                       合并的路径
function route_in=merge(VC,in_index,put_index,in_pos)
put=VC{put_index};       %将要插入的路径
in=VC{in_index};         %被插入的路径
len_i=length(in);
%如果in_pos==1，则表示插入位置为原始路径中第一个点的前一个位置
if in_pos==1
    put_in=[put(end) in];
%如果in_pos==len_i+1，则表示插入位置为原始路径中最后一个点的后一个位置
elseif in_pos==len_i+1
    put_in=[in put(end)];
else
    put_in=[in(1:in_pos-1) put(end) in(in_pos:end)];
end
route_in=put_in;
end