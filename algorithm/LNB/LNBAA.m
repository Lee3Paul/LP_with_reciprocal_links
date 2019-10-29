function [auc,pre,rs,roc,sim] = LNBAA(train,test,L,metrics)
    %LNBRA index
    A = train;
    %%%%%
    s = size(A,1)*(size(A,1)-1) / nnz(A) -1;  
    % 计算每个网络中的常量s
    tri = diag(A*A*A)/2;     
    % 计算每个点所在的三角形个数
    tri_max = sum(A,2).*(sum(A,2)-1)/2;  
    % 每个点最大可能所在的三角形个数
    R_w = (tri+1)./(tri_max+1);
    % 接下来几步是按照公式度量每个点的角色  
    SR_w = (log(s)+log(R_w))./log(sum(A,2));
    SR_w(isnan(SR_w)) = 0; SR_w(isinf(SR_w)) = 0;
    SR_w = repmat(SR_w,[1,size(A,1)]) .* A;   
    % 节点的角色计算完毕
    sim = spones(A) * SR_w;
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
