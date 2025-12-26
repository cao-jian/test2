function pam(re)
hold on;

for i=1:48 
    if re(i,4)==1   
         plot3(re(i,2),re(i,3),re(i,4),'ro'); 
    elseif re(i,4)==2
         plot3(re(i,2),re(i,3),re(i,4),'go'); 
    elseif re(i,4)==3
         plot3(re(i,2),re(i,3),re(i,4),'bo'); 
    else
        plot3(re(i,2),re(i,3),re(i,4),'yo'); 
    end
end
grid on;
end