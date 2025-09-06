for i=1:length(results)
    pms_hc_cur = results(i).pms_hc;
    pms_ad_cur = results(i).pms_ad;
    diff = abs(pms_ad_cur - pms_hc_cur);
    maxdiff = max(diff);
    results(i).maxdiff = maxdiff;
end