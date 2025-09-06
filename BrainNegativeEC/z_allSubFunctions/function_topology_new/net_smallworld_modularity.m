    clear all
    close all
    %% load data
    load p_ad_fc.mat
    load p_mci_fc.mat
    load p_hc_fc.mat
    hc_fc = p_hc_fc;
    mci_fc = p_mci_fc;
    ad_fc = p_ad_fc;
    sub_hc = size(hc_fc,3);
    sub_mci = size(mci_fc,3);
    sub_ad = size(ad_fc,3);
    %% set parpool
    delete(gcp('nocreate'))
    core_use = 11;       % 使用cpu核数?
    c = parpool(core_use);   % 开启并行池
    %% min-max normalizition
    for i = 1:size(mci_fc,3)
        %mci_fc(:,:,i) = mci_fc(:,:,i) - eye(90,90);
        mci_fc(:,:,i) =  abs(mci_fc(:,:,i));
        mci_fc(:,:,i) = (mci_fc(:,:,i) - min(min(mci_fc(:,:,i))))/(max(max(mci_fc(:,:,i)))-min(min(mci_fc(:,:,i))));
    end
    for i = 1:size(hc_fc,3)
        %hc_fc(:,:,i) = hc_fc(:,:,i) - eye(90,90);
        hc_fc(:,:,i) =  abs(hc_fc(:,:,i));
        hc_fc(:,:,i) = (hc_fc(:,:,i) - min(min(hc_fc(:,:,i))))/(max(max(hc_fc(:,:,i)))-min(min(hc_fc(:,:,i))));
    end
    for i = 1:size(ad_fc,3)
        %ad_fc(:,:,i) = ad_fc(:,:,i) - eye(90,90);
        ad_fc(:,:,i) =  abs(ad_fc(:,:,i));
        ad_fc(:,:,i) = (ad_fc(:,:,i) - min(min(ad_fc(:,:,i))))/(max(max(ad_fc(:,:,i)))-min(min(ad_fc(:,:,i))));
    end
    %% small world coefficient
    parfor i = 1:11
        %simhcfc = zeros(90,90,14);
        hcfc_th = zeros(90,90,sub_hc);
        mcifc_th = zeros(90,90,sub_mci);
        adfc_th = zeros(90,90,sub_ad);
        for j = 1:sub_hc
            %simhcfc(:,:,j) = yuzhi((i-1)*0.05,emp_adfc(:,:,j));
            hcfc_th(:,:,j) = yuzhi((i-1)*0.05,hc_fc(:,:,j));
        end
        for j=1:sub_mci
            mcifc_th(:,:,j) = yuzhi((i-1)*0.05,mci_fc(:,:,j));
        end
        for j = 1:sub_ad
            adfc_th(:,:,j) = yuzhi((i-1)*0.05,ad_fc(:,:,j));
        end
        %% small world coefficient
        hcfc_sw = small_world(hcfc_th,sub_hc,50);
        mcifc_sw = small_world(mcifc_th,sub_mci,50);
        adfc_sw = small_world(adfc_th,sub_ad,50);
        hcfc_sw_all(i,:) = hcfc_sw;
        mcifc_sw_all(i,:) = mcifc_sw;
        adfc_sw_all(i,:) = adfc_sw;
        %% modularity
        hcfc_modularity = modularityth(hcfc_th,sub_hc);
        mcifc_modularity = modularityth(mcifc_th,sub_mci);
        adfc_modularity = modularityth(adfc_th,sub_ad);
        hcfc_modularity_all(i,:) = hcfc_modularity;
        mcifc_modularity_all(i,:) = mcifc_modularity;
        adfc_modularity_all(i,:) = adfc_modularity;
    end
    function modularity_th = modularityth(fc_th,sub)
        modularity_th = zeros(1,sub);
        for j=1:sub
            mat = fc_th(:,:,j);
            [community,modularity] = community_louvain(mat);
            modularity_th(j) = modularity;
        end
    end
    function sigma = small_world(fc_th,sub,num_random)
    sigma = zeros(1,sub);
    for j = 1:sub
        A = fc_th(:,:,j);
        % 1. clustering coefficient
        C_real = mean(clustering_coef_wu(A));

        % 2. path length
        L_real = mean(characteristic_path_length(A));

        % 3. stochastic network
        C_random = zeros(1, num_random);
        L_random = zeros(1, num_random);

        for i = 1:num_random
            A_random = randomize_graph(A);
            C_random(i) = mean(clustering_coef_wu(A_random));
            L_random(i) = mean(characteristic_path_length(A_random));
        end

        C_random_mean = mean(C_random);
        L_random_mean = mean(L_random);

        sigma(j) = (C_real / C_random_mean) / (L_real / L_random_mean);
    end

    end


function L = characteristic_path_length(A)
    D(:,:) = distance_wei(A);
    L = (sum(sum(1./(D(:,:)+eye(size(A,1),size(A,1))))) - size(A)) / (size(A,1)*(size(A,1) - 1));
end

function A_random = randomize_graph(A)
    % generate stochastic network(same degree and edges distribution)
    A_random = A(randperm(numel(A))); 
    A_random = reshape(A_random, size(A));
end
