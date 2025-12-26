clc
clear all;
close all;
header=[{'数据集名称' 'bestTD' 'runTime'}];
fileNum=11; %文件数
runNum=1; %运行次数
%i 舱数
%j 数据编号
for i=3:3
    for j=1:20
        dataFile=['pr' sprintf('%02d',j) '-' num2str(i) ];
        alpha=100;
        gamma=100;
        belta=100;
        delta1=0.1;
        delta2=0.2;
        lenP=1;
        result=cell(runNum,4);
        for run=1:runNum
            [bestTD,runTime,repeatVi]=VNS_main(i,j,alpha,gamma,belta,delta1,delta2,lenP);
            result{run,1}=dataFile;
            result{run,2}=bestTD;
            result{run,3}=runTime;
            result{run,4}=repeatVi;
        end
        xlswrite('result\pr.xlsx',result,['sheet' num2str(i-1)],['A' num2str((j-1)*runNum+1)]);
%         xlswrite('result\pr.xlsx',result,'sheet1','A1');
    end
end
% xlswrite('result\pr.xlsx',header,'sheet1','A1');
