clc
clear all;
close all;
header=[{'数据集名称' 'bestTD' 'runTime'}];
fileNum=11; %文件数
runNum=2; %运行次数
for i=3:3
    dataFile=['pr' sprintf('%02d',i) ]
    vehicleFile=['vehicle' sprintf('%02d',i) ];
    data=importdata(['data/' dataFile '.txt']);
    % cap=200;                                       %车辆最大装载量
    vehicle=importdata(['data/' vehicleFile '.txt']);
    BKS=importdata('data/BKS.txt');
    centernum=max(vehicle(:,2));
    %% 提取数据信息
    E=data(1,8);                                                    %配送中心时间窗开始时间
    L=data(1,9);                                                    %配送中心时间窗结束时间
    vertexs=data(:,2:3);                                           %所有点的坐标x和y
    customer=vertexs(centernum+1:end,:);                                       %顾客坐标
    cusnum=size(customer,1);                                         %顾客数
    v_num=size(vehicle,1);                                                        %车辆最多使用数目
    demands=data(centernum+1:end,5);                                          %需求量
    a=data(centernum+1:end,end-1);                                                %顾客时间窗开始时间[a[i],b[i]]
    b=data(centernum+1:end,end);                                                %顾客时间窗结束时间[a[i],b[i]]+
    s=data(centernum+1:end,4);                                                %客户点的服务时间
    h=pdist(vertexs);
    dist=squareform(h);                                           %距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
    dist=roundn(dist,-2);
    bks=BKS(i);
    %% 初始化种群
%     [VC,VE] = regretInit(cusnum,vehicle,demands,a,b,L,s,dist,centernum);
%     VC={
%         [41   36   31   44   32   39   43   42   46   9   35   37];
%         [34   10   45   27   3   6   48   11   7   22];
%         [20   29   8   16   14   4   19   33   13   5   1   28];
%         [2   23   26   18   17   25   15   30   47   24   21   12   38   40]
%         };
%     VE=[1 2 3 4];
%     for nn=1:4
%         Judge(VC{nn},200,500,demands,a,b,L,s,dist,vehicle,VE(nn),centernum)
%     end
    alpha=0.2;
    gamma=0.2;
    belta=0.2;
    delta=0.1;
    result=cell(runNum,3);
    for run=1:5
        [bestTD,runTime]=VNS_main();
        result{run,1}=dataFile;
        result{run,2}=bestTD;
        result{run,3}=runTime;
    end
%     xlswrite('result\pr.xlsx',result,'sheet1',['A' num2str((i-1)*2+1)]);
xlswrite('result\pr.xlsx',result,'sheet1','A1');
end
% xlswrite('result\pr.xlsx',header,'sheet1','A1');
