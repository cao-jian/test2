a=[
1	1	1	1	1	1
1	1	1	1	2	2
1	1	1	1	3	3
1	2	2	2	1	1
1	2	2	2	2	2
1	2	2	2	3	3
1	3	3	3	1	1
1	3	3	3	2	2
1	3	3	3	3	3
2	1	2	3	1	2
2	1	2	3	2	3
2	1	2	3	3	1
2	2	3	1	1	2
2	2	3	1	2	3
2	2	3	1	3	1
2	3	1	2	1	2
2	3	1	2	2	3
2	3	1	2	3	1
3	1	3	2	1	3
3	1	3	2	2	1
3	1	3	2	3	2
3	2	1	3	1	3
3	2	1	3	2	1
3	2	1	3	3	2
3	3	2	1	1	3
3	3	2	1	2	1
3	3	2	1	3	2
];
alpha=[0.1 1 10];
beta=[0.1 1 10];
gamma=[0.1 1 10];
delta1=[1.2 4 9];
delta2=[1.1 3 8];
maxLen=[0.2 0.5 1];
result=zeros(27,6);
for i=1:27
    for j=1:6
        if j==1
            result(i,1)=alpha(a(i,j));
        elseif j==2
            result(i,2)=gamma(a(i,j));
        elseif j==3
            result(i,3)=beta(a(i,j));
        elseif j==4
            result(i,4)=delta1(a(i,j));
        elseif j==5
            result(i,5)=delta2(a(i,j));
        else
            result(i,6)=maxLen(a(i,j));
        end
    end
end