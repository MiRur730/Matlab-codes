A=[1 2;1 1;1 -1;1 -2];  % Graphical Method
B=[10;6;2;1];
C=[2 1];
m=max(B);

x1=0:1:m;
x21=(B(1)-A(1,1)*x1)/A(1,2);
x22=(B(2)-A(2,1)*x1)/A(2,2);
x23=(B(3)-A(3,1)*x1)/A(3,2);
x24=(B(4)-A(4,1)*x1)/A(4,2);

x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
x24=max(0,x24);


plot(x1,x21,'r',x1,x22,'g',x1,x23,'b',x1,x24,'y');
legend('x1+2x2>=10','x1+x2<=6','x1-x2<=2','x1-2x2<=1');
grid on
xlabel('x1');
ylabel('x2');
A=[A;1 0;0 1];
B=[B;0;0];

sol=[];

for i=1:size(A,1)
    A1=A(i,:);
    B1=B(i,:);
    for j=i+1:size(A,1)
        A2=A(j,:);
        B2=B(j,:);
        A3=[A1;A2];
        B3=[B1;B2];
        X=A3\B3;
        sol=[sol X];
    end
 end
sol;
x1=sol(1,:);
x2=sol(2,:);

cons1=x1+2.*x2-10;
h1=find(cons1>0);
sol(:,h1)=[];
x1=sol(1,:);
x2=sol(2,:);

cons2=x1+x2-6;
h2=find(cons2>0);
sol(:,h2)=[];
x1=sol(1,:);
x2=sol(2,:);

cons3=x1-x2-2;
h3=find(cons3>0);
sol(:,h3)=[];
x1=sol(1,:);
x2=sol(2,:);

cons4=x1-2.*x2-1;
h4=find(cons4>0);
sol(:,h4)=[];
x1=sol(1,:);
x2=sol(2,:);

h5=find(x1<0);
sol(:,h5)=[];
x1=sol(1,:);
x2=sol(2,:);

h6=find(x2<0);
sol(:,h6)=[];
x1=sol(1,:);
x2=sol(2,:);
sol;


% for i=1:size(sol,2)
%     Fx(:,i)=C(1)*sol(1,i)+C(2)*sol(2,i);
% end
% result=max(Fx);
% a=find(Fx==result);
% points=sol(:,a);
% points;
% result;
Z=C*sol;

[val ,loc]=max(Z);
t=sol(:,loc);
fprintf("The optimal sol is %f and %f",t(1),t(2));
fprintf('\nThe optimal value is %f',val);
