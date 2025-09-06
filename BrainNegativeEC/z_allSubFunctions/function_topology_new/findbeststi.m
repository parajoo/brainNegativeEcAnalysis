function [oulad,kld_all,idx_minkld_corrright,idx_range,idx_mind] = findbeststi(results,hc979_simfc,stimulus)
    kld_all = [results.kld_pms];
    corr_all = [results.corr];
    corr_all_real = real(corr_all);
    idx_corr_first = find(corr_all_real>0.8,1,'first');
    idx_corr_last = find((corr_all_real<0.8)|isnan(corr_all_real),1,'first');
    while(idx_corr_last<=idx_corr_first)
        idx_corr_last = find((corr_all_real<0.8)|isnan(corr_all_real),1,'first');
    end
    if isempty(idx_corr_last)
        idx_corr_last = length(results)+1;
    end
    idx_range = idx_corr_first:(idx_corr_last-1);
    hcbest_simfc = mean(hc979_simfc,3);
    oulad = zeros(1,length(idx_range));
    for i=1:length(oulad)
        fc_sti = results(idx_range(i)).simFC;
        fc_sti_mean = mean(fc_sti,3);
        hcbest_vec = hcbest_simfc(:);
        mcicur_vec = fc_sti_mean(:);
        oulad_cur = sum((hcbest_vec - mcicur_vec).^2);
        oulad(i) = oulad_cur;
    end
    kld_cutdata = kld_all(idx_range);
    idx_minkld_corrright = find(kld_cutdata == min(kld_cutdata),1,'first');
    fprintf('best stimulation strength(minKLD) is %.2f\n',stimulus(idx_range(idx_minkld_corrright)));
    fprintf('KLD = %.5f,OULAD = %.4f\n',kld_all(idx_minkld_corrright),oulad(idx_minkld_corrright));
    %fprintf('\n');
    oulad_cutdata = oulad(idx_range);
    idx_mind = find(oulad_cutdata == min(oulad_cutdata),1,'first');
    fprintf('best stimulation strength(mind) is %.2f\n',stimulus(idx_range(idx_mind)));
    fprintf('KLD = %.5f,OULAD = %.4f\n',kld_all(idx_mind),oulad(idx_mind));
    fprintf('\n');
end