function result=feasible(leav,wait,bs)
temp=cumsum(wait);
temp1=leav-bs;
temp1(temp1<0)=0;
result=min(temp1+temp);
result=min(result,sum(wait));
end