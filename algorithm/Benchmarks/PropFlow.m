function [ auc,pre,rs,roc,sim] = PropFlow( train, test,l,L,metrics )
    % PropFlow index
    A = train;
    [xindex,yindex] = find(A);linklist = [xindex,yindex];
    Nodenum = size(A,1);
    NodeIDs = 1:size(A,2);
    Score = zeros(size(A,1),size(A,2));
    allNeibors = cell(1,Nodenum);
    for rowSize = 1:size(A,2) 
        row = A(rowSize,:);
        [~, col] = find( row  ~= 0 );
        allNeibors{1,rowSize}=col;
    end
    for node_vs = 1:size(A,2)
        found = zeros(1,Nodenum);
        found(node_vs) = 1;
        search = node_vs;
        S = zeros(1,Nodenum);
        S(node_vs) = 1;
        for currentdegree=0:l
            newsearch = [];
            for tt = 1:length(search)
                node_vi = search(tt);
                NodeInput = S(node_vi);
                SumOutput = 0;
                neighbours_i = allNeibors{1, node_vi};
                for ii=1:length(neighbours_i)
                    node_vj = neighbours_i(ii);
                    SumOutput = SumOutput + A(node_vi,node_vj);
                end
                Flow = 0;
                for ii=1:length(neighbours_i)
                    node_vj = neighbours_i(ii);  
                    %获取边的权重
                    w_ij = A(node_vi,node_vj);
                    Flow = NodeInput*w_ij/SumOutput;
                    Flow(isnan(Flow)) = 0; Flow(isinf(Flow)) = 0;
                    S(node_vj) = S(node_vj) + Flow; 
                    if ~found(node_vj)
                        found(node_vj) = 1;
                        newsearch = [newsearch,node_vj];
                    end
                end
            end
            search = newsearch;
        end
        Score(node_vs,:) = S;
    end
    sim = Score-diag(diag(Score));
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end