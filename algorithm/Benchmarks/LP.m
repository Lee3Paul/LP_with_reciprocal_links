function [auc,pre,rs,roc,sim] = LP(train,test,lambda,L,metrics)
    %LP index
    A = train;
    %%%%%
    sim = A * A + lambda * (A*A*A);   
    % 二阶路径 + 参数×三阶路径 
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
