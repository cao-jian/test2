function p= get_combination(n,k)
nk = nchoosek(1:n,k);
p=zeros(0,k);
for i=1:size(nk,1),
    pi = perms(nk(i,:));
    p = unique([p; pi],'rows');
end
end