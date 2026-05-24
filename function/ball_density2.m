function ball_dens2 = ball_density2(radiusAD, ball_qualitysA, mean_rs)
    ball_dens2 = zeros(size(radiusAD));
    non_zero_mask = (radiusAD ~= 0);
    ball_dens2(non_zero_mask) = ball_qualitysA(non_zero_mask) ./ ...
                               (radiusAD(non_zero_mask).^2 .* mean_rs(non_zero_mask));
end