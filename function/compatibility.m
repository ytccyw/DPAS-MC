function A_com = compatibility(A, weidu)
    num_A = length(A);
    A_com = cell(1, num_A);
    
    for v = 1:num_A
        A_com{v} = pca(A{v}', 'NumComponents', weidu);
        num_rows = size(A_com{v}, 1);
        
        rows = (1:num_rows)';
        digits = floor(log10(rows)) + 1;
        new_col = (v * 10.^digits + rows) / 1e10 + 1;
        
        A_com{v} = [A_com{v}, new_col];
    end
end