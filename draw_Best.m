%% 画出最优配送方案路线图
%输入：VC              配送方案
%输入：vertexs         各个点的经度和纬度
function draw_Best(VC,vertexs, vehicle,vehicle_use,centernum,classes)
customer=vertexs(centernum+1:end,:);                                      %门店经度和纬度
NV=size(VC,1);                                                  %车辆使用数目
% figure
hold on;box on
title('最优配送方案路线图')
hold on;
C=linspecer(NV);
for i=1:NV
    part_seq=VC{i};            %每辆车所经过的门店
    len=length(part_seq);                           %每辆车所经过的门店数量
    if len~=0
        for j=0:len
            %当j=0时，车辆从配送中心出发到达该路径上的第一个门店
            if j==0
                fprintf('%s','配送路线',num2str(i),'：');
                fprintf('%s->',['配送中心',num2str(vehicle(vehicle_use(i),2))]);
                c1=customer(part_seq(1),:);
                plot([vertexs(vehicle(vehicle_use(i),2),1),c1(1)],[vertexs(vehicle(vehicle_use(i),2),2),c1(2)],'-','color',C(i,:),'linewidth',2);
                %             text(c1(1)+1,c1(2)+1,num2str(part_seq(1)));
                %当j=len时，车辆从该路径上的最后一个门店出发到达配送中心
            elseif j==len
                fprintf('%d->',part_seq(j));
                fprintf('%s',['配送中心',num2str(vehicle(vehicle_use(i),2))]);
                fprintf('\n');
                c_len=customer(part_seq(len),:);
                plot([c_len(1),vertexs(vehicle(vehicle_use(i),2),1)],[c_len(2),vertexs(vehicle(vehicle_use(i),2),2)],'-','color',C(i,:),'linewidth',2);
                %             text(c_len(1)+1,c_len(2)+1,num2str(part_seq(len)));
                %否则，车辆从路径上的前一个门店到达该路径上紧邻的下一个门店
            else
                fprintf('%d->',part_seq(j));
                c_pre=customer(part_seq(j),:);
                c_lastone=customer(part_seq(j+1),:);
                plot([c_pre(1),c_lastone(1)],[c_pre(2),c_lastone(2)],'-','color',C(i,:),'linewidth',2);
                %             text(c_lastone(1)+1,c_lastone(2)+1,num2str(part_seq(j+1)));
            end
        end
    end
    
end

count=1;
for i=1:length(classes):length(customer)
    text(customer(i,1)+1,customer(i,2)+1,num2str(count));
    count=count+1;
end
plot(customer(1:2:end,1),customer(1:2:end,2),'ro','linewidth',2);
hold on;
% for i=1:length(vehicle_use)
%     plot(vertexs(vehicle(vehicle_use(i),2),1),vertexs(vehicle(vehicle_use(i),2),2),'s','linewidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10);
% end

for i=1:centernum
    plot(vertexs(i,1),vertexs(i,2),'s','linewidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10);
    text(vertexs(i,1)+1,vertexs(i,2)+1,['D' num2str(i)])
end

end

