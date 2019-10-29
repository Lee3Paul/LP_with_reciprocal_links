function [auc,pre,rs,roc,sim] = LHN( train, test,L,metrics )
    %% 计算LHN-I指标并返回AUC值
    sim = train * train;     
    % 完成分子的计算，分子同共同邻居算法
    deg_out = sum(train,2);
    deg_in = sum(train,1);
    deg = deg_out*deg_in;                                         
    %完成分母的计算
    sim = sim ./ deg;                                      
    %相似度矩阵的计算
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;  
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
