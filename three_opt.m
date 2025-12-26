function result=three_opt(route,comb)
len=length(route);
result=zeros(8,len);
a=comb(1);
c=comb(2);
e=comb(3);
b=a+1;
d=c+1;
f=e+1;
result(1,:)=[route(1:a) route(b:c) route(d:e) route(f:end)];

result(2,:)=[route(1:a) route(b:c) route(e:-1:d) route(f:end)];

result(3,:)=[route(1:a) route(c:-1:b) route(d:e) route(f:end)];

result(4,:)=[route(1:a) route(c:-1:b) route(e:-1:d) route(f:end)];

result(5,:)=[route(1:a) route(d:e) route(b:c) route(f:end)];

result(6,:)=[route(1:a) route(d:e) route(c:-1:b) route(f:end)];

result(7,:)=[route(1:a) route(e:-1:d) route(b:c) route(f:end)];

result(8,:)=[route(1:a) route(e:-1:d) route(c:-1:b) route(f:end)];

end