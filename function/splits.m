function [gb_list_new] = splits(gb_list, num)
    gb_list_new = {};
    for i = 1:length(gb_list)
        gb = gb_list{i};
        p = size(gb,1);
        if p < num
            gb_list_new{end+1} = gb;
        else
            sub_balls = splits_ball(gb);
            gb_list_new = [gb_list_new, sub_balls];
        end
    end
end