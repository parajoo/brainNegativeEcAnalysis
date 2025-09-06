function kld = calculateKLDivergences_test_new(pms_emp, pms_sim)
Ind = find(pms_sim~=0);
kld = 0.5*(sum(pms_sim(Ind).*log(pms_sim(Ind)./pms_emp(Ind)))+sum(pms_emp(Ind).*log(pms_emp(Ind)./pms_sim(Ind))));