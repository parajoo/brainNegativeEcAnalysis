function [C,L,Eglob,Eloc] = compute_net(fc,sub)
    for j = 1:sub
        mat = fc(:,:,j);
        C(:,j)=clustering_coef_wu(mat);
        D(:,:,j) = distance_wei(mat);  
        L(:,j)= ( sum( sum(1./( D(:,:,j)+eye(size(mat,1),size(mat,1)) ) ) )-size(mat,1) )/(size(mat,1)*(size(mat,1)-1));
        
        Eglob(:,j)=efficiency_wei(mat);
        Eloc(:,j)=efficiency_wei(mat,1); 
    
    end
%     C = C';
%     L = L';
%     Eglob = Eglob';
%     Eloc = Eloc';
end