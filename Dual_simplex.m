clc;
clear all; 
cost = [-2 0 -1 0 0 0];
a = [-1 -1 1 1 0; -1 2 -4 0 1];
b = [-5; -8];
bv = [4 5];
var = {'x1', 'x2', 'x3', 's1', 's2', 'sol'};
A = [a b];
zjcj = cost(bv)*A - cost;
simplex_table = [zjcj; A];
array2table(simplex_table, "VariableNames",var)
run = true;
while run
     sol = A(:, end);
     if(any(sol < 0))
         fprintf('Current BFS is not feasible.');
         [leaving_val, pvt_row] = min(sol);
         for i = 1:size(A, 2) - 1
             if A(pvt_row, i) < 0
                 ratio(i) = abs(zjcj(i)./A(pvt_row, i)); 
             else
                 ratio(i) = inf;
             end
         end
         [entering_val, pvt_col] = min(ratio);
          bv(pvt_row) = pvt_col;
         pvt_key = A(pvt_row, pvt_col);
         A(pvt_row, :) = A(pvt_row, :)./pvt_key;
         for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = cost(bv) * A - cost;
        next_table = [zjcj; A];
        array2table(next_table, "VariableNames",var)
     else
         run = false;
         fprintf('Current BFS is feasible');
end
end