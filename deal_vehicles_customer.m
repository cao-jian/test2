%% 根据VC整理出fvc，将VC中空的数组移除
%输入：VC                  每辆车所经过的顾客
%输出：fvc                 删除空数组，整理后的vehicles_customer
function [fvc,vehicles_used]=deal_vehicles_customer(VC)
vecnum=size(VC,1);                      %车辆数
fvc={};                                 %整理后的vehicles_customer
count=1;                                %计数器
for i=1:vecnum
    par_seq=VC{i};                      %每辆车所经过的顾客
    %如果该辆车所经过顾客的数量不为0，则将其所经过的顾客数组添加到fvc中
    if ~isempty(par_seq)                        
        fvc{count}=par_seq;
        count=count+1;
    end
end
%% 为了容易看，将上述生成的1行多列的fvc转置了，变成多行1列的了
fvc=fvc';       
vehicles_used=size(fvc,1);              %所使用的车辆数
end