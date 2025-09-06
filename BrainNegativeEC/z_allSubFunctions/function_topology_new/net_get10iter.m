% clear all
% load mci1000.mat
kl_pms_history = [ad_results.kld_pms];
range = [80,100,200,300,400,500,600,700,800,900,1000];
idx_range = zeros(1,10);
idx_mv = zeros(1,10);
idx_rc = zeros(1,10);
%mci_simfc_iter10 = zeros(90,90,15,length(idx_range));
for i=1:10
    [mv_temp,mi_temp] = min(kl_pms_history(range(i):range(i+1)));
    idx_range(i) = (range(i)+mi_temp-1);
    idx_mv(i) = mv_temp;
    idx_rc(i) = ad_results(range(i)+mi_temp-1).corr;
end
% for j=1:length(idx_range)
%     mci_simfc_iter10(:,:,:,j) = results(idx_range(j)).simFC;
% end