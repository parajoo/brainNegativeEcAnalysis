function result_G = parforinnerloops(I0,w,JN11,G_coupling_value, nTrials, SC1, H, N,Tmax,TR,tao,gamma,dt,sigma,dtt, Isubdiag,FC_emp1,Clusters,pms_hc)
    cb1 = zeros(length(Isubdiag),nTrials);
    Cb1 = zeros(N,N,nTrials);
    result_G = struct('G_value',[], 'boldsignal',[], 'simFC',[], 'corr',[], 'pms_hc_sim',[], 'kld_pms',[]);
    result_G.G_value = G_coupling_value;
    CB1 = zeros(N,N);
    CB_0 = zeros(N,N);
    boldstep = TR*1000;
    for tr = 1:nTrials 
            neuro_act_coupling = zeros(round(1000*(Tmax-1)*TR+1),N);
            neuro_FR = zeros(round(1000*(Tmax-1)*TR+1),N);
            y = 0.001*ones(N,1);
            nn = 1;
            j = 0;
            G_coupling_local = G_coupling_value;
            for t = 0:dt:(1000*(Tmax - 1)*TR)
                x =w*JN11*y + I0 + JN11*G_coupling_local*(SC1*y);
                r = feval(H,x);
                y = y + dt*(-y/tao + (1-y)*gamma.*r./1000) + sqrt(dt)*sigma*randn(N,1);
                j = j + 1;
                if j == (1/dt)     %降采样
                    neuro_act_coupling(nn,:) = y';%脑区活跃程度
                    neuro_FR(nn,:) = r';
                    nn = nn + 1;
                    j = 0;
                end
            end
            %%保存仿真 脑电信号
            nn = nn - 1;
            T = nn*dtt;
            B = BOLD(T,neuro_FR(1:nn,1)');
            BOLD_act = zeros(length(B),N);
            BOLD_act(:,1) = B;

            %%%%%%转化成BOLD信号
            for nnew = 2 : N
                B = BOLD(T,neuro_FR(1:nn,nnew));
                BOLD_act(:,nnew) = B;
            end
            %保存仿真 bold 信号
            bds(:,:,tr) = BOLD_act(20*1000:boldstep:end,:)-mean(BOLD_act(20*1000:boldstep:end,:));
            Cb1(:,:,tr) = corrcoef(BOLD_act(20*1000:boldstep:end,:));
            Cb1_flag =Cb1(:,:,tr);
            Cb1_lowlable=Cb1_flag(Isubdiag);
            cb1(:,tr) = atanh(Cb1_lowlable);
    end
    result_G.boldsignal = bds;
    result_G.simFC = Cb1;
    CB = mean(Cb1,3);
    CB_0 = CB - eye(90,90);
    CB_col = atanh(CB(Isubdiag));
    FC_emp_col = atanh(FC_emp1(Isubdiag));
    rc = corrcoef((CB_col),(FC_emp_col));
    rc = rc(2);
    result_G.corr = rc;
    boldsignals = permute(bds,[3,1,2]);
        for s = 1:size(boldsignals, 1)
            for k = 1:size(boldsignals, 3)
                time_series = squeeze(boldsignals(s, :, k));
                nan_indices = isnan(time_series);
                if any(~nan_indices)
                    time_series(nan_indices) = interp1(find(~nan_indices), time_series(~nan_indices), find(nan_indices), 'linear', 'extrap');
                else
                    time_series(:) = nanmean(boldsignals(:));
                end
                boldsignals(s, :, k) = time_series;
            end
        end
        assert(~any(isnan(boldsignals(:))), 'BOLD_Signaln still contains NaN values.');
        %%
        [iFC_all_simm,Leading_Eig_sim] = leading_eig(boldsignals);
        centers = Clusters.C;
        ass_sim_idx = assign_pms(Leading_Eig_sim,centers);
        pms_hc_sim = zeros(1,3);
        for p = 1:3
            pms_hc_sim(p) = sum(ass_sim_idx==p)/length(squeeze(ass_sim_idx));
        end
        result_G.pms_hc_sim = pms_hc_sim;
        kld_pms = calculateKLDivergences_test(pms_hc,pms_hc_sim);
        result_G.kld_pms = kld_pms;
    return
end