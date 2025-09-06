
idx = [8,9,10,11];
hcnodesfile = readtable('neecNodeFile.txt');
%nodeColor = [2,2.7,2.4,2.1,1.8,1.5,1.22,0.9,0.6,0.3];
nodeColor = [4,3.8,3.6,3.4,1.8,1.5,1.2,0.9,0.6,0.3];
sizeVec = [3:-0.2:1.2];
for i=1:length(idx)
    hcranki = neec_results(idx(i)).evc_iAd;
    hccolorVec = 0.1*ones(90,1);
    hcsizeColor = 0.1*ones(90,1);
    for j = 1:length(hcranki)
        hccolorVec(hcranki(j)) = nodeColor(j);
        hcsizeColor(hcranki(j)) = sizeVec(j);
    end
    hccur = hcnodesfile;
    hccur.VarName4 = hccolorVec;
    hccur.VarName5 = hcsizeColor;
    writetable(hccur,sprintf('tAD_fcpo%dtop10.txt',i),'Delimiter',' ');
end