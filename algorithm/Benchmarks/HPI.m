function [auc,pre,rs,roc,sim] = HPI( train, test,L,metrics )
    %% 计算HPI指标并返回AUC值
    sim = train * train;       
    % 完成分子的计算，分子同共同邻居算法
    deg_in = repmat(sum(train,1), [size(train,1),1]);
    deg_in = deg_in .* spones(sim);
    deg_out = repmat(sum(train,2), [1,size(train,1)]);
    deg_out = deg_out .* spones(sim);
    deg_min = min(deg_in, deg_out); 
    % 完成分母的计算，其中元素(i,j)表示取了节点i和节点j的度的最小值
    sim = sim ./ deg_min; clear deg_min;      
    % 完成相似度矩阵的计算
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;    
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
