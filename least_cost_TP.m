clc
clear all
c=[6 4 1 5;8 9 2 7;4 3 6 4] //table
a=[14; 16; 5];//rows
b=[6 10 15 4]; //columns
m=size(c,1);
n=size(c,2);
z=0;
if sum(a)==sum(b)
    fprintf('Given transportation problem is Balanced \n');
else
     fprintf('Given transportation problem is Unbalanced \n');
     if sum(a)<sum(b) //add dummy row
         c(end+1,:)=zeros(1,length(b))
         a(end+1)=sum(b)-sum(a)
     else//dummy column
         c(:,end+1)=zeros(length(a),1)
         b(end+1)=sum(a)-sum(b)
  end
end


X=zeros(size(c));
// X=zeros(m,n)
[m,n]=size(c); //rows and columns
BFS=m+n-1;


InitialC=c
   for i=1:size(c,1)
       for j=1:size(c,2)
    cpq=min(c(:))
    if cpq==Inf
    break
       end
       //finding index where value is min 
[p1,q1]=find(cpq==c) //p1 q1 are row and column
// 15 25 35
xpq=min(a(p1),b(q1)) //minimum of a and b at that point is stored in xpq
//30 30 30
[X1,ind]=max(xpq)  //finding max of all xpq values
// 30 max
p=p1(ind)// row index of index
q=q1(ind)//column index of index

X(p,q)=min(a(p),b(q))
//min of 30 50 
if min(a(p),b(q))==a(p)
b(q)=b(q)-a(p)
a(p)=a(p)-X(p,q)
c(p,:)=Inf
else
    a(p)=a(p)-b(q)
    b(q)=b(q)-X(p,q)
    // c(p,q)=Inf;
    c(:,q)=Inf
end
end
end



//initial transportation cost
InitialCost=sum(sum(InitialC.*X));
fprintf('Transportation cost is %f \n',InitialCost);

//checking degenerate
TotalBFS=length(nonzeros(X));
if TotalBFS==BFS
 fprintf('Non degerenerate');
 else
fprintf(' degerenerate');
end