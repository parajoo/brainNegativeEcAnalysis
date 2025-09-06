function [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8]=getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll)
    hcArea8 = zeros(15,8);
    adArea8 = zeros(15,8);
    stiadArea8 = zeros(15,8);
    phcad8 = zeros(8,1);
    phcstiad8 = zeros(8,1);
    for jjj = 1:15
        hcfcNew(:,:,jjj) = hcfc(:,:,jjj) - eye(90,90);
        adfcNew(:,:,jjj) = adfc(:,:,jjj) - eye(90,90);
        stiadfcNew(:,:,jjj) = stiadfc(:,:,jjj) - eye(90,90);
    end
    for i=1:4
        hceloci = mean(mean(hcEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        adeloci = mean(mean(adEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        stiadeloci = mean(mean(stiadEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        hcArea8(:,i) = hceloci;
        adArea8(:,i) = adeloci;
        stiadArea8(:,i) = stiadeloci;
        [~,phcad8(i)] = ttest2(hceloci,adeloci);
        [~,phcstiad8(i)] = ttest2(hceloci,stiadeloci);
    end
    for i=5:8
        hcmsi = mean(squeeze(mean(hcfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
       admsi = mean(squeeze(mean(adfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
        stiadmsi = mean(squeeze(mean(stiadfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
        hcArea8(:,i) = hcmsi;
        adArea8(:,i) = admsi;
        stiadArea8(:,i) = stiadmsi;
        [~,phcad8(i)] = ttest2(hcmsi,admsi);
        [~,phcstiad8(i)] = ttest2(hcmsi,stiadmsi);
    end
end