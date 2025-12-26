function [vcs,ves,routeCombMap,shakeMap]=choose_shake(vc,ve,vehicle,routeCombMap,lenMax,shakeMap,ksha)
routeComb=routeCombMap(ksha);
% if ksha~=3
    exchangeMap=shakeMap(ksha);
% end
switch ksha
    case 1
        [vcs,ves,routeComb,exchangeMap]=shake_exchange(vc,ve,vehicle,routeComb,lenMax,exchangeMap);
    case 2
        [vcs,ves,routeComb,exchangeMap]=shake_insert(vc,ve,vehicle,routeComb,lenMax,exchangeMap);
    case 3
        [vcs,ves,routeComb,exchangeMap]=shake_threeSwap(vc,ve,vehicle,routeComb,lenMax,exchangeMap);
    case 4
        [vcs,ves,routeComb,exchangeMap]=shake_doubleExchange(vc,ve,vehicle,routeComb,lenMax,exchangeMap);
end
routeCombMap(ksha)=routeComb;
% if  ksha~=3
    shakeMap(ksha)=exchangeMap;
% end
end