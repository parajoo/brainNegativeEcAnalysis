%% if calculate the empdata ,the diagonal data equal to 0,but to simulated data is 1
% clear all
% close all
% % load p_hcfc_scale.mat
% % load p_mcifc_scale.mat
% % load p_adfc_scale.mat
% load ('hc979_data.mat','hc979_simfc');
% load('mci838_data.mat','mci838_simfc');
% load('ad635_data.mat','ad635_simfc');
% [simhc_netC,simhc_netE,simmci_netC,simmci_netE,simad_netC,simad_netE] = cal_net_simfc_f(hc979_simfc,mci838_simfc,ad635_simfc);
function stiad_lobee = cal_net_simfc_parietal(stiadfc)
    
        sim_adfc = stiadfc;
        sub_mci = size(sim_adfc,3);
        for i = 1:size(sim_adfc,3)
            sim_adfc(:,:,i) = sim_adfc(:,:,i) - eye(90,90);
            sim_adfc(:,:,i) =  abs(sim_adfc(:,:,i));
            %emp_mcifc(:,:,i) = emp_mcifc(:,:,i)/max(max(emp_mcifc(:,:,i)));
            sim_adfc(:,:,i) = (sim_adfc(:,:,i) - min(min(sim_adfc(:,:,i))))/(max(max(sim_adfc(:,:,i)))-min(min(sim_adfc(:,:,i))));
        end
        for i = 1:11
            empadfc = zeros(90,90,sub_mci);
            for j=1:sub_mci
                empadfc(:,:,j) = yuzhi((i-1)*0.05,sim_adfc(:,:,j));
            end
            %%
            empmci_Eloc = compute_net_parietal(empadfc,sub_mci);
            %%
        stiad_lobee(:,:,i) = empmci_Eloc;
        end
end