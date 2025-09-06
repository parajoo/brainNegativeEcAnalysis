function  Eloc  = compute_net_parietal(fc,sub)
    for j = 1:sub
        mat = fc(:,:,j);
        Eloc(:,j)=efficiency_wei(mat,1); 
    end
%     C = C';
%     L = L';
%     Eglob = Eglob';
%     Eloc = Eloc';
end