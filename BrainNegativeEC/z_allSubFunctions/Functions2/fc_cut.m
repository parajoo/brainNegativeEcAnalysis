clear all
close all
load trio_mci899.mat
load trio_hc517.mat
load trio_ad790.mat
simfc_hc = mean(hc_simfc,3)-eye(90,90);
empfc_hc = hc_fc;
simfc_ad = mean(ad_simfc,3)-eye(90,90);
empfc_ad = ad_fc;
simfc_mci = mean(mci_simfc,3)-eye(90,90);
empfc_mci = mci_fc;
minv = min([min(min(simfc_hc)),min(min(empfc_hc)),min(min(empfc_ad)),min(min(simfc_ad)),min(min(empfc_mci)),min(min(simfc_mci))]);
maxv = max([max(max(simfc_hc)),max(max(empfc_hc)),max(max(empfc_ad)),max(max(simfc_ad)),max(max(empfc_mci)),max(max(simfc_mci))]);

figure('color',[1 1 1]);subplot(1,2,1);imagesc(simfc_hc);colorbar;caxis([minv,maxv]);title('simfc')
subplot(1,2,2);imagesc(empfc_hc);colorbar;caxis([minv,maxv]);title('empfc')

figure('color',[1 1 1]);subplot(1,2,1);imagesc(simfc_mci);colorbar;caxis([minv,maxv]);title('simfc')
subplot(1,2,2);imagesc(empfc_mci);colorbar;caxis([minv,maxv]);title('empfc')

figure('color',[1 1 1]);subplot(1,2,1);imagesc(simfc_ad);colorbar;caxis([minv,maxv]);title('simfc')
subplot(1,2,2);imagesc(empfc_ad);colorbar;caxis([minv,maxv]);title('empfc')
