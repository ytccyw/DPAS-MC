function [ball_list] = splits_ball(gb)
splits_k = 2;
ball_list = {};
unique_gb = unique(gb, 'rows');

if size(unique_gb,1) < splits_k
    splits_k = size(unique_gb,1);
end
label = litekmeans(gb, splits_k, 'Replicates', 1); 

for k = 1:splits_k
    KK=label == k;
    ball_list{end+1} = gb(KK, :);
end
end