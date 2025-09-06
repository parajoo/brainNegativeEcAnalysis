function [iFC_all,Leading_Eig] = leida_sim_trials(input,flp,fhi,trail)

disp('Processing the eigenvectors from BOLD data')
% Load here the BOLD data (which may be in different formats)
% Here the BOLD time courses in AAL parcellation are organized as cells,
% where tc_aal{1,1} corresponds to the BOLD data from subject 1 in
% condition 1 and contains a matrix with lines=N_areas and columns=Tmax.tra = 14; % Number of Healthy Control Subjects
%trail = 14; % Number of Alzheimer's Disease Subjects

%CASE 2= hc ; CASE 1= ad

% Process Healthy Control data
for nsub=1:trail
    CASE=1;
    tc_aal_new{nsub,1}=input{nsub,CASE};
end
[n_Subjects, n_cond]=size(tc_aal_new);
[N_areas, Tmax]=size(tc_aal_new{1,1});

% Parameters of the data
TR=2.;  % Repetition Time (seconds)

% Preallocate variables to save FC patterns and associated information
Leading_Eig=zeros(Tmax*n_Subjects,1*N_areas); % All leading eigenvectors
Time_all=zeros(2, n_Subjects*Tmax); % vector with subject nr and cond at each t
iFC_all = zeros(Tmax*n_Subjects,N_areas,N_areas);
t_all=0; % Index of time (starts at 0 and will be updated until n_Sub*Tmax)

% Bandpass filter settings
fnq=1/(2*TR);                 % Nyquist frequency
%flp = 0.03;                    % lowpass frequency of filter (Hz)
%fhi = 0.08;                    % highpass
Wn=[flp/fnq fhi/fnq];         % butterworth bandpass non-dimensional frequency
k=2;                          % 2nd order butterworth filter
[bfilt,afilt]=butter(k,Wn);   % construct the filter
clear fnq flp fhi Wn k

for s=1:n_Subjects
    for cond=1:n_cond
        [N_areas, Tmax]=size(tc_aal_new{s,cond});
        % Get the BOLD signals from this subject in this condition
        BOLD = tc_aal_new{s,cond};
        Phase_BOLD=zeros(N_areas,Tmax);
        
        % Get the BOLD phase using the Hilbert transform
        for seed=1:N_areas
            ts=demean(detrend(BOLD(seed,:)));
            signal_filt =filtfilt(bfilt,afilt,ts);
            Phase_BOLD(seed,:) = angle(hilbert(signal_filt));
        end
        
        for t=1:Tmax
            
            %Calculate the Instantaneous FC (BOLD Phase Synchrony)
            iFC=zeros(N_areas);
            for n=1:N_areas
                for p=1:N_areas
                    iFC(n,p)=cos(Phase_BOLD(n,t)-Phase_BOLD(p,t));
                end
            end
            
            % Get the leading eigenvector
            
            [V1,~]=eigs(iFC,1);
            % Make sure the largest component is negative
            if mean(V1>0)>.5
                V1=-V1;
            elseif mean(V1>0)==.5 && sum(V1(V1>0))>-sum(V1(V1<0))
                V1=-V1;
            end           
            % Save V1 from all frames in all fMRI sessions in Leading eig
            t_all=t_all+1; % Update time
            Leading_Eig(t_all,:)=V1; %vertcat(V1,V2);
            iFC_all(t_all,:,:) = iFC;
            Time_all(:,t_all)=[s cond]; % Information that at t_all, V1 corresponds to subject s in a given condition
        end
    end
end