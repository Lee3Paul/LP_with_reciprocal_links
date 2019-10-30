clc;clear all;close all;
addpath ../../data
addpath ../function
all_networks = char('ADO','ATC','PB','CELE','HIG','FIG','USA','EMA');
network_index = [1:8];
% 读取网络数据
for ith_network = 1:length(network_index)
    select_index = network_index(ith_network);
    select_network = all_networks(select_index,:);
    origin_linklist = load(strcat(select_network,'.txt'));
    if ~all(all(origin_linklist(:,1:2)))
        origin_linklist(:,1:2) = origin_linklist(:,1:2)+1;
    end
    if(size(origin_linklist,2)==2) origin_linklist(:,3)=ones(size(origin_linklist,1),1);end
    N_node = max(max(origin_linklist(:,1:2)));
    origin_matrix = spconvert(origin_linklist);
    origin_matrix(N_node,N_node) = 0;
    origin_matrix = full(origin_matrix);
    % 判断网络类型
    if(origin_matrix==origin_matrix') disp('undirected');
    else disp('directed');end
    if(max(origin_linklist(:,3))>1) disp('weighted');
    else disp('unweighted');end
    % 网络预处理
    [ adj,mlinklist ] = FormNet( origin_linklist,'du' );
    adj = full(adj);
    % 网络基本统计信息
    degree_out = repmat(sum(adj,2),1,size(adj,2));
    degree_in = repmat(sum(adj,1),size(adj,1),1);
    N_node = size(adj,1);
    N_link = nnz(adj);
    adj_recip = adj.*adj';
    N_rlink = nnz(adj_recip)/2;
    N_nrlink = N_link-N_rlink;
    rho = N_rlink/N_link;
    % 互惠边出入度
    [x,y,w_out] = find(adj_recip.*degree_out);
    rlinklist_out = [x,y,w_out];
    [x,y,w_in] = find(adj_recip.*degree_in);
    rlinklist_in = [x,y,w_in];
    rlinklist = [x,y,w_out,w_in];

    adj_nonrecip = adj - adj.*adj';
    [x,y,w_out] = find(adj_nonrecip.*degree_out);
    nrlinklist_out = [x,y,w_out];
    [x,y,w_in] = find(adj_nonrecip.*degree_in);
    nrlinklist_in = [x,y,w_in];
    nrlinklist = [x,y,w_out,w_in];

    rd_out = sort(rlinklist_out(:,3),'descend');
    % 生成随机网络
    adj_non = 1-adj-eye(size(adj,1));
    num_origin(:,:,ith_network) = CountMotif(adj);
    adj_u = adj + adj';
    adj_u(adj_u~=0)=1;
    [x,y,w] = find(adj_u);
    ulinklist_origin = [x,y,w];
    N_ulink = size(ulinklist_origin,1);
    % 生成空模型
    for ith_exp = 1:1000
        adj_temp = triu(adj_u);
        [x,y,w] = find(adj_temp);
        ulinklist_temp = [x,y,w];
        weight = round(rand(size(ulinklist_temp,1),1))+1;
        recip_index = randperm(size(ulinklist_temp,1),round(N_rlink));
        weight(recip_index)=3;
        ulinklist_temp = [x,y,weight];
        adj_temp1 = spconvert(ulinklist_temp);
        adj_temp1(N_node,N_node) = 0;
        adj_temp1 = full(adj_temp1);
        temp1 = adj_temp1;temp1(temp1==2)=0;temp1(temp1==3)=1;
        temp2 = adj_temp1';temp2(temp2==1)=0;temp2(temp2==2)=1;temp2(temp2==3)=1;
        adj_rand = temp1 + temp2;
        nnz(adj_rand.*adj_rand')/2/nnz(adj_rand);
        % 统计两种网络的闭合三元组数量
        num_motif(:,:,ith_exp) = CountMotif(adj_rand);
        disp(ith_exp);
    end
    num_rand(:,:,ith_network) = mean(num_motif,3);
    num_std(:,:,ith_network) = std(num_motif,1,3);
    z_score(:,:,ith_network) = (num_origin(:,:,ith_network) - num_rand(:,:,ith_network))./num_std(:,:,ith_network);
    save('../../results/Zscore_reciprocal_null_model.mat','z_score');
end