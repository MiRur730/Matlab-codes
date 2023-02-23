A=[2 3 -1 4 ; 1 -2 6 -7];
b=[8; -3];
C=[2 3 4 7];
m=size(A,1);% no of constraints , rows
n=size(A,2);% no of variables , columns
nv=nchoosek(n,m); % count of pairs
t=nchoosek(1:n,m);% pairs

if(n>=m)
  sol=[]; 
  for i=1:nv
      y=zeros(n,1);
      x=A(:,(t(i,:)))\b;
      
      if all(x>=0 & x~=inf & x~=-inf)
        y(t(i,:))=x;  
        sol=[sol y];
      end    
  end    

else
    error("n is not greater than m,equation is larger than variables")
    
end  

Z=C*sol;
[val , loc]=max(Z);
