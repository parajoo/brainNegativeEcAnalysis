function cov_matrix = calculate_shifted_covariance(data, lag)
    [num_regions, ~] = size(data); % 脑区数量
    cov_matrix = zeros(num_regions, num_regions);

    for i = 1:num_regions
        for j = 1:num_regions
            series1 = data(i, :);
            series2 = data(j, :);
            cov_matrix(i, j) = time_shifted_covariance(series1, series2, lag);
        end
    end
end


