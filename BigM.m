% Big M method
clc;
clear all; 
M=1000;
cost=[5 3 0 0 0 -M 0];
a=[1 1 1 0 0 0;5 2 0 1 0 0;2 8 0 0 -1 1];
b=[2;10;12];
artifical_var=[6];  
bv=[3 4 6];
A=[a b];
var={'x1','x2','s1','s2','s3','A1','sol'};
zjcj=cost(bv)*A-cost;
simplex_table=[zjcj; A];
array2table(simplex_table,"VariableNames", var)
run=true;
 while run
    if any(zjcj(1:end-1) < 0)
        fprintf('Soln is not optimal.');
        zc = zjcj(1:end-1);
        [Enter_Value, pvt_col] = min(zc);
        if all(A(:, pvt_col) <= 0)
            error('LPP is unbounded');
        else
            sol = A(:, end);
            column = A(:, pvt_col);
            for i = 1:size(A, 1)
                if column(i) > 0
                    ratio(i) = sol(i)./column(i); %#ok<*SAGROW> 
                else 
                    ratio(i) = inf;
                end
            end
            [leaving_value, pvt_row] = min(ratio);
        end
        bv(pvt_row) = pvt_col;
        pvt_key = A(pvt_row, pvt_col);
        A(pvt_row, :) = A(pvt_row, :) ./ pvt_key;
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = cost(bv) * A - cost;
        nest_table = [A; zjcj];
        array2table(nest_table, "VariableNames",var)
    else
          run = false;
       fprintf('Optimal sol is %f\n', zjcj(end));
end
end

