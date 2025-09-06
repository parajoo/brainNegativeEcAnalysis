% clear all
% close all
% load hc_ecne_results.mat
% load lobeVec.mat
% netOrLobeVec = lobeVec;
% matInput = hc_results(6).ecne_new;
% motiConts = mulNodesStar345NetAndLobeL(matInput,netOrLobeVec);
function mulNodeStars = mulNodesStar345NetAndLobe(matInput, netLabels,node1,node2)
    A_bin = matInput;
    nodes = 1:size(A_bin,1);
    mulNodeStars = zeros(3, 2, max(netLabels)); % (3-node,4-node,5-node Star) * (only67/only68) * 6 networks

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
        if num_edges ~= 2
            continue;
        end

        if any(idx == node1) && ~any(idx == node2)
            center_idx = find(idx == node1);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 2
                % 其他两个节点属于同一网络
                others = idx(setdiff(1:3, center_idx));
                if netLabels(others(1)) == netLabels(others(2))
                    net = netLabels(others(1));
                    mulNodeStars(1,1,net) = mulNodeStars(1,1,net) + 1;
                end
            end
        elseif any(idx == node2) && ~any(idx == node1)
            center_idx = find(idx == node2);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 2
                others = idx(setdiff(1:3, center_idx));
                if netLabels(others(1)) == netLabels(others(2))
                    net = netLabels(others(1));
                    mulNodeStars(1,2,net) = mulNodeStars(1,2,net) + 1;
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
        if num_edges ~= 3
            continue;
        end

        if any(idx == node1) && ~any(idx == node2)
            center_idx = find(idx == node1);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 3
                others = idx(setdiff(1:4, center_idx));
                if all(netLabels(others) == netLabels(others(1)))
                    net = netLabels(others(1));
                    mulNodeStars(2,1,net) = mulNodeStars(2,1,net) + 1;
                end
            end
        elseif any(idx == node2) && ~any(idx == node1)
            center_idx = find(idx == node2);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 3
                others = idx(setdiff(1:4, center_idx));
                if all(netLabels(others) == netLabels(others(1)))
                    net = netLabels(others(1));
                    mulNodeStars(2,2,net) = mulNodeStars(2,2,net) + 1;
                end
            end
        end
    end

    %% 5-node
    node5subAll = nchoosek(nodes, 5);
    idx_keep = any(ismember(node5subAll,[node1,node2]),2);
    node5sub = node5subAll(idx_keep,:); 
    
    for i = 1:size(node5sub,1)
        idx = node5sub(i,:);
        subG = A_bin(idx, idx);
        subG_erzhi = subG;
        subG_erzhi(subG_erzhi~=0) = 1;
        num_edges = nnz(triu(subG,1));
        if num_edges ~= 4
            continue;
        end

        if any(idx == node1) && ~any(idx == node2)
            center_idx = find(idx == node1);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 4
                others = idx(setdiff(1:5, center_idx));
                if all(netLabels(others) == netLabels(others(1)))
                    net = netLabels(others(1));
                    mulNodeStars(3,1,net) = mulNodeStars(3,1,net) + 1;
                end
            end
        elseif any(idx == node2) && ~any(idx == node1)
            center_idx = find(idx == node2);
            deg = sum(subG_erzhi(center_idx, :));
            if deg == 4
                others = idx(setdiff(1:5, center_idx));
                if all(netLabels(others) == netLabels(others(1)))
                    net = netLabels(others(1));
                    mulNodeStars(3,2,net) = mulNodeStars(3,2,net) + 1;
                end
            end
        end
    end
end
