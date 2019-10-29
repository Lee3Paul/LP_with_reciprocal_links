function [auc,pre,rs,roc,sim] = DRW_DCN(train,test,recip,L,metrics)
    %DCN index
    %%%%%
    A = train;
    degree_out = repmat((sum(A,2)),[1,size(A,1)]);
    degree_in = repmat((sum(A,1)),[size(A,1),1]);
    sim = (A+recip*A'./(degree_out+1))*(A+recip*A'./(degree_out+1));
    sim = sim + recip*sim';
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    auc_origin = CalcAUC_origin(train,test,sim, 10000,1);
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
