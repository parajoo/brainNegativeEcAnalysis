function  [pms_hc,pms_mci,pms_ad] = cal_pms_trio(input,timepoints,states,nsub)
    %% output pms_hc and pms_ad calculated from emperical data
    N_ad = nsub;
    N_hc = nsub;
    N_mci = nsub;
    hc_idx = input(1:N_hc*timepoints,1);
    mci_idx = input(N_hc*timepoints+1:timepoints*(N_hc+N_mci),1);
    ad_idx = input(timepoints*(N_hc+N_mci)+1:end,1);
    pms_hc = zeros(1,states);
    pms_mci = zeros(1,states);
    pms_ad = zeros(1,states);
    for i = 1:states
        pms_hc(i) = (sum(hc_idx == i)) / (N_hc*timepoints);
    end
    for j = 1:states
        pms_mci(j) = (sum(mci_idx  == j)) / (N_mci*timepoints);
    end
    for k = 1:states
        pms_ad(k) = (sum(ad_idx  == k)) / (N_ad*timepoints);
    end
end