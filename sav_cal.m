%% 计算任意融合任意两个路径的节约值
%输入VC                               每辆车所经过的顾客
%输入L                                配送中心时间窗
%输入a                                顾客时间窗
%输入b                                顾客时间窗
%输入s                                服务每个顾客的时间
%输入dist                             距离矩阵
%输出sav                              初始距离节约矩阵[距离节约值 插入原始路径位置 将要插入的路径序号 被插入路径的坐标序号]
%输出sav_sort                         sav_sort按sav第一列距离节约值大小降序排列
function [sav,sav_sort ] = sav_cal(VC,L,a,b,s,dist,cap,duration,demands,comparts,classes)
sav=[];                                 %开辟一个n行4列的节约值矩阵，[距离节约值 插入原始路径位置 将要插入的路径序号 被插入路径的坐标序号]
vecnum=size(VC,1);                      %车辆数
sav=zeros(1e3,4);
count=1;
%% 不考虑时间窗约束的sav矩阵
for i=1:vecnum
    in=VC{i};                           %被插入路径
    len_in=size(in,2);                  %被插入路径中所经过顾客和加工车间的数量
    for j=1:vecnum
        put=VC{j};                      %要插入路径
        len_put=size(put,2);            %要插入路径中所经过顾客的数量
        if (i~=j)&&(len_put==1)
            %从第1个空隙插入，比如原始路径为1 2，现要将3插进来一共有3个可能插入点312、132、123
            for k=1:len_in+1
                put_in=[in(1:k-1) put(1) in(k:end)];
                dealt=part_length(in,dist,1,1)+part_length(put,dist,1,1)-part_length(put_in,dist,1,1);
                sav(count,:)=[dealt,k,j,i];
                count=count+1;
%                 sav=[sav;dealt,k,j,i];
            end
        end
    end
end
sav(find(sav(:,2)==0):end,:)=[];
%% 在上述不考虑时间窗约束的sav矩阵的基础上，进一步考虑时间窗约束，将不符合时间窗约束的行删掉
sav_row=size(sav,1);                        %sav矩阵行数
del=zeros(sav_row,1);                       %标记该行是否被删除,1表示被删除，0表示不被删除
for i=1:sav_row
    pos=sav(i,2);
    put=VC{sav(i,3)};
    in=VC{sav(i,4)};
    put_in=[in(1:pos-1) put(end) in(pos:end)];
    flag=Judge(put_in,cap,duration,demands,comparts,classes,a,b,L,s,dist,1,1);
    if ~flag
        del(i)=1;
    end
end
del_index= del==1;                             %找出被删除行的序号
sav(del_index,:)=[];                           %将标记删除的行从sav矩阵中删除
%% 将sav矩阵按照第1列，从大到小的顺序排列
sav_sort=sav;
if ~isempty(sav)
    [~,sort_index]=sort(sav(:,1),'descend');
    sav_sort=sav(sort_index,:);
end
end