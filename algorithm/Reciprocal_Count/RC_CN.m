function [auc,pre,rs,roc,sim] = RC_CN(train,test,L,metrics)
    %RC-DCN index
    A = train;
    %%%%%
%     sim = W*W;
    
    temp1 = A*A;
    temp2 = (A.*A')*(A.*A');
    sim = temp1 + temp2;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
