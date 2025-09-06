 %% part1:calculate PMS of emperical subject
    clear all
    close all
    
    load p_clusters3_moca0105.mat
    centers = cluster.C;
    iFC_all_per = reshape(iFC_all,[timepoints,nsub,n_areas,n_areas]);
    iFC_all_new = permute(iFC_all_per,[2,1,3,4]);
    iFC_all_cut =zeros(length(hcidx),timepoints,n_areas,n_areas);
    for i=1:length(hcidx)
        iFC_all_cut(i,:,:,:) = iFC_all_new(hcidx(i),:,:,:);
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
        %pv_color =hex2rgb('cccccc')';
        nv_color = [0.33 0.5 0.54];
        figure(ii);
        set(gcf,'Color',[1 1 1]);
        barh(brain_regions(positive_values), vector(positive_values), 'FaceColor', pv_color, 'EdgeColor', 'none');
        hold on;
        barh(brain_regions(negative_values), vector(negative_values), 'FaceColor', nv_color, 'EdgeColor', 'none');
        %xlabel('Value');
        if(ii==1)
         ylabel('Brain Regions');
        %title(sprintf(''));
        set(gca, 'YLim', [0 length(vector)+1]);
        line([0 0], get(gca, 'YLim'), 'Color', 'k', 'LineWidth', 1);
        else
            set(gca, 'XTick', [], 'YTick', [])

        end
     
        hold off;
        box off;
        ax = gca;
        
        ax.FontWeight = "bold";
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
    load p_hcsc_scale.mat
    HC_sc = p_hcsc_scale(1:90,1:90,:);
    SC = mean(HC_sc,3);
    SC1 =0.2* SC /max(max(SC)) ;
    load p_hcfc_scale.mat
    FCemp1 = mean(p_hcfc_scale,3);
    N = size(SC1,1);
    %% part5:set N-T model parameters
    dtt = 1e-3;   % Sampling rate of simulated neuronal activity (seconds)
    dt=0.1;
    tao = 100;
    gamma = 0.6410;
    sigma = 0.001;
    JN11 = 0.2609;
    I0 = 0.31;
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
    G_coupling =0:0.01:2;
    T = 0;
    %% initialize iteration parameters
    end_cond = 0.0000001;
    kl_pms_min = inf;
    min_kld = inf;
    iter = 1;
    % iwe = 1;
    %P1emp = pms_hc;
    %% part6:EI - DMF model
%% initialize parameters for iteration
    kl_pms_history = [];
    max_phase_history = [];
    fc_corr_history = [];
    fcd_min_history = [];
    f_num = cluster_num +1;
    figure(f_num);set(gcf,'Color',[1 1 1]);title('KLD');
    figure(f_num+1);set(gcf,'Color',[1 1 1]);title('Max phase difference');
    figure(f_num+2);set(gcf,'Color',[1 1 1]);title('similarity bewteen simFC and empFC');
    figure(f_num+7);set(gcf,'Color',[1 1 1]);title('fcd');
    hold on;
    %%
    while iter < 2
    nTrials = nTrials_use;
    CB1 = zeros(N,N);
    CB_0 = zeros(N,N);
    Cnew=SC1;
    for ii = 1:length(G_coupling)
        cb1 = zeros(length(Isubdiag),nTrials);
        Cb1 = zeros(N,N,nTrials);
        results(ii).G_value = G_coupling(ii);
        parfor tr = 1:nTrials %并行
            %for tr = 1:nTrials
            G_coupling_local = G_coupling(ii);
            j=0;
            neuro_act=zeros(round(1000*(Tmax - 1)*TR+1),N);
            nn=1;
            y = 0.001*ones(N,1);
            for t=0:dt:(1000*(Tmax - 1)*TR)
                x = w*JN11*y + I0 + JN11*G_coupling_local*(Cnew*y);
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
        FC_emp_col = atanh(FCemp1(Isubdiag));
        rc = corrcoef((CB_col),(FC_emp_col));
        rc = rc(2);
        results(ii).corr = rc;
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
        pms_hc_sim = zeros(1,cluster_num);
        for x = 1:cluster_num
            pms_hc_sim(x) = sum(ass_sim_idx==x)/length(squeeze(ass_sim_idx));
        end
        results(ii).pms_hc_sim = pms_hc_sim;
        kld_pms = calculateKLDivergences_test_new(pms_hc,pms_hc_sim);
        results(ii).kld_pms = kld_pms;
        %% part10:get max difference from emp and sim Phase coherence matrix
        maxdiff_currentG = getMaxDifference(FC_phase_e,FC_phase,timepoints);
        results(ii).maxdiff = maxdiff_currentG;
    end
    %% part11:plot the initial KLD and FCD
    if iter == 1
        G_value = [results.G_value];
        fc_rc = [results.corr];
        kld_pms = [results.kld_pms];
        phase_corr = [results.phase_corr];
        fcd_od = [results.fcd_od];
        figure(f_num +3);set(gcf,'Color',[1 1 1]);plot(G_value, fc_rc, '-','Color',[0.529 0.294 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('similarity between sim and emp(iter = 0)');grid on;
        figure(f_num +4);set(gcf,'Color',[1 1 1]);plot(G_value, kld_pms, '-','Color',[0.929 0.294 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('KLD for PMS(iter = 0)');grid on;
        figure(f_num +5);set(gcf,'Color',[1 1 1]);plot(G_value, fcd_od, '-','Color',[0.129 0.194 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('FCD(iter = 0)');grid on;
        figure(f_num +6);set(gcf,'Color',[1 1 1]);plot(G_value, phase_corr, '-','Color',[0.329 0.594 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('phase correlation(iter = 0)');grid on;
    end
    %% part12: find the lowest KLD and max phase difference
    kl_pms_min = min([results.kld_pms]);
    min_index = find([results.kld_pms] == kl_pms_min,1,'first');
    min_pms_G = results(min_index).pms_hc_sim;
    best_G_kld = G_coupling(min_index);
    kld_low_fc_high = results(min_index).corr;

    if (kl_pms_min<=0.0005 && kld_low_fc_high >=0.7)
        break;
    end

    max_diff_phase = max([results.maxdiff]);
    max_index = find([results.maxdiff] == max_diff_phase,1,'first');
    phase_max_diff = results(max_index).iFC_sim_mean;
    best_G_diff = G_coupling(max_index);

    fc_rc_best = max([results.corr]);
    best_index = find([results.corr] == fc_rc_best,1,'first');
    fc_best_all = results(best_index).simFC;
    fc_best = mean(fc_best_all,3);
    rc_bestG = G_coupling(best_index);

    fcd_min = min([results.fcd_od]);
    fcdG_index = find([results.fcd_od] == fcd_min,1,'first');
    min_fcd_G = G_coupling(fcdG_index);
    
    %% part13:set iteration rules
    FC_phase_sim_best = results(min_index).iFC_sim_mean;
    for i = 1:90
        for j = 1:90
                SC1(i,j) =SC1(i,j) + 0.001*(FC_phase_emp(i,j) - FC_phase_sim_best(i,j));
%                 if SC1(i,j)<0
%                     SC1(i,j)=0.00001;
%                 end
        end
    end
        result_iter(iter).iter_value = iter;
        result_iter(iter).FC_phase_best= FC_phase_sim_best;

        result_iter(iter).kl_pms_min = kl_pms_min;
        result_iter(iter).minG = best_G_kld;
        result_iter(iter).pms_min = min_pms_G;

        result_iter(iter).SCnew = SC1;

        result_iter(iter).max_diff = max_diff_phase;
        result_iter(iter).maxG = best_G_diff;
        result_iter(iter).phase_maxdiff = phase_max_diff;

        result_iter(iter).best_fc = fc_best;
        result_iter(iter).rc_best = fc_rc_best;
        result_iter(iter).bestG_rc = rc_bestG;

        result_iter(iter).best_fcd = fcd_min;
        result_iter(iter).best_fcd_G = min_fcd_G;
        %iter = iter+1;
        result_iter(iter).min_kld_results = results;
        kl_pms_history = [kl_pms_history,kl_pms_min];
        min_kld = min(kl_pms_history);
        max_phase_history = [max_phase_history,max_diff_phase];
        fc_corr_history = [fc_corr_history,fc_rc_best];
        fcd_min_history = [fcd_min_history,fcd_min];
        figure(f_num);
        plot(1:length(kl_pms_history), kl_pms_history, '-*', 'Color', [0.85, 0.325, 0.098], 'MarkerFaceColor', [0.85, 0.325, 0.098], 'LineWidth', 1.2);
        title('KLD');
        xlabel('Iteration Number');
        ylabel('Value');
        drawnow;

        figure(f_num+1);
        plot(1:length(max_phase_history), max_phase_history, '-o', 'Color', [0, 0.447, 0.741], 'MarkerFaceColor', [0, 0.447, 0.741], 'LineWidth', 1.2);
        title('Max Phase Difference');
        xlabel('Iteration Number');
        ylabel('Value');
        drawnow;
    
        figure(f_num+2);
        plot(1:length(fc_corr_history), fc_corr_history, '-x', 'Color', [0.929, 0.694, 0.125], 'MarkerFaceColor', [0.929, 0.694, 0.125], 'LineWidth', 1.2);
        title('FC Correlation');
        xlabel('Iteration Number');
        ylabel('Value');
        drawnow;

        figure(f_num+7);
        plot(1:length(fcd_min_history), fcd_min_history, '-x', 'Color', [0.529, 0.694, 0.125], 'MarkerFaceColor', [0.929, 0.694, 0.125], 'LineWidth', 1.2);
        title('FCD');
        xlabel('Iteration Number');
        ylabel('Value');
        drawnow;

        iter = iter+1;
    end