clear all
%%
%parpool % 其中n是你想要的工作者数
load simfc_c4_hc20_new.mat
model_hc = simfc_c4_hc20;
for i = 1:14
    model_hc_0 = model_hc(:,:,i);
    model_hc_0(1:91:end) = 0;
    model_hcfc(:,:,i) = model_hc_0;
end
load HCFC_all_neww_atanh_new.mat
emp_hcfc = HCFC_all_neww_atanh;
for i = 1:14
    FC_hc_sim = emp_hcfc(:,:,i);
    FC_hc_sim(1:91:end) = 0;
    emp_hcfc(:,:,i) = FC_hc_sim;
end
load simfc_c4_ad15.mat
model_ad = simfc_c4_ad15;
for i = 1:14
    FC_ad_sim = model_ad(:,:,i);
    FC_ad_sim(1:91:end) = 0;
    model_adfc(:,:,i) = FC_ad_sim;
end
load ADFC_all_neww_atanh_new.mat
emp_adfc = ADFC_all_neww_atanh;
for i = 1:14
    model_ad_0= emp_adfc(:,:,i);
    model_ad_0(1:91:end) = 0;
    emp_adfc(:,:,i) = model_ad_0;
end
delete(gcp('nocreate'))
nTrials_use = 11; % trial 个数?
core_use = 11;       % 使用cpu核数?
c = parpool(core_use);   % 开启并行池
%%
mean_simhcfc = mean(model_hcfc,3);
mean_emphcfc = mean(emp_hcfc,3);
mean_simadfc = mean(model_adfc,3);
mean_empadfc = mean(emp_adfc,3);
%% 
for i = 1: size(model_hcfc,3)
model_hcfc(:,:,i) =  abs(model_hcfc(:,:,i));
model_hcfc(:,:,i) = (model_hcfc(:,:,i) - min(min(model_hcfc(:,:,i))))/(max(max(model_hcfc(:,:,i)))-min(min(model_hcfc(:,:,i))));
end
for i = 1:size(emp_hcfc,3)
emp_hcfc(:,:,i) =  abs(emp_hcfc(:,:,i));
emp_hcfc(:,:,i) = (emp_hcfc(:,:,i) - min(min(emp_hcfc(:,:,i))))/(max(max(emp_hcfc(:,:,i)))-min(min(emp_hcfc(:,:,i))));
end
for i = 1:size(model_adfc,3)
model_adfc(:,:,i) =  abs(model_adfc(:,:,i));
model_adfc(:,:,i) = (model_adfc(:,:,i) - min(min(model_adfc(:,:,i))))/(max(max(model_adfc(:,:,i)))-min(min(model_adfc(:,:,i))));
end
for i = 1:size(emp_adfc,3)
emp_adfc(:,:,i) =  abs(emp_adfc(:,:,i));
emp_adfc(:,:,i) = (emp_adfc(:,:,i) - min(min(emp_adfc(:,:,i))))/(max(max(emp_adfc(:,:,i)))-min(min(emp_adfc(:,:,i))));
end
parfor i = 1:11
    simhcfc = zeros(90,90,14);
    emphcfc = zeros(90,90,14);
    simadfc = zeros(90,90,14);
    empadfc = zeros(90,90,14);
    for j = 1:14
        simhcfc(:,:,j) = yuzhi((i-1)*0.05,model_hcfc(:,:,j));
        emphcfc(:,:,j) = yuzhi((i-1)*0.05,emp_hcfc(:,:,j));
        simadfc(:,:,j) = yuzhi((i-1)*0.05,model_adfc(:,:,j));
        empadfc(:,:,j) = yuzhi((i-1)*0.05,emp_adfc(:,:,j));
    end
    %%
    [simhc_C,simhc_L,simhc_Eglob,simhc_Eloc] = compute_net(simhcfc);
    [emphc_C,emphc_L,emphc_Eglob,emphc_Eloc] = compute_net(emphcfc);
    [simad_C,simad_L,simad_Eglob,simad_Eloc] = compute_net(simadfc);
    [empad_C,empad_L,empad_Eglob,empad_Eloc] = compute_net(empadfc);
    %%
    simhc_net(i,:,:) = [simhc_C,simhc_L,simhc_Eglob,simhc_Eloc];
    emphc_net(i,:,:) = [emphc_C,emphc_L,emphc_Eglob,emphc_Eloc];
    simad_net(i,:,:) = [simad_C,simad_L,simad_Eglob,simad_Eloc];
    empad_net(i,:,:) = [empad_C,empad_L,empad_Eglob,empad_Eloc];
    i
end
function [C,L,Eglob,Eloc] = compute_net(fc)
    for j = 1:14
        mat = fc(:,:,j);
        C(j)=mean(clustering_coef_wu(mat));
        D(:,:,j) = distance_wei(mat);  
        % Shortest path length
        L(j)=(( sum( sum(  ( 1./ (D(:,:,j)+0.5*eye(size(mat,1),size(mat,1))) ) ) )-4)/(size(mat,1)*(size(mat,1)-1)))/1;
        % global efficiency
        Eglob(j)=efficiency_wei(mat);
        % local efficiency
        Eloc(j)=mean(efficiency_wei(mat,1)); 
    end
    C = C';
    L = L';
    Eglob = Eglob';
    Eloc = Eloc';
end