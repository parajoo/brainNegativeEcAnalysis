% close all
% SC_iter = result_iter(38).SCnew;
% SC_new = SC_iter;
% leftBrainIndices = 1:2:90; % MATLAB的索引是从1开始的，直接对应奇数索引
% rightBrainIndices = 2:2:90;
% newIndices = [leftBrainIndices, rightBrainIndices]; % 合并两个数组
% 
% %使用新的索引重排矩阵
% SC_sc = SC_new(newIndices, newIndices);
% SC_ori = SC(newIndices,newIndices);
% figure('Color',[1 1 1]);imagesc(SC_sc);colorbar;caxis([0 0.4]);title('(EC)iter = 38,KLD = 0.0002,G = 1.6')
% figure('Color',[1 1 1]);imagesc(SC);colorbar;caxis([0 0.4]);title('(SC)iter = 0')
% 
load SC_ad.mat
load SC_adbefore.mat
sciter = atanh(SC_ad(Isubdiag));
scno  = atanh(SC_adbefore(Isubdiag));
rc_sc = corrcoef((sciter),(scno));
rc_sc = rc_sc(2);
% % % 
% bestfc_all = result_iter(38).best_fc;
% 
% bestfc_mean = bestfc_all;
% figure('Color',[1 1 1]);imagesc(bestfc_mean);colorbar;caxis([0 1]);title('iter = 38');
% %bestfc_mean = bestfc_mean - eye(90,90);
% %figure('Color',[1 1 1]);imagesc(bestfc_mean);colorbar;
% figure('Color',[1 1 1]);imagesc(FC_emp);colorbar;caxis([0 1]);title('emperical FC');
% %bestfc_mean = mean(bestfc_all,3);
% %figure('Color',[1 1 1]);imagesc(bestfc_mean);colorbar;
% figure('Color',[1 1 1]);imagesc(bestfc_mean);colorbar;title('(simFC)iter = 5,G = 1.4,rc = 0.6804');
% % figure('Color',[1 1 1]);imagesc(FC_emp);colorbar;title('empFC');
% CB_col = atanh(bestfc_mean(Isubdiag));
%         FC_emp_col = atanh(FC_emp(Isubdiag));
%         rc_new = corrcoef((CB_col),(FC_emp_col));
%         rc_new = rc_new(2);

%% phase correlation
% phase_sim_iter = result_iter(13).FC_phase_best;
% phase_emp_orig = FC_phase_emp;
% phaseiter = atanh(phase_sim_iter(Isubdiag));
% phaseno  = atanh(phase_emp_orig(Isubdiag));
% rc_phase = corrcoef((phaseiter),(phaseno));
% rc_phase = rc_phase(2);
% figure('Color',[1 1 1]);imagesc(phase_sim_iter);colorbar;title('(sim)iter = 17,G = 0.6');
% figure('Color',[1 1 1]);imagesc(phase_emp_orig);colorbar;title('emp');

% %% FC correlation
% load model_hcfc.mat
% load HCFC_0321.mat
% simfc_fin = mean(HC_simfc,3);
% empfc_fin = mean(HCFC0321,3);
% sim_col = atanh(simfc_fin(Isubdiag));
% emp_col = atanh(empfc_fin(Isubdiag));
% rcfc_new = corrcoef(sim_col,emp_col);
% rc_fc_new = rcfc_new(2);
% figure('Color',[1 1 1]);imagesc(simfc_fin);colorbar;caxis([-0.07,1]);title('iter = 38,G = 0.8');
% figure('Color',[1 1 1]);imagesc(empfc_fin);colorbar;caxis([-0.07,1]);title('iter = 0');