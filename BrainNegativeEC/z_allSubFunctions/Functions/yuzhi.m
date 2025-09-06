function [SC1] = yuzhi(t,SC)
    SC1=SC;
    nn = size(SC);
    max_num = max(max(SC));
    nn = nn(1) ;
    for i = 1:nn
        for j = 1:nn
            if SC(i,j) < t * max_num
                SC1(i,j) = 0;
            end
        end
    end
    
          
            