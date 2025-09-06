function  [pms_hc,pms_mci,pms_ad,ptrans_hc,ptrans_mci,ptrans_ad] = cal_pms_ptrans_trio165(input,timepoints,states,nsub,idx_hc,idx_mci,idx_ad)
    %% output pms_hc and pms_ad calculated from emperical data
    input_reshape = reshape(input,timepoints,nsub);
    hc_allidx = input_reshape(:,idx_hc);
    mci_allidx = input_reshape(:,idx_mci);
    ad_allidx = input_reshape(:,idx_ad);
    hc_idx = reshape(hc_allidx,timepoints*length(idx_hc),1);
    mci_idx = reshape(mci_allidx,timepoints*length(idx_mci),1);
    ad_idx = reshape(ad_allidx,timepoints*length(idx_ad),1);
    pms_hc = zeros(1,states);
    pms_mci = zeros(1,states);
    pms_ad = zeros(1,states);
    for i = 1:states
        pms_hc(i) = (sum(hc_idx == i)) / (length(idx_hc)*timepoints);
    end
    for j = 1:states
        pms_mci(j) = (sum(mci_idx  == j)) / (length(idx_mci)*timepoints);
    end
    for k = 1:states
        pms_ad(k) = (sum(ad_idx  == k)) / (length(idx_ad)*timepoints);
    end
    ptrans_hc = ptransition_matrix(hc_idx,states);
    ptrans_mci = ptransition_matrix(mci_idx,states);
    ptrans_ad = ptransition_matrix(ad_idx,states);
end