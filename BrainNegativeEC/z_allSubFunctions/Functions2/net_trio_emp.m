clear all
close all
%%
%parpool % 其中n是你想要的工作者数
% load hc42_fc.mat
% emp_hcfc = hc42_fc;

% load mci42_fc.mat
% emp_mcifc = mci42_fc;
load('trio_ad25.mat', 'trio_ad25_fc')
load('trio_hc25.mat', 'trio_hc25_fc')
load('trio_mci25.mat', 'trio_mci25_fc')
emp_hcfc = trio_hc25_fc;
emp_mcifc = trio_mci25_fc;
emp_adfc = trio_ad25_fc;
% load ad42_fc.mat
% emp_adfc = ad42_fc;
sub = 25;
%% 
% 并行设置
    delete(gcp('nocreate'))
    core_use = 11;       % 使用cpu核数?
    c = parpool(core_use);   % 开启并行池
%%
mean_emphcfc = mean(emp_hcfc,3);
mean_empmcifc = mean(emp_mcifc,3);
mean_empadfc = mean(emp_adfc,3);
%% min-max normalized
for i = 1:size(emp_mcifc,3)
emp_mcifc(:,:,i) =  abs(emp_mcifc(:,:,i));
emp_mcifc(:,:,i) = (emp_mcifc(:,:,i) - min(min(emp_mcifc(:,:,i))))/(max(max(emp_mcifc(:,:,i)))-min(min(emp_mcifc(:,:,i))));
end
for i = 1:size(emp_hcfc,3)
emp_hcfc(:,:,i) =  abs(emp_hcfc(:,:,i));
emp_hcfc(:,:,i) = (emp_hcfc(:,:,i) - min(min(emp_hcfc(:,:,i))))/(max(max(emp_hcfc(:,:,i)))-min(min(emp_hcfc(:,:,i))));
end
for i = 1:size(emp_adfc,3)
emp_adfc(:,:,i) =  abs(emp_adfc(:,:,i));
emp_adfc(:,:,i) = (emp_adfc(:,:,i) - min(min(emp_adfc(:,:,i))))/(max(max(emp_adfc(:,:,i)))-min(min(emp_adfc(:,:,i))));
end
parfor i = 1:11
    %simhcfc = zeros(90,90,14);
    emphcfc = zeros(90,90,sub);
    empmcifc = zeros(90,90,sub);
    empadfc = zeros(90,90,sub);
    for j = 1:sub
        %simhcfc(:,:,j) = yuzhi((i-1)*0.05,emp_adfc(:,:,j));
        emphcfc(:,:,j) = yuzhi((i-1)*0.05,emp_hcfc(:,:,j));
        empmcifc(:,:,j) = yuzhi((i-1)*0.05,emp_mcifc(:,:,j));
        empadfc(:,:,j) = yuzhi((i-1)*0.05,emp_adfc(:,:,j));
    end
%     for k=1:41
%         empmcifc(:,:,k) = yuzhi((i-1)*0.05,emp_hcfc(:,:,k));
%     end
    %%
    %[simhc_C,simhc_L,simhc_Eglob,simhc_Eloc] = compute_net(simhcfc);
    [emphc_C,emphc_L,emphc_Eglob,emphc_Eloc] = compute_net(emphcfc,sub);
    [empmci_C,empmci_L,empmci_Eglob,empmci_Eloc] = compute_net(empmcifc,sub);
    [empad_C,empad_L,empad_Eglob,empad_Eloc] = compute_net(empadfc,sub);
    
    %%
    %simhc_net(i,:,:) = [simhc_C,simhc_L,simhc_Eglob,simhc_Eloc];
    emphc_net(i,:,:) = [emphc_C,emphc_L,emphc_Eglob,emphc_Eloc];
    empmci_net(i,:,:) = [empmci_C,empmci_L,empmci_Eglob,empmci_Eloc];
    empmad_net(i,:,:) = [empad_C,empad_L,empad_Eglob,empad_Eloc];
    
    i
end
function [C,L,Eglob,Eloc] = compute_net(fc,sub)
    for j = 1:sub
        mat = fc(:,:,j);
        C(j)=mean(clustering_coef_wu(mat));
        D(:,:,j) = distance_wei(mat);  
        % Shortest path length
        %L(j)=( sum( sum(  ( 1./ (D(:,:,j)+0.5*eye(size(mat,1),size(mat,1))) ) ) )-4)/size(mat,1)*(size(mat,1)-1);
        L(j)= ( sum( sum(1./( D(:,:,j)+eye(size(mat,1),size(mat,1)) ) ) )-size(mat,1) )/(size(mat,1)*(size(mat,1)-1));
        % global efficiency
        Eglob(j)=efficiency_wei(mat);
        %Eglob(j) = ( sum( sum(   D(:,:,j)  ) )-4)/size(mat,1)*(size(mat,1)-1);
        % local efficiency
        Eloc(j)=mean(efficiency_wei(mat,1)); 
    end
    C = C';
    L = L';
    Eglob = Eglob';
    Eloc = Eloc';
end
% function [C,L,Eglob,Eloc] = compute_net_41(fc)
%     for j = 1:41
%         mat = fc(:,:,j);
%         C(j)=mean(clustering_coef_wu(mat));
%         D(:,:,j) = distance_wei(mat);  
%         % Shortest path length
%         %L(j)=( sum( sum(  ( 1./ (D(:,:,j)+0.5*eye(size(mat,1),size(mat,1))) ) ) )-4)/size(mat,1)*(size(mat,1)-1);
%         L(j)= ( sum( sum(1./( D(:,:,j)+eye(size(mat,1),size(mat,1)) ) ) )-size(mat,1) )/(size(mat,1)*(size(mat,1)-1));
%         % global efficiency
%         Eglob(j)=efficiency_wei(mat);
%         %Eglob(j) = ( sum( sum(   D(:,:,j)  ) )-4)/size(mat,1)*(size(mat,1)-1);
%         % local efficiency
%         Eloc(j)=mean(efficiency_wei(mat,1)); 
%     end
%     C = C';
%     L = L';
%     Eglob = Eglob';
%     Eloc = Eloc';
% end