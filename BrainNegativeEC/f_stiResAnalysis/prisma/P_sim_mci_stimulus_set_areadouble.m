 %% part1:calculate PMS of emperical subject
function P_sim_mci_stimulus_set_areadouble(set_area1,sti1,set_area2,sti2,name)
    load p_clusters3_moca0105.mat
    centers = cluster.C;
    iFC_all_per = reshape(iFC_all,[timepoints,nsub,n_areas,n_areas]);
    iFC_all_new = permute(iFC_all_per,[2,1,3,4]);
    iFC_all_cut =zeros(length(mciidx),timepoints,n_areas,n_areas);
    for i=1:length(mciidx)
        iFC_all_cut(i,:,:,:) = iFC_all_new(mciidx(i),:,:,:);
    end
    iFC_all_emp = permute(iFC_all_cut,[3,4,2,1]);
    FC_phase_e = mean(iFC_all_emp,4);%90*90*230
    FC_phase_emp = mean(FC_phase_e,3);%90*90
    
    %% part2:plot leading eigenvector
    for ii = 1:cluster_num
        vector = squeeze(centers(ii,:));
        brain_regions = 1:length(vector);
        positive_values = vector > 0;
        negative_values = vector < 0;
        pv_color = [0.529 0.39 0.525];
        nv_color = [0.33 0.5 0.54];
        figure(ii);
        set(gcf,'Color',[1 1 1]);
        barh(brain_regions(positive_values), vector(positive_values), 'FaceColor', pv_color, 'EdgeColor', 'none');
        hold on;
        barh(brain_regions(negative_values), vector(negative_values), 'FaceColor', nv_color, 'EdgeColor', 'none');
        xlabel('Value');
        ylabel('Brain Regions');
        title('leading eigenvector');
        set(gca, 'YLim', [0 length(vector)+1]);
        line([0 0], get(gca, 'YLim'), 'Color', 'k', 'LineWidth', 1);
        hold off;
    end
    %%%%%%%%%%%%%%%%%%%
    %% part3: emperical FCD
    FCD_emp = zeros(timepoints, timepoints);
    for i = 1:timepoints
        vec_i = triu(reshape(FC_phase_e(:,:,i), 90, 90), 1);
        vec_i = vec_i(:);
        for j = i:timepoints
            vec_j = triu(reshape(FC_phase_e(:,:,j), 90, 90), 1);
            vec_j = vec_j(:);
            cosine_similarity = dot(vec_i, vec_j) / (norm(vec_i) * norm(vec_j));
            FCD_emp(i,j) = cosine_similarity;
            FCD_emp(j,i) = cosine_similarity;
        end
    end
    %% part4:emperical data
    load ('hc874_data.mat','hc874_simfc','hc874_simpms')
    pms_hcsim_best = hc874_simpms;
    load ('mci874_data.mat','mci873_ec')
    SC1 =mci873_ec;
    FCemp1_hcbest = mean(hc874_simfc,3);
    N = size(SC1,1);
    %% part5:set N-T model parameters
    dtt = 1e-3;   % Sampling rate of simulated neuronal activity (seconds)
    dt=0.1;
    tao = 100;
    gamma = 0.6410;
    sigma = 0.001;
    JN11 = 0.2609;
    I0 = 0.3;
    %%
    w = 0.9;
    a = 270;
    b = 108;
    d = 0.154;
    H = @(x)(a*x - b)./(1-exp(-d*(a*x - b)));
    Tmax = 535;
    TR = 0.735;
    boldstep= TR*1000;
    Isubdiag = find(tril(ones(N),-1));
    %parfor
    delete(gcp('nocreate'))
    nTrials_use = 15;
    core_use = 15; 
    c = parpool(core_use); 
    c.IdleTimeout = 9600;
    % 全局耦合因子
    G_fixed =1.3;
    T = 0;
    %% initialize iteration parameters
    end_cond = 0.0000001;
    kl_pms_min = inf;
    min_kld = inf;
    iter = 1;
    %% part6:EI - DMF model
    % area1
    stimulus1 = sti1;
    sti_areas1 = zeros(N,1);
    idx_area1 = set_area1;
    sti_areas1(idx_area1) = 1;
    % area2
    stimulus2 = sti2;
    sti_areas2 = zeros(N,1);
    idx_area2 = set_area2;
    sti_areas2(idx_area2) = 1;
    stimulus_all  =zeros(90,length(stimulus1)*length(stimulus2));
    con = 1;
    for iii = 1:length(stimulus1)
        for jjj = 1:length(stimulus2)
            stimulus_all(:,con) = stimulus1(iii)*sti_areas1+stimulus2(jjj)*sti_areas2;
            con = con+1;
        end
    end
%% initialize parameters for iteration
    %% apply stimulus
   % while iter < 2
    nTrials = nTrials_use;
    CB1 = zeros(N,N);
    CB_0 = zeros(N,N);
    Cnew=SC1;
    for ii = 1:size(stimulus_all,2)
        cb1 = zeros(length(Isubdiag),nTrials);
        Cb1 = zeros(N,N,nTrials);
        results(ii).stimulus_vec = stimulus_all(:,ii);
        parfor tr = 1:nTrials %并行
            %for tr = 1:nTrials
            G_coupling_local = G_fixed;
            j=0;
            neuro_act=zeros(round(1000*(Tmax - 1)*TR+1),N);
            nn=1;
            y = 0.001*ones(N,1);
            for t=0:dt:(1000*(Tmax - 1)*TR)
                x = w*JN11*y + I0 + JN11*G_coupling_local*(Cnew*y)+stimulus_all(:,ii);
                r = feval(H,x);
                y = y +dt*(-y/tao +(1-y)*gamma.*r./1000)+sqrt(dt)*sigma*randn(N,1);
                j=j+1;
                if j == (1/dt)
                    neuro_act(nn,:)=r';
                    nn=nn+1;
                    j = 0;
                end
            end
            nn=nn-1;
            %%%% BOLD empirical
            % Friston BALLOON MODEL
            T = nn*dtt; % Total time in seconds
            B = BOLD(T,neuro_act(1:nn,1)'); % B=BOLD activity, bf=Foutrier transform, f=frequency range)
            BOLD_act = zeros(length(B),N);
            BOLD_act(:,1) = B;
    
            for nnew=2:N
                B = BOLD(T,neuro_act(1:nn,nnew));
                BOLD_act(:,nnew) = B;
            end
            bds(:,:,tr) = BOLD_act(20*1000:boldstep:end,:)-mean(BOLD_act(20*1000:boldstep:end,:));
            %%%
            %fire_rate = neuro_act;
            Cb1(:,:,tr) = corrcoef(BOLD_act(20*1000:boldstep:end,:));
            Cb1_flag =Cb1(:,:,tr);
            Cb1_lowlable=Cb1_flag(Isubdiag);
            cb1(:,tr) = atanh(Cb1_lowlable);
        end
        results(ii).boldsignal = bds;
        simsignals = permute(bds,[3,1,2]);
        results(ii).simFC = Cb1;
        CB = mean(Cb1,3);
        CB_0 = CB - eye(90,90);
        CB_col = atanh(CB_0(Isubdiag));
        FC_emp_col = atanh(FCemp1_hcbest(Isubdiag));
        rc = corrcoef((CB_col),(FC_emp_col));
        rc = rc(2);
        results(ii).corr = rc;
%         if isnan(real(rc))
%             results(ii).fcd_od = 0;
%             results(ii).phase_corr = 0;
%             results(ii).iFC_sim_mean = 0;
%             results(ii).pms_mci_sim = 0;
%             results(ii).kld_pms = 0;
%             results(ii).maxdiff = 0;
%         else
            for s = 1:size(simsignals, 1)
            for k = 1:size(simsignals, 3)
                time_series = squeeze(simsignals(s, :, k));
                nan_indices = isnan(time_series);
                if any(~nan_indices)
                    time_series(nan_indices) = interp1(find(~nan_indices), time_series(~nan_indices), find(nan_indices), 'linear', 'extrap');
                else
                    time_series(:) = nanmean(simsignals(:));
                end
                simsignals(s, :, k) = time_series;
            end
        end
        assert(~any(isnan(simsignals(:))), 'BOLD_Signaln still contains NaN values.');
        %% part7:cell data
        simsig_per = permute(simsignals,[1,3,2]);
        cell_14trail = cell(nTrials_use, 1);
        for i = 1:size(simsig_per, 1)
            cell_14trail{i, 1} = squeeze(simsig_per(i, :, :));
        end
        [iFC_all_simm,Leading_Eig_sim] = leida_sim_TR(cell_14trail,flp,fhi,nTrials_use,TR);
        %
        Leading_Eig_simm_per = reshape(Leading_Eig_sim,[timepoints,nTrials_use,n_areas]);
        Leading_Eig_simm = permute(Leading_Eig_simm_per,[2,1,3]);
        iFC_all_sper = reshape(iFC_all_simm,[timepoints,nTrials_use,n_areas,n_areas]);
        iFC_all_sim = permute(iFC_all_sper,[3,4,1,2]);
        %
        FC_phase = mean(iFC_all_sim,4);
        %% part8:simulated fcd
        FCD_sim = zeros(timepoints, timepoints);
        for i = 1:timepoints
            vec_i = triu(reshape(FC_phase(:,:,i), n_areas, n_areas), 1);
            vec_i = vec_i(:);
            for j = i:timepoints
                vec_j = triu(reshape(FC_phase(:,:,j), n_areas, n_areas), 1);
                vec_j = vec_j(:);
                cosine_similarity = dot(vec_i, vec_j) / (norm(vec_i) * norm(vec_j));
                FCD_sim(i,j) = cosine_similarity;
                FCD_sim(j,i) = cosine_similarity;
            end
        end
        upperTriA = triu(FCD_emp, 1);
        upperTriB = triu(FCD_sim, 1);
        vecA = upperTriA(upperTriA ~= 0);
        vecB = upperTriB(upperTriB ~= 0);
        distance = sqrt(sum((vecA  - vecB).^2));
        results(ii).fcd_od = distance;
        %% part9:Fhase correlation KLD
        FC_phase_sim = mean(FC_phase,3);%90*90
        phase_col_emp = atanh(FC_phase_emp(Isubdiag));
        phase_col_sim = atanh(FC_phase_sim(Isubdiag));
        rc_phase = corrcoef(phase_col_sim,phase_col_emp);
        corr_phase = rc_phase(2);
        results(ii).phase_corr = corr_phase;
        results(ii).iFC_sim_mean = FC_phase_sim;
        ass_sim_idx = assign_pms(Leading_Eig_simm,centers);
        pms_mci_sim = zeros(1,cluster_num);
        for x = 1:cluster_num
            pms_mci_sim(x) = sum(ass_sim_idx==x)/length(squeeze(ass_sim_idx));
        end
        results(ii).pms_mci_sim = pms_mci_sim;
        kld_pms = calculateKLDivergences_test_new(pms_hcsim_best,pms_mci_sim);
        results(ii).kld_pms = kld_pms;
        %% part10:get max difference from emp and sim Phase coherence matrix
        maxdiff_currentG = getMaxDifference(FC_phase_e,FC_phase,timepoints);
        results(ii).maxdiff = maxdiff_currentG;
        ii
    end
    %% part11:plot the initial KLD and FCD
    %% part12: find the lowest KLD and max phase difference

%% save data
cd /home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/MCI/
save(sprintf('%s.mat',name));
save(sprintf('%s_results.mat',name),'results','-v7.3');
cd /home/zengmin/model/pms_tianjin_data
clear all
    end