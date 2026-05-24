function maodian = anchor_select(data, miyu)
    N = size(data, 1);
    num = ceil(sqrt(N));
    gb_list = {data};
    
    prev_len = 0;
    while prev_len ~= length(gb_list)
        prev_len = length(gb_list);
        gb_list = splits(gb_list, num);
    end
    
    [centersA, radiusA, ball_qualitysA, mean_rs] = calculate_ball_properties(gb_list);
    
    ball_densS = ball_density2(radiusA, ball_qualitysA, mean_rs);
    ball_distS = pdist2(centersA, centersA);
    ball_min_distS = ball_min_dist(ball_distS, ball_densS);
    
    fengzhi_juece = ball_densS .* ball_min_distS;
    [~, index_feng] = sort(fengzhi_juece, 'descend');
    
    mao_yuzhi = floor(length(index_feng) * miyu);
    maodian = centersA(index_feng(1:mao_yuzhi), :);
end