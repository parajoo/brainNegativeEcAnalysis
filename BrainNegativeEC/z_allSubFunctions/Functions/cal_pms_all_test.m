function  [pms_hc,pms_ad] = cal_pms_all_43(input,T_max,states)
    %% output pms_hc and pms_ad calculated from emperical data
    N_ad = 29;
    N_hc = 14;
    ad_idx = input(1:N_ad*T_max,1);
    hc_idx = input(N_ad*T_max+1:end,1);
    pms_hc = zeros(1,states);
    pms_ad = zeros(1,states);
    for i = 1:states
        pms_hc(i) = (sum(hc_idx == i)) / (N_hc*T_max);
    end
    for j = 1:states
        pms_ad(j) = (sum(ad_idx  == j)) / (N_ad*T_max);
    end
end
