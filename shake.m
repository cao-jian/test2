function [resultVC ,resultVE,routeCombMap,shakeMap,changed_route] = shake(VC,VE,vehicle,demands,cap,duration,a,b,L,s,dist,centernum,routeCombMap,lenMax,shakeMap,bestTD,alpha,gamma,belta,ksha)
%     ksha=1;
%     while 1
        [VCs,VEs,routeCombMap,shakeMap,changed_route]=choose_shake(VC,VE,vehicle,routeCombMap,lenMax,shakeMap,ksha);
        knei=6;
        while 1
            currentCost=costFuction(VCs,cap,duration,demands,a,b,L,s,dist,vehicle,VEs,centernum,alpha,gamma,belta);
            [newVC,newVE,changed_route]=choose_neigh(VCs,VEs,vehicle,demands,a,b,L,s,dist,centernum,knei,changed_route,alpha,gamma,belta);
            newCost=costFuction(newVC,cap,duration,demands,a,b,L,s,dist,vehicle,newVE,centernum,alpha,gamma,belta);
            if newCost<currentCost
                VCs=newVC;
                VEs=newVE;
            else
                knei=knei+1;
                if knei==10
                    break;
                end
            end
        end
%         ksha=mod(ksha,4)+1;
%         if currentCost<bestTD*1.7
            resultVC=VCs;
            resultVE=VEs;
%             break;
%         end
%     end
end