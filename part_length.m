%% 计算一个子回路的路径长度

function p_l= part_length(route,dist,center,centernum)
n=length(route);
p_l=0;
if n~=0
    for i=1:n
        if i==1
            p_l=p_l+dist(center,route(i)+centernum);
        else
            p_l=p_l+dist(route(i-1)+centernum,route(i)+centernum);
        end
    end
    p_l=p_l+dist(route(end)+centernum,center);
end
end

