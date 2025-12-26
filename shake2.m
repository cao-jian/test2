function [resultVC ,resultVE,routeCombMap,shakeMap] = shake2(VC,VE,vehicle,demands,comparts,classes,cap,duration,a,b,L,s,dist,centernum,routeCombMap,lenMax,shakeMap,bestTD,alpha,gamma,belta,ksha)
%     ksha=1;
    while 1
        [VCs,VEs,routeCombMap,shakeMap]=choose_shake(VC,VE,vehicle,routeCombMap,lenMax,shakeMap,ksha);
        vioPos=Judge_violate_pos(VCs,VEs,vehicle,cap,demands,a,b,L,s,dist,centernum,comparts,classes);
        [VCs,remove]=removePos(VCs,vioPos);
        [resultVC,resultVE,changed_route] = regretInit(VCs,remove,VEs,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
        if isempty(remove) || isChangeVC(VC,resultVC,changed_route)
            break;
        end
    end
%         ksha=mod(ksha,4)+1;
%         if currentCost<bestTD*1.7
%         resultVC=VCs;
%         resultVE=VEs;
%             break;
%         end
%     end
end