function num_motif = CountMotif_new(adj)
    adj_non = 1-adj-eye(size(adj,1));
    
    temp = ((adj.*adj_non')*(adj.*adj_non')).*(adj_non.*adj_non');num_T01 = sum(sum(temp));
    temp = ((adj.*adj_non')'*(adj.*adj_non')).*(adj_non.*adj_non')/2;num_T02 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj_non')').*(adj_non.*adj_non')/2;num_T03 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj_non')).*(adj.*adj_non');num_T04 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj_non')).*(adj.*adj_non')'/3;num_T05 = sum(sum(temp));
    
    temp = ((adj.*adj')*(adj.*adj_non')).*(adj_non.*adj_non');num_T11 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj')).*(adj_non.*adj_non');num_T12 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj_non')).*(adj.*adj');num_T13 = sum(sum(temp));
    temp = ((adj.*adj_non')*(adj.*adj_non')').*(adj.*adj')/2;num_T14 = sum(sum(temp));
    temp = ((adj.*adj_non')'*(adj.*adj_non')).*(adj.*adj')/2;num_T15 = sum(sum(temp));
    
    temp = ((adj.*adj')*(adj.*adj')).*(adj_non.*adj_non')/2;num_T21 = sum(sum(temp));
    temp = ((adj.*adj')*(adj.*adj')).*(adj.*adj_non');num_T22 = sum(sum(temp));
    
    temp = ((adj.*adj')*(adj.*adj')).*(adj.*adj')/6;num_T31 = sum(sum(temp));
    
    % 所有三元组中互惠边数0-3
    num_T0 = num_T01 + num_T02 + num_T03 + num_T04 + num_T05;
    num_T1 = num_T11 + num_T12 + num_T13 + num_T14 + num_T05;
    num_T2 = num_T21 + num_T22;
    num_T3 = num_T31;
    
    % 未闭合三元组中互惠边数0-3
    num_T0_0 = num_T01 + num_T02 + num_T03;
    num_T1_0 = num_T11 + num_T12;
    
    % 闭合三元组中互惠边数0-3
    num_T0_1 = num_T04 + num_T05;
    num_T1_1 = num_T13 + num_T14 + num_T05;
    num_T2_1 = num_T22;
    num_T3_1 = num_T31;
    
    % 未闭合与闭合总数
    num_T000 = num_T01 + num_T02 + num_T03 + num_T11 + num_T12 + num_T21;
    num_T111 = num_T04 + num_T05 + num_T13 + num_T14 + num_T05 + num_T22 + num_T31;

    num_motif = [num_T01,num_T02,num_T03,num_T04,num_T05;
                 num_T11,num_T12,num_T13,num_T14,num_T15;
                 num_T21,num_T22,num_T31,num_T000,num_T111;
                 num_T0 ,num_T1 ,num_T2 ,num_T3  ,num_T0_0;
                 num_T0_1,num_T1_1,num_T2_1,num_T3_1,num_T1_0];
end