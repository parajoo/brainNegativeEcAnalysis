% close all
% city_results = results_cityp;
% textBook = [city_results.cluster_num];
% clear results_city
% oulad_results = 0.1*ones(1,10);
% cos_results = 0;
% oula_results = oulad_results;
% for i = 1:length(oula_results)
%     city_results(i).maxdiff = max(abs(city_results(i).pms_hc_all - city_results(i).pms_ad_all));
% end
% city_maxdiff = [city_results.maxdiff];
% figure('Color',[1 1 1]);
% plot(1:10,city_maxdiff,'-o','color',[250 127 111]/255,'LineWidth',1.5,'MarkerFaceColor',[250 127 111]/255);
% hold on
% for i = 1:10
%     text(i, city_maxdiff(i)+0.001, sprintf('N_s:%d', textBook(i)), ...
%         'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8);
% end
% 
% xlabel('band combinations')
% ylabel('max difference')
% legend('cityblock')
% hold off


%% plot the number of negative elelments under 1000 iterations
% num_negative_ele = zeros(1,1000);
% for i = 1:length(num_negative_ele)
%     ec_cur = results(i).SCnew;
%     num_negative_ele(i) = sum(ec_cur<0,'all');
% end
% figure('color',[1 1 1]);plot(1:length(num_negative_ele),num_negative_ele,'color',[153 153 153]/255,'LineWidth',1.5)