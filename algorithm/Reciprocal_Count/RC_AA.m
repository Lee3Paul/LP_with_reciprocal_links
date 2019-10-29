function [auc,pre,rs,roc,sim] = RC_AA(train,test,L,metrics)
    %RC-DAA index
    A = train;
    W = A+(A.*A');
    %%%%%
    temp = A ./ repmat(log(sum(A,2)),[1,size(A,1)]); 
    % 计算每个节点的权重，1/log(k_i),网络规模过大时需要分块处理
    temp(isnan(temp)) = 0; temp(isinf(temp)) = 0;  
    temp2 = (A.*A') ./ repmat(log(sum(A,2)),[1,size(A,1)]); 
    % 计算每个节点的权重，1/log(k_i),网络规模过大时需要分块处理
    temp2(isnan(temp2)) = 0; temp2(isinf(temp2)) = 0;  
    
    simtemp1 = A*temp;
    simtemp2 = (A.*A')*temp2*2;
    sim = simtemp1 + simtemp2;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
