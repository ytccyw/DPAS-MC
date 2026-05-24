function [ball_min_distAD] = ball_min_dist(ball_distS, ball_densS)
    N3 = size(ball_distS, 1);
    ball_min_distAD = zeros(N3, 1); 
    [~, index_ball_dens] = sort(ball_densS, 'descend');
    
    for i3 = 1:N3
        index = index_ball_dens(i3);
        if i3 == 1
            continue;
        end
        index_ball_higher_dens = index_ball_dens(1:i3-1);
        ball_min_distAD(index) = min(ball_distS(index, index_ball_higher_dens));
    end
    ball_min_distAD(index_ball_dens(1)) = max(ball_min_distAD);
    if max(ball_min_distAD) < 1
        ball_min_distAD = ball_min_distAD * 10;
    end
end