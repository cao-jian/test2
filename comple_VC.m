function [result,vehicle_use]=comple_VC(VC, vehicle_use,vehicle)
len=size(vehicle,1);
NV=length(vehicle_use);
if NV==len
    result=VC;
else
    for i=1:len-NV
        VC{NV+i}=[];
    end
    ve=setxor(vehicle(:,1)',vehicle_use);
%     ve=chrom(chrom>cusnum)-cusnum;
%     v=ve(NV+1:end)
    vehicle_use=[vehicle_use ve];
    result=VC;
end
end