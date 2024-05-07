clc
clear all;
a=[1 2 1 0 0;1 1 0 1 0;1 -1 0 0 1];
b=[10; 6; 2];
cost=[2 1 0 0 0 0];
A=[a,b];
BV=[3 4 5];
Var={'x1','x2','s1','s2','s3','sol'};
zjcj=cost(BV)*A-cost;
simplex_table=[A;zjcj];
array2table(simplex_table,'VariableNames',Var)
RUN=true;
while RUN
    if any(zjcj(1:end-1)<0)
        fprintf('Current BFS is not optimal')
        zc=zjcj(1:end-1);
        [Enter_value pvt_col]=min(zc);
        if all(A(:,pvt_col)<0)
            error('LPP is unbounded')
        else
            Sol=A(:,end);
            Column=A(:,pvt_col);
            for i=1:size(A,1)
                if (Column(i)>0)
                    Ratio(i)=Sol(i)./Column(i);
                else 
                    Ratio(i)=inf;
                end
            end
        [leaving_value pvt_row]=min(Ratio);
        end
    BV(pvt_row)=pvt_col;
    pvt_key=A(pvt_row,pvt_col);
            A(pvt_row, :) = A(pvt_row, :) ./ pvt_key;
    for i=1:size(A,1)
      if  i~=pvt_key;
        A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:);
      end
    end
    
    zjcj=cost(BV)*A-cost
    next_table=[zjcj;A]
    array2table(next_table,'VariableNames',Var)
    else
       RUN=false;
        fprintf('Optimal sol is %f\n',zjcj(end))
end
end
