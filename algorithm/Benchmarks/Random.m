function [auc,pre,rs,roc,sim] = Random(train,test,L,metrics)
    %Random index for reference
    A = train;
    %%%%%
    sim = rand(size(A,1),size(A,2))*100;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
