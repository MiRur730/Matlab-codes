C=[ 3 5];
A=[1 2 ; 1 1 ; 0 1];
b=[2000; 1500; 600; 0];

Ineqsign=[0 0 1]; % all with less sign as 0 

s=eye(size(A,1));
ind=find(Ineqsign > 0); 
% find location where ineq is greater than 0
s(ind,:)=-s(ind,:);

A=[A s];
objFns=array2table(A);
objFns.Properties.VariableNames(1:size(A,2))=["x_1","x2","s1","s2","s3"];
