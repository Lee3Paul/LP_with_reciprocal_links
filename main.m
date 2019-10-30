%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 链路预测主函数——测试互惠边作用
% Created in 2019-09-07 by Lijinsong
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;
%% 参数设置
% addpath(genpath('../toolbox'));%复杂网络工具箱路径
addpath ./algorithm ./algorithm/Benchmarks ./algorithm/IRW_DRW ./algorithm/LNB ./algorithm/Reciprocal_Count ./function
path_dataset = '../data/';%数据集路径
path_result = './results/';%结果保存路径
networks = char('ADO','HIG','PB','EMA','ATC','USA','CELE','FIG','FWFD','FWFW');
network_index = [1:8];
number_experiment = 30;%蒙特卡洛仿真次数
divide_ratio = [0.95:-0.05:0.6];
is_AUC = 1;is_PRE = 1;is_RS = 0;is_ROC = 0;%选择采用的评价方法
precision_L = 100;%精度采用的参数
metrics = struct('isAUC',is_AUC,'isPRE',is_PRE,'isRS',is_RS,'isROC',is_ROC);
ExpSetup = struct('NetworkIndex',network_index,'NExpriment',number_experiment,'DivideRatio',divide_ratio,...
    'Metrics',metrics,'precision_L',precision_L);%实验参数结构体
results = cell(7,length(network_index)+1);results(2:end,1) = {'AUC';'PRE';'RS';'vAUC';'vPRE';'vRS'};results(8,1) = {'Predictors'};
results_ratio = cell(2,length(divide_ratio));
%% 蒙特卡洛仿真
% 第ith种划分比例
for ith_ratio = 1:length(divide_ratio)
    train_ratio = divide_ratio(ith_ratio);
    m_auc = [];m_precision = [];m_rs = [];v_auc = [];v_precision = [];v_rs = [];
    inetwork = 0;
    % 第ith个数据集
    for ith_network = 1:length(network_index)
        inetwork = network_index(ith_network);
        origin_linklist = load(strcat(path_dataset,networks(inetwork,:),'.txt'));
        [adjmatrix,linklist] = FormNet(origin_linklist,'du');
        precision_L = ceil(nnz(adjmatrix)*0.01);%取总边数前1%的测试边计算Precision
        if precision_L<50 precision_L=50;end
        rho(ith_network) = nnz(adjmatrix.*adjmatrix')/nnz(adjmatrix)
        % 第ith次仿真
        for ith_exp = 1:number_experiment
            disp(strcat(networks(inetwork,:),'(',num2str(ith_network),'/',num2str(length(network_index)),...
                '),',num2str(train_ratio),',',num2str(ith_exp),'/',num2str(number_experiment)));
            % 划分数据集
            [train,test] = DivideNet(adjmatrix,train_ratio,'du');
            % 测试所有指标
            [allMetricValue,selected_indices] = TestAllIndices(train,test,precision_L,ExpSetup);
            allAUC(ith_exp,:) = allMetricValue(1,:);
            allPRE(ith_exp,:) = allMetricValue(2,:);
            allRS(ith_exp,:) = allMetricValue(3,:);
        end
        % 计算均值、方差
        m_auc = mean(allAUC,1);v_auc = var(allAUC,1);
        m_precision = mean(allPRE,1);v_precision = var(allPRE,1);
        m_rs = mean(allRS,1);v_rs = var(allRS,1);
        % 保存每个网络的结果
        results(1,ith_network+1) = {networks(inetwork,:)};
        results(2:7,ith_network+1) = {m_auc;m_precision;m_rs;v_auc;v_precision;v_rs};
        results(8,2) = {selected_indices};
        save('../results/temp_results.mat','results');
    end
    % 保存每个划分的结果
    results_ratio(1,ith_ratio) = {train_ratio};
    results_ratio(2,ith_ratio) = {results};
    save('../results/temp_results_ratio.mat','results_ratio');
end
disp('All done...');
