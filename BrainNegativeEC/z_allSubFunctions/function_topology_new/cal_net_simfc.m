%% if calculate the empdata ,the diagonal data equal to 0,but to simulated data is 1
% clear all
% close all
% % load p_hcfc_scale.mat
% % load p_mcifc_scale.mat
% % load p_adfc_scale.mat
% load ('hc979_data.mat','hc979_simfc');
% load('mci838_data.mat','mci838_simfc');
% load('ad635_data.mat','ad635_simfc');
% [simhc_netC,simhc_netE,simmci_netC,simmci_netE,simad_netC,simad_netE] = cal_net_simfcl(hc979_simfc,mci838_simfc,ad635_simfc);
function [emphc_netC,emphc_netE,empmci_netC,empmci_netE,empad_netC,empad_netE] = cal_net_simfc(hcfc,mcifc,adfc)
    
        emp_hcfc = hcfc;
        emp_mcifc = mcifc;
        emp_adfc = adfc;
        sub_hc = size(emp_hcfc,3);
        sub_mci = size(emp_mcifc,3);
        sub_ad = size(emp_adfc,3);
        %% min-max normalized
        %% max
        for i = 1:size(emp_hcfc,3)
            %emp_hcfc(:,:,i) = emp_hcfc(:,:,i) - eye(90,90);
            emp_hcfc(:,:,i) =  abs(emp_hcfc(:,:,i));
            %emp_hcfc(:,:,i) = emp_hcfc(:,:,i)/max(max(emp_hcfc(:,:,i)));
            emp_hcfc(:,:,i) = (emp_hcfc(:,:,i) - min(min(emp_hcfc(:,:,i))))/(max(max(emp_hcfc(:,:,i)))-min(min(emp_hcfc(:,:,i))));
        end
        for i = 1:size(emp_mcifc,3)
            %emp_mcifc(:,:,i) = emp_mcifc(:,:,i) - eye(90,90);
            emp_mcifc(:,:,i) =  abs(emp_mcifc(:,:,i));
            %emp_mcifc(:,:,i) = emp_mcifc(:,:,i)/max(max(emp_mcifc(:,:,i)));
            emp_mcifc(:,:,i) = (emp_mcifc(:,:,i) - min(min(emp_mcifc(:,:,i))))/(max(max(emp_mcifc(:,:,i)))-min(min(emp_mcifc(:,:,i))));
        end
        for i = 1:size(emp_adfc,3)
            %emp_adfc(:,:,i) = emp_adfc(:,:,i) - eye(90,90);
            emp_adfc(:,:,i) =  abs(emp_adfc(:,:,i));
            %emp_adfc(:,:,i) = emp_adfc(:,:,i)/max(max(emp_adfc(:,:,i)));
            emp_adfc(:,:,i) = (emp_adfc(:,:,i) - min(min(emp_adfc(:,:,i))))/(max(max(emp_adfc(:,:,i)))-min(min(emp_adfc(:,:,i))));
        end
        % 并行设置
        delete(gcp('nocreate'))
        core_use = 11;       % 使用cpu核数?
        c = parpool(core_use);   % 开启并行池
        parfor i = 1:11
            %simhcfc = zeros(90,90,14);
            emphcfc = zeros(90,90,sub_hc);
            empmcifc = zeros(90,90,sub_mci);
            empadfc = zeros(90,90,sub_ad);
            for j = 1:sub_hc
                emphcfc(:,:,j) = yuzhi((i-1)*0.05,emp_hcfc(:,:,j));
            end
            for j=1:sub_mci
                empmcifc(:,:,j) = yuzhi((i-1)*0.05,emp_mcifc(:,:,j));
            end
            for j = 1:sub_ad
                empadfc(:,:,j) = yuzhi((i-1)*0.05,emp_adfc(:,:,j));
            end
            %%
            [emphc_C,~,~,emphc_Eloc] = compute_net(emphcfc,sub_hc);
            [empmci_C,~,~,empmci_Eloc] = compute_net(empmcifc,sub_mci);
            [empad_C,~,~,empad_Eloc] = compute_net(empadfc,sub_ad);
            %%
%             emphc_netC(:,:,i) = emphc_C;emphc_netEL(:,:,i) = emphc_Eloc;
%             emphc_net.C = emphc_netC;emphc_net.Eloc = emphc_netEL;
%             empmci_netC(:,:,i) = empmci_C;empmci_netEL(:,:,i) = empmci_Eloc;
%             empmci_net.C = empmci_netC;empmci_net.Eloc = empmci_netEL;
%             empad_netC(:,:,i) = empad_C;empad_netEL(:,:,i) = empad_Eloc;
%             empad_net.C = empad_netC;empad_net.Eloc = empad_netEL;
        emphc_netC(:,:,i) = emphc_C;
        emphc_netE(:,:,i) = emphc_Eloc;
        empmci_netC(:,:,i) = empmci_C;
        empmci_netE(:,:,i) = empmci_Eloc;
        empad_netC(:,:,i) = empad_C;
        empad_netE(:,:,i) = empad_Eloc;
        end
end