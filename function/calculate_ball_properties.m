function [centersA, radiusA, ball_qualitysA, mean_rs] = calculate_ball_properties(gb_list)
centers = [];
radius = [];
ball_qualitys = [];
mean_rs = [];
for i = 1:length(gb_list)
    gb = gb_list{i};
    center = mean(gb, 1);
    radi = max(sqrt(sum((gb - center).^2, 2)));
    ball_quality = size(gb, 1);
    Distances = sqrt(sum((gb - center).^ 2, 2));
    mean_r = mean(Distances); 
    centers = [centers; center];
    radius = [radius; radi];
    ball_qualitys = [ball_qualitys; ball_quality];
    mean_rs = [mean_rs; mean_r];
end

centersA = centers;
radiusA = radius;
ball_qualitysA = ball_qualitys;
end