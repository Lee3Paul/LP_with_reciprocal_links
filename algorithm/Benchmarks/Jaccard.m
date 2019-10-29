function [auc,pre,rs,roc,sim] = Jaccard( train, test,L,metrics )
    %% 计算jaccard指标并返回AUC值
    sim = train * train;               
    % 完成分子的计算，分子同共同邻居算法
    deg_in = repmat(sum(train,1), [size(train,1),1]);
    deg_in = deg_in .* spones(sim);  
    deg_out= repmat(sum(train,2), [1,size(train,1)]);
    deg_out = deg_out .* spones(sim);
    % 只需保留分子不为0对应的元素
    deg_sum = deg_in + deg_out;                      
    % 计算节点对(x,y)的两节点的度之和
    sim = sim./(deg_sum.*spones(sim)-sim); clear deg_sum;           
    % 计算相似度矩阵 节点x与y并集的元素数目 = x与y的度之和 - 交集的元素数目
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
