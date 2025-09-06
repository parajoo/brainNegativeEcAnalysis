function mulNodeStars = mulNodesStar345(matInput,node1,node2)
    A_bin = matInput;
    nodes = 1:size(A_bin,1);
    mulNodeStars = zeros(3,2);%(3-node,4-node,5-node Star)*(nodeCond:only67/only68)
    %% 3-node
    node3subAll = nchoosek(nodes, 3);
    idx_keep = any(ismember(node3subAll,[node1,node2]),2);
    node3sub = node3subAll(idx_keep,:); 
    
    for i = 1:size(node3sub,1)
        idx = node3sub(i,:);
        subG = A_bin(idx, idx);
        subG_erzhi = subG;
        subG_erzhi(subG_erzhi~=0) = 1;
        num_edges = nnz(triu(subG,1));

        if num_edges == 2
            if any(idx == node1)
                idx_node1_in_sub = find(idx == node1);
                deg_node1 = sum(subG_erzhi(idx_node1_in_sub, :));
                if deg_node1 == 2
                    mulNodeStars(1,1) = mulNodeStars(1,1)+1;
                end
            elseif any(idx == node2)
                idx_node2_in_sub = find(idx == node2);
                deg_node2 = sum(subG_erzhi(idx_node2_in_sub, :));
                if deg_node2 == 2
                    mulNodeStars(1,2) = mulNodeStars(1,2)+1;
                end
            end
        end
    end
    %% 4-node
    node4subAll = nchoosek(nodes, 4);
    idx_keep = any(ismember(node4subAll,[node1,node2]),2);
    node4sub = node4subAll(idx_keep,:); 
    
    for i = 1:size(node4sub,1)
        idx = node4sub(i,:);
        subG = A_bin(idx, idx);
        subG_erzhi = subG;
        subG_erzhi(subG_erzhi~=0) = 1;
        num_edges = nnz(triu(subG,1));

        if num_edges == 3
            if any(idx == node1)
                idx_node1_in_sub = find(idx == node1);
                deg_node1 = sum(subG_erzhi(idx_node1_in_sub, :));
                if deg_node1 == 3
                    mulNodeStars(2,1) = mulNodeStars(2,1)+1;
                end
            elseif any(idx == node2)
                idx_node2_in_sub = find(idx == node2);
                deg_node2 = sum(subG_erzhi(idx_node2_in_sub, :));
                if deg_node2 == 3
                    mulNodeStars(2,2) = mulNodeStars(2,2)+1;
                end
            end
        end
    end
    %% 5-nodes
    node5subAll = nchoosek(nodes, 5);
    idx_keep = any(ismember(node5subAll,[node1,node2]),2);
    node5sub = node5subAll(idx_keep,:); 
    
    for i = 1:size(node5sub,1)
        idx = node5sub(i,:);
        subG = A_bin(idx, idx);
        subG_erzhi = subG;
        subG_erzhi(subG_erzhi~=0) = 1;
        num_edges = nnz(triu(subG,1));         % 找出节点67在子图中对应的位置（1~5）

        if num_edges == 4
            if any(idx == node1)
                idx_node1_in_sub = find(idx == node1);
                deg_node1 = sum(subG_erzhi(idx_node1_in_sub, :));
                if deg_node1 == 4
                    mulNodeStars(3,1) = mulNodeStars(3,1)+1;
                end
            elseif any(idx == node2)
                idx_node2_in_sub = find(idx == node2);
                deg_node2 = sum(subG_erzhi(idx_node2_in_sub, :));
                if deg_node2 == 4
                    mulNodeStars(3,2) = mulNodeStars(3,2)+1;
                end
            end
        end
    end
end