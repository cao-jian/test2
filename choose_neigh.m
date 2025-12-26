function [resultVC,resultVE]=choose_neigh(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,knei,alpha,gamma,belta)

switch knei
    case 1
        [resultVC,resultVE]=inter_route_2_opt(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 2
        [resultVC,resultVE]=inter_route_swap(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 3
        [resultVC,resultVE]=inter_route_2swap(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 4
        [resultVC,resultVE]=inter_route_1_insert(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 5
        [resultVC,resultVE]=inter_route_2_insert(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 6
        [resultVC,resultVE]=intra_route_2_opt(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 7
        [resultVC,resultVE]=intra_route_3_opt(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 8
        [resultVC,resultVE]=intra_route_swap(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
    case 9
        [resultVC,resultVE]=intra_1_insert(vc,ve,vehicle,demands,comparts,classes,a,b,L,s,dist,centernum,alpha,gamma,belta);
end
end