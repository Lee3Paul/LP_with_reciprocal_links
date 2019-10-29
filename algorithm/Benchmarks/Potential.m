function [auc,pre,rs,roc,sim] = Potential(train,test,motif,L,metrics)
    %Potential Theory - Bifan
    %%%%%
    A = train;
    switch(motif)
        case 1
            sim = A*A;
        case 2
            sim = A*A';
        case 3
            sim = A'*A;
        case 4
            sim = A'*A';
        case 5
            sim = A*A'*A;
        case 6
            sim = A*A*A';
        case 7
            sim = A'*A*A;
        case 8
            sim = A'*A'*A';
        case 9
            sim = A*A*A;
        case 10
            sim = A*A'*A';
        case 11
            sim = A'*A*A';
        case 12
            sim = A'*A'*A;
    end
    %%%%%
    auc = [];pre = [];rs = [];roc = [];
    if metrics.isAUC auc = CalcAUC_directed(train,test,sim, 10000,1);end
    if metrics.isPRE [pre,rs] = CalcPrecisionRS_directed( train, test, sim, L,1 );end
    if metrics.isROC roc = CalcROC(train,test,sim, 1);end
end
