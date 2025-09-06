%% if calculate the empdata ,the diagonal data equal to 0,but to simulated data is 1
% clear all
% close all
% load('ad981_res.mat','ad981_simfc')
% load('mci987_res.mat','mci987_simfc')
% load ('hc989_res.mat','hc989_simfc')
% [simhc_netC,simhc_netE,simmci_netC,simmci_netE,simad_netC,simad_netE] = cal_net_simfcl(hc989_simfc,mci987_simfc,ad981_simfc,1);
%save('group3')
% clear all
% close all
% % load ptGroup3Fc0707.mat
% % hcfc = ptHcFc0707;
% % mcifc = ptMciFc0707;
% % adfc = ptAdFc0707;
% % load hc757_data.mat
% % load mci856_data.mat
% % load ad809_data.mat
% load ('hc874_data.mat','hc874_simfc')
% load('mci874_data.mat','mci874_simfc')
% load('ad635_data.mat','ad635_simfc')
% hcfc = hc874_simfc;
% mcifc = mci874_simfc;
% adfc = ad635_simfc;
% [emphc_netC,emphc_netE,empmci_netC,empmci_netE,empad_netC,empad_netE] = cal_net_simfcl(hcfc,mcifc,adfc,1);
% clear all
% close all
% load('ad943_data.mat','ad943_simfc')
% load('mci848_data.mat','mci848_simfc')
% load ('hc895_data.mat','hc895_simfc')
% [simhc_netC,simhc_netE,simmci_netC,simmci_netE,simad_netC,simad_netE] = calFcCCandElocl(hc895_simfc,mci848_simfc,ad943_simfc,1);
% clear all
% close all
% load ('tGroup3Fc_scale0905.mat','tAdFc','tMciFc','tHcFc')
% [emphc_netC,emphc_netE,empmci_netC,empmci_netE,empad_netC,empad_netE] = calFcCCandElocl(tHcFc,tMciFc,tAdFc,0);
% clear tHcFc tMciFc tAdFc
function [emphc_netC,emphc_netE,empmci_netC,empmci_netE,empad_netC,empad_netE] = calFcCCandEloc(hcfc,mcifc,adfc,digIdx)
    
        emp_hcfc = hcfc;
        emp_mcifc = mcifc;
        emp_adfc = adfc;
        sub_hc = size(emp_hcfc,3);
        sub_mci = size(emp_mcifc,3);
        sub_ad = size(emp_adfc,3);
        %% min-max normalized
        %% max
        for i = 1:size(emp_hcfc,3)
            if digIdx == 1
                emp_hcfc(:,:,i) = emp_hcfc(:,:,i) - eye(90,90);
            end
            emp_hcfc(:,:,i) =  abs(emp_hcfc(:,:,i));
            %emp_hcfc(:,:,i) = emp_hcfc(:,:,i)/max(max(emp_hcfc(:,:,i)));
            emp_hcfc(:,:,i) = (emp_hcfc(:,:,i) - min(min(emp_hcfc(:,:,i))))/(max(max(emp_hcfc(:,:,i)))-min(min(emp_hcfc(:,:,i))));
        end
        for i = 1:size(emp_mcifc,3)
            if digIdx == 1
                emp_mcifc(:,:,i) = emp_mcifc(:,:,i) - eye(90,90);
            end
            emp_mcifc(:,:,i) =  abs(emp_mcifc(:,:,i));
            %emp_mcifc(:,:,i) = emp_mcifc(:,:,i)/max(max(emp_mcifc(:,:,i)));
            emp_mcifc(:,:,i) = (emp_mcifc(:,:,i) - min(min(emp_mcifc(:,:,i))))/(max(max(emp_mcifc(:,:,i)))-min(min(emp_mcifc(:,:,i))));
        end
        for i = 1:size(emp_adfc,3)
            if digIdx == 1
                emp_adfc(:,:,i) = emp_adfc(:,:,i) - eye(90,90);
            end
            emp_adfc(:,:,i) =  abs(emp_adfc(:,:,i));
            %emp_adfc(:,:,i) = emp_adfc(:,:,i)/max(max(emp_adfc(:,:,i)));
            emp_adfc(:,:,i) = (emp_adfc(:,:,i) - min(min(emp_adfc(:,:,i))))/(max(max(emp_adfc(:,:,i)))-min(min(emp_adfc(:,:,i))));
        end
        % 并行设置
%         delete(gcp('nocreate'))
%     core_use = 11;       % 使用cpu核数?
%     c = parpool(core_use); 
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
