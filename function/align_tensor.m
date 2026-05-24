function gb_list = align_tensor(A_com)
    V = length(A_com);
    pin_A = vertcat(A_com{:});
    min_mao = min(cellfun(@(x) size(x, 1), A_com));
    
    gb_list = {pin_A};
    
    while length(gb_list) <= min_mao
        gb_list = fen(gb_list, V);
    end
    
    for i = 1:length(gb_list)
        now_val = gb_list{i}(:, end);
        [shitu_index, mao_index] = huifu_zhenshisuoyin(now_val);
        gb_list{i} = [shitu_index, mao_index];
    end
end

function gb_list_new = fen(gb_list, V)
    gb_list_new = {};
    for i = 1:length(gb_list)
        gb = gb_list{i};
        if size(gb, 1) > V
            gb_list_new = [gb_list_new, fen_ball(gb)];
        else
            gb_list_new{end+1} = gb;
        end
    end
end

function ball_list = fen_ball(gb)
    splits_k = 2;
    unique_gb = unique(gb, 'rows');
    splits_k = min(splits_k, size(unique_gb, 1));
    
    label = kmeans(gb, splits_k, 'Replicates', 1);
    ball_list = cell(1, splits_k);
    
    for k = 1:splits_k
        ball_list{k} = gb(label == k, :);
    end
end

function [firstDigits, maoindex] = huifu_zhenshisuoyin(now_val)
    now_val = (now_val - 1) * 1e10;
    n = length(now_val);
    firstDigits = zeros(n, 1);
    maoindex = zeros(n, 1);
    
    for ii = 1:n
        numStr = num2str(now_val(ii));
        firstDigits(ii) = str2double(numStr(1));
        maoindex(ii) = str2double(numStr(2:end));
    end
end