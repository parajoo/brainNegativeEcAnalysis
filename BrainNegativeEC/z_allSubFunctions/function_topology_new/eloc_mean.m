clear all
close all
% load p_ad_fc.mat
% load p_hc_fc.mat
% load p_mci_fc.mat
% load ad_simfc_iter10.mat
% load mci_simfc_iter10.mat
% load hc_simfc_iter10.mat
% 
% p_hc_empfc = p_hc_fc;
% p_mci_empfc = p_mci_fc;
% p_ad_empfc = p_ad_fc;
% sub_hc = size(p_hc_empfc,3);
% sub_mci = size(p_mci_empfc,3);
% sub_ad = size(p_ad_empfc,3);
% sub_sim = 15;
% emphc_net_all = zeros(11,90,23,10);
% empmci_net_all = zeros(11,90,21,10);
% empad_net_all = zeros(11,90,21,10);
% simhc_net_all = zeros(11,90,15,10);
% simmci_net_all = zeros(11,90,15,10);
% simad_net_all = zeros(11,90,15,10);
% for kkk=1:10
% p_hc_simfc = hc_simfc_iter10(:,:,:,kkk);
% p_mci_simfc = mci_simfc_iter10(:,:,:,kkk);
% p_ad_simfc = ad_simfc_iter10(:,:,:,kkk);
%% difference of topology bewteen group-level FC
load hc1000_results.mat
hc_results = results;
clear results
load mci1000_results.mat
mci_results = results;
clear results
load ad1000_results.mat
ad_results = results;
clear results
load emp_sim_iter8_fc.mat
p_hc_empfc = emphc_mean;
p_mci_empfc = empmci_mean;
p_ad_empfc = empad_mean;
corr_hc = zeros(1,1000);
corr_mci = zeros(1,1000);
corr_ad = zeros(1,1000);
for kkk=1:1000

p_hc_simfc = mean(hc_results(kkk).simFC,3);
p_mci_simfc = mean(mci_results(kkk).simFC,3);
p_ad_simfc = mean(ad_results(kkk).simFC,3);
sub_hc = size(p_hc_empfc,3);
sub_mci = size(p_mci_empfc,3);
sub_ad = size(p_ad_empfc,3);
sub_sim = size(p_hc_simfc,3);
%% min-max normalization
for i=1:size(p_hc_simfc,3)
    p_hc_simfc(:,:,i) = p_hc_simfc(:,:,i) - eye(90,90);
    p_mci_simfc(:,:,i) = p_mci_simfc(:,:,i) - eye(90,90);
    p_ad_simfc(:,:,i) = p_ad_simfc(:,:,i) - eye(90,90);
end
for i = 1:size(p_hc_empfc,3)
    p_hc_empfc(:,:,i) =  abs(p_hc_empfc(:,:,i));
    p_hc_empfc(:,:,i) = (p_hc_empfc(:,:,i) - min(min(p_hc_empfc(:,:,i))))/(max(max(p_hc_empfc(:,:,i)))-min(min(p_hc_empfc(:,:,i))));
end

for i = 1:size(p_mci_empfc,3)
    p_mci_empfc(:,:,i) =  abs(p_mci_empfc(:,:,i));
    p_mci_empfc(:,:,i) = (p_mci_empfc(:,:,i) - min(min(p_mci_empfc(:,:,i))))/(max(max(p_mci_empfc(:,:,i)))-min(min(p_mci_empfc(:,:,i))));
end

for i = 1:size(p_ad_empfc,3)
    p_ad_empfc(:,:,i) =  abs(p_ad_empfc(:,:,i));
    p_ad_empfc(:,:,i) = (p_ad_empfc(:,:,i) - min(min(p_ad_empfc(:,:,i))))/(max(max(p_ad_empfc(:,:,i)))-min(min(p_ad_empfc(:,:,i))));
end

for i = 1:size(p_hc_simfc,3)
    p_hc_simfc(:,:,i) =  abs(p_hc_simfc(:,:,i));
    p_hc_simfc(:,:,i) = (p_hc_simfc(:,:,i) - min(min(p_hc_simfc(:,:,i))))/(max(max(p_hc_simfc(:,:,i)))-min(min(p_hc_simfc(:,:,i))));
end
for i = 1:size(p_mci_simfc,3)
    p_mci_simfc(:,:,i) =  abs(p_mci_simfc(:,:,i));
    p_mci_simfc(:,:,i) = (p_mci_simfc(:,:,i) - min(min(p_mci_simfc(:,:,i))))/(max(max(p_mci_simfc(:,:,i)))-min(min(p_mci_simfc(:,:,i))));
end
for i = 1:size(p_ad_simfc,3)
    p_ad_simfc(:,:,i) =  abs(p_ad_simfc(:,:,i));
    p_ad_simfc(:,:,i) = (p_ad_simfc(:,:,i) - min(min(p_ad_simfc(:,:,i))))/(max(max(p_ad_simfc(:,:,i)))-min(min(p_ad_simfc(:,:,i))));
end
%% calculate the CC and Eloc of different sub-networks
parfor i=1:11
    emphcfc = zeros(90,90,sub_hc);
    simhcfc = zeros(90,90,sub_sim);
    empmcifc = zeros(90,90,sub_mci);
    simmcifc = zeros(90,90,sub_sim);
    empadfc = zeros(90,90,sub_ad);
    simadfc = zeros(90,90,sub_sim);
    for j = 1:sub_hc
        emphcfc(:,:,j) = yuzhi((i-1)*0.05,p_hc_empfc(:,:,j));
    end
    for j=1:sub_mci
        empmcifc(:,:,j) = yuzhi((i-1)*0.05,p_mci_empfc(:,:,j));
    end
    for j = 1:sub_ad
        empadfc(:,:,j) = yuzhi((i-1)*0.05,p_ad_empfc(:,:,j));
    end
    for j=1:sub_sim
        simhcfc(:,:,j) = yuzhi((i-1)*0.05,p_hc_simfc(:,:,j));
        simmcifc(:,:,j) = yuzhi((i-1)*0.05,p_mci_simfc(:,:,j));
        simadfc(:,:,j) = yuzhi((i-1)*0.05,p_ad_simfc(:,:,j));
    end
    %%
    emphc_nodeEloc = compute_netnode(emphcfc,sub_hc);
    simhc_nodeEloc = compute_netnode(simhcfc,sub_sim);
    empmci_nodeEloc = compute_netnode(empmcifc,sub_mci);
    simmci_nodeEloc = compute_netnode(simmcifc,sub_sim);
    empad_nodeEloc = compute_netnode(empadfc,sub_ad);
    simad_nodeEloc = compute_netnode(simadfc,sub_sim);
    
    %%
    emphc_net(i,:,:) = emphc_nodeEloc;
    empmci_net(i,:,:) = empmci_nodeEloc;
    empmad_net(i,:,:) = empad_nodeEloc;
    simhc_net(i,:,:) = simhc_nodeEloc;
    simmci_net(i,:,:) = simmci_nodeEloc;
    simad_net(i,:,:) = simad_nodeEloc;
end
% emphc_net_all(:,:,:,kkk) = emphc_net;
% empmci_net_all(:,:,:,kkk) = empmci_net;
% empad_net_all(:,:,:,kkk) = empmad_net;
% simhc_net_all(:,:,:,kkk) = simhc_net;
% simmci_net_all(:,:,:,kkk) = simmci_net;
% simad_net_all(:,:,:,kkk) = simad_net;
%end
corr_hc(kkk) = corr(emphc_net(:),simhc_net(:));
corr_mci(kkk) = corr(empmci_net(:),simmci_net(:));
corr_ad(kkk) = corr(empmad_net(:),simad_net(:));
end
function C = compute_netnode(fc,sub)
C = zeros(90,sub);
%Eloc = zeros(90,sub);
    for j = 1:sub
        mat = fc(:,:,j);
        C(:,j)=clustering_coef_wu(mat); 
        %Eloc(:,j)=efficiency_wei(mat,1);
    end
end


