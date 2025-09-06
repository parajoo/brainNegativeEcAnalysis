clear all
close all
load('evcNeEcRes.mat','neec_results')
hcRealVsRandom = zeros(3,2,11);
parfor ii = 1:length(neec_results)
    motifReal = starMotifNumReal(neec_results(ii).ec_Hc);
    [hcRealVsRandom(:,:,ii),~] = starMotifvsRandomt(neec_results(ii).ec_Hc,motifReal);
end
function [motifCountsRes,motifNumRandomI] = starMotifvsRandomt(matInput,realConts)
    motifNumRandomI = zeros(100,3);

    for rand = 1:100
        rand100Mat = randmio_und_connected(matInput,5);
        A_bin = rand100Mat;
        nodes = 1:size(A_bin,1);
        motifAllStar = zeros(1,3);
        %% node3
        node3sub = nchoosek(nodes, 3);
        for i=1:size(node3sub,1)
            idx = node3sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 2 && max(degs) == 2
                motifAllStar(1) = motifAllStar(1)+1;
            end
        end
        %% node4
        node4sub = nchoosek(nodes, 4);
        for i=1:size(node4sub,1)
            idx = node4sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 3 && max(degs) == 3
                motifAllStar(2) = motifAllStar(2)+1;
            end
        end
        %% node5
        node5sub = nchoosek(nodes, 5);
        for i=1:size(node5sub,1)
            idx = node5sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 4 && max(degs) == 4
                motifAllStar(3) = motifAllStar(3)+1;
            end
        end

        motifNumRandomI(rand,:) = motifAllStar;
    end
    motifCountsRes(:,1) = ((realConts - mean(motifNumRandomI)) ./ std(motifNumRandomI))';
    motifCountsRes(:,2) = (sum(motifNumRandomI>=realConts)/100)';
end
function motifRealNum = starMotifNumReal(matInput)
        A_bin = matInput;
        nodes = 1:size(A_bin,1);
        motifRealNum = zeros(1,3);
        %% node3
        node3sub = nchoosek(nodes, 3);
        for i=1:size(node3sub,1)
            idx = node3sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 2 && max(degs) == 2
                motifRealNum(1) = motifRealNum(1)+1;
            end
        end
        %% node4
        node4sub = nchoosek(nodes, 4);
        for i=1:size(node4sub,1)
            idx = node4sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 3 && max(degs) == 3
                motifRealNum(2) = motifRealNum(2)+1;
            end
        end
        %% node5
        node5sub = nchoosek(nodes, 5);
        for i=1:size(node5sub,1)
            idx = node5sub(i,:);
            subG = A_bin(idx, idx);
            subG_erzhi = subG;
            subG_erzhi(subG_erzhi~=0) = 1;
            num_edges = nnz(triu(subG,1));
            degs = sum(subG_erzhi,2);
            if num_edges == 4 && max(degs) == 4
                motifRealNum(3) = motifRealNum(3)+1;
            end
        end
end