function [pre,rs] = CalcPrecisionRS_directed(train,test,sim,L_eric,direction)
        N_node = size(train,1);
        C = speye(N_node)+train;
        sim = sim - sim.*C; %这句话不一定通
        U = diag(ones(1,N_node));
        U = ~U;
        H = U-train;
        N_H = nnz(H);
        N_test = nnz(test);
        un_C = sim.*H;
        %对其排序
        [rank,index]=sort(un_C(:),'descend');
        n=length(L_eric);
        pre=[];
        %对L集合进行计算其precision
        for i=1:n
        %取前L个值
        al=index(1:L_eric(i));
        %求m/L
        pre=[pre sum(test(al))./L_eric(i)];
        end
        pre = pre;
        rs = zeros(1,length(pre));
end