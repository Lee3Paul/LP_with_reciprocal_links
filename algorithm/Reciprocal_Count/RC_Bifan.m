function [auc,pre,rs,roc,sim] = RF_Bifan(train,test,L,metrics)
    %Bifan index
    A = train;
    W = A+(A.*A');
    %%%%%
    sim = W*W'*W;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
