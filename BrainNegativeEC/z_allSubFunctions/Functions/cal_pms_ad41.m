function  [pms_hc,pms_mci_ad,pms_ad] = cal_pms_ad41(input,timepoints,states)
    %% output pms_hc and pms_ad calculated from emperical data
    N_ad = 41;
    N_hc = 14;
    N_mci_ad = 14;
    hc_idx = input(1:N_hc*timepoints,1);
    mci_ad_idx = input(timepoints*N_hc+1:timepoints*(N_mci_ad+N_hc),1);
    ad_idx = input(timepoints*(N_hc+N_mci_ad)+1:end,1);
    %mci_ad_idx = input(timepoints*(N_hc+N_ad)+1:end,1);
    pms_hc = zeros(1,states);
    pms_mci_ad = zeros(1,states);
    pms_ad = zeros(1,states);
    for i = 1:states
        pms_hc(i) = (sum(hc_idx == i)) / (N_hc*timepoints);
    end
    for j = 1:states
        pms_mci_ad(j) = (sum(mci_ad_idx  == j)) / (N_mci_ad*timepoints);
    end
    for k = 1:states
        pms_ad(k) = (sum(ad_idx  == k)) / (N_ad*timepoints);
    end
end