le = length(results);
FC_emp = FC_HC90m;
FCemp1 = FC_emp / max(max(FC_emp));
every_fc = zeros(90,90,le);
fc_corr = zeros(1,le);
for iii = 1:le
    local_fc = results(iii).simFC;
    local_fcmean = mean(local_fc,3);
    every_fc(:,:,iii) = local_fcmean;
    CB_col = atanh(local_fcmean(Isubdiag));
    FC_emp_col = atanh(FCemp1(Isubdiag));
    rc = corrcoef((CB_col),(FC_emp_col));
    rc = rc(2);
    fc_corr(iii) = rc;
end