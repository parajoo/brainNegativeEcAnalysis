%% plot the network property of simHC simAD and stiAD
%function [idx_mmse_all,p_values,stiAD_mean] = stiAdanalysis_stimulus_results_basalganlia_idxall(name)
%% 1.input results of adding stimulus
    %clear all
    %close all
    clear all
    %close all
    name = 't_stiMciNeCandD0707';
    sect = name;
    figure_name = name;
    load('mci856_data.mat','mci856_simfc')
    load (sprintf('%s.mat',sect),'hc757_simfc','stimulus')
    load (sprintf('%s_results.mat',sect));
    load ('idx_net6_lobe7.mat','haroad')
    basalganlia_idx = haroad;
    for ijk = 1:15
        hcSimFc(:,:,ijk) = hc757_simfc(:,:,ijk) - eye(90,90);
        adSimFc(:,:,ijk) = mci856_simfc(:,:,ijk) - eye(90,90);
    end
    meanss_simhc = squeeze(mean(hcSimFc,1));
    haroad_simhc = meanss_simhc(basalganlia_idx,:);
    meanss_simad = squeeze(mean(adSimFc,1));
    haroad_simad = meanss_simad(basalganlia_idx,:);
    dist_simhc_stiad = zeros(length(results),1);
    p_simhc_stiad = zeros(length(results),1);
    haroad_stiad_mean = zeros(length(results),1);
    kldAll = [results.kld_pms];
    for i=1:length(results)
        stiFcDiag1 = results(i).simFC;
        for iii = 1:15
            stiFcDiag0(:,:,iii) = stiFcDiag1(:,:,iii) - eye(90,90);
        end
        meanss_stiad = squeeze(mean(stiFcDiag0,1));
        haroad_stiad = meanss_stiad(basalganlia_idx,:);
        dist_simhc_stiad(i) = (mean(mean(haroad_simhc)) - mean(mean(haroad_stiad)));
        haroad_stiad_mean(i) = mean(mean(haroad_stiad));
        [~,p1] = ttest2(mean(haroad_simhc,1),mean(haroad_stiad,1));
        p_simhc_stiad(i) = p1;
    end
    stim_intensity = [results.stimulus_vec];
    stim_intensity = 1:length(stim_intensity);
    %stim_intensity = [results.stimulus];
    stiAD_mean = haroad_stiad_mean;
    simAD_mean = mean(mean(haroad_simad))*ones(length(stim_intensity),1);
    HC_mean = mean(mean(haroad_simhc))*ones(length(stim_intensity),1);
    p_values = p_simhc_stiad;
    figure('Color', 'w');
    hold on;

    plot(stim_intensity, stiAD_mean, '-*', 'LineWidth', 2, 'MarkerSize', 5, 'Color', hex2rgb('5fa8d3')'); 
    plot(stim_intensity, HC_mean, '-*', 'LineWidth', 2, 'MarkerSize', 5, 'Color', hex2rgb('cae9ff')');
    plot(stim_intensity, simAD_mean, '-*', 'LineWidth', 2, 'MarkerSize', 5, 'Color', hex2rgb('1b4965')');
    for i = 1:length(stim_intensity)
        if p_values(i)>0.05 && kldAll(i)<0.001
       
        y_pos = stiAD_mean(i) - 0.0005; % 0.05 是偏移量，可调整
        %y_pos = stiAD_mean(i);
        text(stim_intensity(i), y_pos, ...
            sprintf('%.2f', p_values(i)), ...
            'HorizontalAlignment', 'center', ...
            'FontSize', 10, ...
            'Color', 'k','FontWeight','bold');
            text(stim_intensity(i), y_pos, ...
            '*', ...
            'HorizontalAlignment', 'center', ...
            'FontSize', 12, ...
            'Color', 'r','FontWeight','bold');
             fprintf('iterNum = %d,haroadMs = %.5f,kld = %.5f\n',i,stiAD_mean(i),kldAll(i));
        end
%         if kldAll(i)<0.001
%             y_pos = stiAD_mean(i) - 0.0005; % 0.05 是偏移量，可调整
%         %y_pos = stiAD_mean(i);
%         text(stim_intensity(i), y_pos, ...
%             '*', ...
%             'HorizontalAlignment', 'center', ...
%             'FontSize', 10, ...
%             'Color', 'b','FontWeight','bold');
%         end
    end

    xlabel('stimulus', 'FontWeight', 'bold');
    ylabel('meanss', 'FontWeight', 'bold');
    ax = gca;
    ax.FontWeight = "bold";
    title(sprintf('%s',name), 'FontSize', 12);
    legend({'sti-AD', 'sim-HC','sim-AD'});
    grid on;
    hold off;
    idx_bestmmse = find(stiAD_mean == min(stiAD_mean));
    idx_mmse_all = find(p_simhc_stiad>0.05);
    fprintf('Stimuli most likely restore cognition:%.d\n',idx_bestmmse);
    fprintf('stiAD meanss in basalganlia:%.5f,simHC meanss = %.5f,p = %.3f\n',stiAD_mean(idx_bestmmse),HC_mean(idx_bestmmse),p_values(idx_bestmmse))
%end