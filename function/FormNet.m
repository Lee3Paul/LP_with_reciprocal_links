function [ net,mlinklist ] = FormNet( linklist,type )
    %% 读入连边列表linklist，构建网络邻接矩阵net
    %---- 如果节点编号从0开始，将所有节点编号加1（matlab的下标从1开始）
    if ~all(all(linklist(:,1:2)))
        linklist(:,1:2) = linklist(:,1:2)+1;
    end
    if size(linklist,2) == 4 linklist = linklist(:,1:3);end %去除时间列
    linklist = unique(linklist,'rows');%删除重复行
    if(strcmp(type,'uu')||strcmp(type,'du')||size(linklist,2)==2)
    %----对无向图，将第三列元素置为1
        linklist(:,3) = 1;
    end
    net = spconvert(linklist);
    nodenum = length(net);
    net(nodenum,nodenum) = 0;                               
    % 此处删除自环，对角元为0以保证为方阵
    net = net-diag(diag(net));
    if(strcmp(type,'uu')||strcmp(type,'uw'))
        net = spones(net + net'); % 无向无权网络则用此句转化为对称矩阵
    % 确保邻接矩阵为对称矩阵，即对应于无向网络
    end
    [x,y,w] = find(net);
    mlinklist = [x,y,w];
end 
% 转换过程结束，得到网络的邻接矩阵
