
clear all
load BOLD_Signals.mat
Leading_Eig_hc_sim = zeros(14, 308, 90); % 初始化一个三维数组用来存储主特征向量，14个被试，230个时间点，90个脑区

for s = 1:14
    % 每次循环加载一个新的被试的数据
%     load(sprintf('ads%d.mat', s)); % 使用sprintf来动态生成文件名
    BOLD = BOLD_Signals(:,:,s);
    BOLD = BOLD';
    [N_areas, Tmax] = size(BOLD);
    Phase_BOLD = zeros(N_areas, Tmax);
    L_EIG = zeros(N_areas, Tmax);
    
    % 数据预处理，去除均值
    for j = 1:N_areas
        BOLD(:,j) = BOLD(:,j) - mean(BOLD(:,j));
    end
    
    % 计算相位
    for i = 1:N_areas
        Phase_BOLD(i,:) = angle(hilbert(BOLD(i,:)));
    end
    
    % 计算主特征向量
    for t = 1:Tmax
        iFC = zeros(N_areas);
        for n = 1:N_areas
            for p = 1:N_areas
                iFC(n,p) = cos(Phase_BOLD(n,t) - Phase_BOLD(p,t));
            end
        end
        
        [V1, ~] = eigs(iFC, 1);
        if mean(V1 > 0) > .5
            V1 = -V1;
        elseif mean(V1 > 0) == .5 && sum(V1(V1 > 0)) > -sum(V1(V1 < 0))
            V1 = -V1;
        end
        
        L_EIG(:, t) = V1;
    end
    
    % 将计算得到的特征向量存储到三维数组中
    Leading_Eig_hc_sim(s, :, :) = L_EIG.';
end

% 保存最终的三维数组
% save('Leading_Eig_noncen_29sub.mat', 'Leading_Eig_ad');
