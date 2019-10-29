function [auc,pre,rs,roc,sim] = DRW_Bifan(train,test,recip,L,metrics)
    %Potential Theory -- Bifan
    %%%%%
    temp = train'./repmat(sum(train,2),[1,size(train,1)]);
    temp(isnan(temp)) = 0; temp(isinf(temp)) = 0; 
    A = train + recip*temp;
    sim = A*A'*A;
    sim = sim + recip*sim';
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
