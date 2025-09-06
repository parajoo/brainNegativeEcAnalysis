% clear all
% close all
% load('/home/zengmin/model/pms_tianjin_data/HH_data/trio_sub25_orangebox/trio_ad25.mat', 'trio_ad25_bold')
% load('/home/zengmin/model/pms_tianjin_data/HH_data/trio_sub25_orangebox/trio_hc25.mat', 'trio_hc25_bold')
% load('/home/zengmin/model/pms_tianjin_data/HH_data/trio_sub25_orangebox/trio_mci25.mat', 'trio_mci25_bold')
clear all
load trioHcBold0707.mat
hc_bold = bold_g;
clear bold_g
load trioMciBold0707.mat
mci_bold = bold_g;
clear bold_g
load trioAdBold0707.mat
ad_bold = bold_g;
clear bold_g
% TR = 2.0;       % 举例
% fs = 1 / TR;
% nyquist = fs / 2;
% 
% high_cutoff = 0.08 / nyquist;
% 
% % 只做低通滤波（低于0.08Hz保留）
% [b, a] = butter(2, high_cutoff, 'low');
% bold_data = permute(hc_bold,[2,1,3]);
% boldDataNew = zeros(size(bold_data));
% for i = 1:size(bold_data,3)
%     bold_refined = zeros(116,170);
%     for roi = 1:size(bold_data, 1)
%         bold_refined(roi, :) = filtfilt(b, a, squeeze(bold_data(roi,:,i)));
%     end
%    boldDataNew(:,:,i) = bold_refined;
% end

trioHcFc0707 = zeros(90,90,43);
trioMciFc0707 = zeros(90,90,45);
trioAdFc0707 = zeros(90,90,53);
% % for i=1:41
% %     ad_sdata = squeeze(g_ad41(:,1:90,i));
% %     ad_corr = atanh(corr(ad_sdata));
% %     ad_corr(1:91:end) = 0;
% %     hc22_fc_g(:,:,i) = ad_corr;
% % end
hcBoldNew = hc_bold;
for s = 1:size(trioHcFc0707,3)
    hc_sdata = squeeze(hcBoldNew(:,1:90,s));
    hc_corr = atanh(corr(hc_sdata));
    hc_corr(1:91:end) = 0;
    trioHcFc0707(:,:,s) = hc_corr;
end
for s =1:size(trioMciFc0707,3)
    mci_sdata = squeeze(mci_bold(:,1:90,s));
    mci_corr = atanh(corr(mci_sdata));
    mci_corr(1:91:end) = 0;
    trioMciFc0707(:,:,s) = mci_corr;
end
for s=1:size(trioAdFc0707,3)
    ad_sdata = squeeze(ad_bold(:,1:90,s));
    ad_corr = atanh(corr(ad_sdata));
    ad_corr(1:91:end) = 0;
    trioAdFc0707(:,:,s) = ad_corr;
end
save('group3Fc0707.mat','trioHcFc0707','trioMciFc0707','trioAdFc0707')
% % save('hc24_fc.mat','hc24_fc')
% % save('mci24_fc.mat','mci24_fc')
% % save('ad24_fc.mat','ad24_fc')
% % for i=1:14
%     fc_mciad = squeeze(fc_mciad14_g(:,:,i));
%     filename = sprintf('fc_mciads%d.mat',i);
%     save(filename,'fc_mciad');
% end