function [auc,pre,rs,roc,sim] = Salton( train, test,L,metrics )
    %% 计算Salton指标并返回AUC值
    deg_out = sum(train,2);       
    deg_in = sum(train,1);
    outdeg = repmat((sum(train,2)).^0.5,[1,size(train,1)]);       
    indeg = repmat((sum(train,1)).^0.5,[size(train,1),1]);
    % 可能溢出，规模大的话需要分块。
    tempdeg = outdeg .* indeg;            
    % 分母的计算
    sim = train * train;              
    % 分子的计算
    sim = sim./tempdeg;                 
    % 相似度矩阵计算完成
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
