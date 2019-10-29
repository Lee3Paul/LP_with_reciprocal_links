function [allMetricValue,selected_indices] = TestAllIndices(train,test,L,ExpSetup)
    %TestAllIndices
    %运行所有的index一次，计算相应评价指标
    metrics = ExpSetup.Metrics;
    selected_indices = {'DCN','DAA','DRA','Bifan','Jaccard','Salton','Sorenson','LHN','HPI','HDI','LP','PropFlow'};
    Nindices = length(selected_indices);
    allMetricValue = zeros(2*length(L)+1,Nindices);
    
    index_cnt = 0;    
    recip = nnz(train.*train')/2/nnz(train);
    
    if cell2mat(strfind(selected_indices,'DCN')) fprintf('DCN...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = DCN( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = RC_CN( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = IRW_DCN( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = DRW_DCN( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'DAA')) fprintf('DAA...');%Directed AA
    [tempauc,temppre,temprs,temproc,~] = DAA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = RC_AA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = IRW_DAA( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = DRW_DAA( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'DRA')) fprintf('DRA...');%Directed RA
    [tempauc,temppre,temprs,temproc,~] = DRA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = RC_RA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = IRW_DRA( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = DRW_DRA( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Bifan')) fprintf('Bifan...');%Bi-fan predictor
    [tempauc,temppre,temprs,temproc,~] = Potential( train, test,5,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = RC_Bifan( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = IRW_Bifan( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = DRW_Bifan( train, test,recip,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'LNB')) fprintf('LNB...');%Bi-fan predictor
    [tempauc,temppre,temprs,temproc,~] = LNBCN( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = LNBAA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    [tempauc,temppre,temprs,temproc,~] = LNBRA( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Jaccard')) fprintf('Jaccard...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = Jaccard( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Salton')) fprintf('Salton...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = Salton( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Sorenson')) fprintf('Sorenson...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = Sorenson( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'LHN')) fprintf('LHN...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = LHN( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'HPI')) fprintf('HPI...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = HPI( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'HDI')) fprintf('HDI...');%Directed CN
    [tempauc,temppre,temprs,temproc,~] = HDI( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'LP')) fprintf('LP...');%Local Path
    [tempauc,temppre,temprs,temproc,~] = LP( train, test,0.001,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'PropFlow')) fprintf('PropFlow...');%PropFlow
    [tempauc,temppre,temprs,temproc,~] = PropFlow( train, test,5,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Random')) fprintf('Random...');%Random
    [tempauc,temppre,temprs,temproc,~] = Random( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    
    if cell2mat(strfind(selected_indices,'Standard')) fprintf('Standard...');%Standard
    [tempauc,temppre,temprs,temproc,~] = Standard( train, test,L,metrics);index_cnt = index_cnt + 1;
    allMetricValue(:,index_cnt) = [tempauc;temppre';temprs'];
    end
    fprintf('\n');
end

