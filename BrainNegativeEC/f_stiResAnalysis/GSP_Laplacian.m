clear all
close all
%mypath = '/home/zengmin/model/pms_tianjin_data/GSP_StructuralDecouplingIndex-master/Code_NCOMMS/Matlab'
%% 1. Loading required data
% %load('/home/zengmin/model/pms_tianjin_data/prisma_moca0105_data/model_results/ad635_data.mat')
% load p_adbds_scale.mat
% load p_adsc_scale.mat
load ('hc895_data.mat','hc894_ec','hc895_simbold')
bold = hc895_simbold;
sc = hc894_ec;
% W=load('/home/zengmin/model/pms_tianjin_data/GSP_StructuralDecouplingIndex-master/Code_NCOMMS/Matlab/data/SC_avg56');
% W=W.SC_avg56;
W = sc;
W(W<0) = 0;
%W=abs(W);
% X_RS=load('/home/zengmin/model/pms_tianjin_data/GSP_StructuralDecouplingIndex-master/Code_NCOMMS/Matlab/data/X_RS_10subjects');
% X_RS=X_RS.X_RS;
for i=1:size(bold,3)
    X_RS(:,:,i) = bold(:,:,i)';
end
%% zscore fMRI timecourses
zX_RS=zscore(X_RS,0,2);
%zX_RS=X_RS;
%%
% Number of regions
n_ROI = size(W,1);
% number of subjects
nsubjs_RS=size(zX_RS,3);

%% Symmetric Normalization of adjacency matrix
D=diag(sum(abs(W),2)); %degree
Wsymm=D^(-1/2)*W*D^(-1/2);
Wnew=Wsymm;
%Wnew= W;
%% compute normalized Laplacian
L=eye(n_ROI)-Wnew;

%% Laplacian Decomposition
[U,LambdaL] = eig(L);
[LambdaL, IndL]=sort(diag(LambdaL));
U=U(:,IndL);

%% Compute weighted zero crossings for Laplacian eigenvectors (Supplementary Figure S1)
for u=1:90%for each eigenvector
    UU=U(:,u);%-mean(U(:,u));
    summ=0;
    for i=1:89 %for each connection
        for j=i+1:90
            if (UU(i)*UU(j))<0 %if signals are of opposite signs
                summ=summ+(W(i,j)>1);%W(i,j);
            end
            wZC(u)=summ;
        end
    end
end

figure;plot(wZC);title ('Supplementary Fig. S1');xlabel('Connectome harmonics');ylabel('Weighted zero crossings')

%% Average energy spectral density of resting-state functional data projected on the structural harmonics
clear X_hat_L
for s=1:nsubjs_RS
    X_hat_L(:,:,s)=U'*zX_RS(:,:,s);
end
pow=abs(X_hat_L).^2;
PSD=squeeze(mean(pow,2));

avg=mean(PSD')';
stdPSD=std(PSD')';
upper1=avg+stdPSD;
lower1=avg-stdPSD;
idx = max(PSD')>0 & min(PSD')>0 & mean(PSD')>0;                       

figure;
for i = 1:length(LambdaL)
    if LambdaL(i) < 0.00001
        LambdaL(i) = 0;
    end
end
patch([LambdaL(idx)', fliplr(LambdaL(idx)')], [lower1(idx)'  fliplr(upper1(idx)')], [0.8 0.8 0.8]);hold on;plot(LambdaL,avg);
%xlim([0.05 2]);ylim([0.02 50]);
title('Supplementary Fig. S2');xlabel('Harmonic Frequency');ylabel('Energy')
set(gca, 'XScale', 'log', 'YScale','log')

%% compute cut-off frequency
mPSD=mean(PSD,2);
AUCTOT=trapz(mPSD(1:n_ROI)); %total area under the curve

i=0;
AUC=0;
while AUC<AUCTOT/2
    AUC=trapz(mPSD(1:i));
    i=i+1;
end
NN=i-1; %CUTOFF FREQUENCY C : number of low frequency eigenvalues to consider in order to have the same energy as the high freq ones
NNL=n_ROI-NN; 

%% split structural harmonics in high/low frequency

M=fliplr(U); %Laplacian eigenvectors flipped in order (high frequencies first)

Vlow=zeros(size(M));
Vhigh=zeros(size(M));
Vhigh(:,1:NNL)=M(:,1:NNL);%high frequencies= decoupled 
Vlow(:,end-NN+1:end)=M(:,end-NN+1:end);%low frequencies = coupled 
