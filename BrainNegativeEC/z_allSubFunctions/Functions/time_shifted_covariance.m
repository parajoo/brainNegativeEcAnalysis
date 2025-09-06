function cov_shifted = time_shifted_covariance(series1, series2, lag)
    % 计算两个时间序列在给定时间延迟下的协方差
    N = length(series1) - lag;
    mean1 = mean(series1(1:N));
    mean2 = mean(series2(lag+1:end));
    cov_shifted = mean((series1(1:N) - mean1) .* (series2(lag+1:end) - mean2));
end