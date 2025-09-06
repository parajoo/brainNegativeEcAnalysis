function kl_Div = ptrans_ksd(a,b)
matrix1_norm = a / sum(a); % 归一化
        matrix2_norm = b / sum(b) ; % normlize to (0,1], sum(matrix2_norm) == 1
        kl_Div = sum(matrix1_norm .* log(matrix1_norm ./ matrix2_norm));
end