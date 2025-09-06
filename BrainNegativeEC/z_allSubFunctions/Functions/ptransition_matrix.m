function ptrans = ptransition_matrix(IDX,cluster_num)
    ptrans=zeros(cluster_num,cluster_num);
    i=1;
    ind_sort = 1:cluster_num;
    for c1=ind_sort
        j=1;
        for c2=ind_sort
            sumatr=0;
            for t=1:length(IDX)-1
                if IDX(t)==c1 && IDX(t+1)==c2
                    sumatr=sumatr+1;
                end
            end
            if length(find(IDX(1:length(IDX)-1)==c1)) ~= 0
                ptrans(i,j)=sumatr/(length(find(IDX(1:length(IDX)-1)==c1)));
            end
            j=j+1;
        end
        i=i+1;
    end
end