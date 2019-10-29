function [auc,pre,rs,roc,sim] = DRA(train,test,L,metrics)
    %DRA index
    A = train;
    %%%%%
    temp = A ./ repmat(sum(A,2),[1,size(A,1)]); 
    % 计算每个节点的权重，1/log(k_i),网络规模过大时需要分块处理
    temp(isnan(temp)) = 0; temp(isinf(temp)) = 0;  
    % 将除数为0得到的异常值置为0
    sim = A * temp;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
